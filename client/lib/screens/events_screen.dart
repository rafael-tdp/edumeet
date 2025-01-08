import 'dart:async';

import 'package:client/core/models/user.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/event_details_page.dart';
import 'package:client/utils/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/event_card.dart';
import 'package:client/screens/create_event_screen.dart';
import 'package:client/core/models/event.dart';
import 'package:client/core/services/user_services.dart';
import 'package:go_router/go_router.dart';

import '../core/models/response.dart';
import '../utils/connectivty_utils.dart';

class EventsPage extends StatefulWidget {
  static const String routeName = '/events';
  static navigateTo(BuildContext context, {String? action}) {
    context.go(routeName, extra: action);
  }

  const EventsPage({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Future<List<Event>>? _eventsFuture;
  bool _showOnlyMyEvents = false;
  User? _currentUser;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    ConnectivityUtils.listenConnectivityChanges(onConnected: () {
      _fetchCurrentUser();
      _fetchEvents();
    }, onDisconnected: () {
      _fetchCurrentUserOffline();
      _fetchEventsOffline();
    });
  }

  @override
  void dispose() {
    ConnectivityUtils.cancelSubscription();
    super.dispose();
  }

  void _fetchCurrentUser() async {
    try {
      final response = await UserServices().getUserInfo();
      if (!mounted) return;
      setState(() {
        _currentUser = response.data;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not loaded")),
      );
    }
  }

  void _fetchCurrentUserOffline() async {
    try {
      final response = await UserServices().getUserInfoFromCache();
      if (!mounted) return;
      setState(() {
        _currentUser = response.data;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not loaded")),
      );
    }
  }

  Future<void> _fetchEvents() async {
    if (_showOnlyMyEvents) {
      _eventsFuture = EventServices.getEventsCreatedByCurrentUser();
    } else {
      _eventsFuture = EventServices.getCurrentUserEvents();
    }
  }

  Future<void> _fetchEventsOffline() async {
    if (_showOnlyMyEvents) {
      _eventsFuture = EventServices.getEventsCreatedByCurrentUserFromCache();
    } else {
      _eventsFuture = EventServices.getCurrentUserEventsFromCache();
    }
  }

  void _openEventPage(
      BuildContext context, String eventId, String participantStatus) {
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not loaded")),
      );
      return;
    }
    if (participantStatus == "PENDING") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Vous devez être accepté pour voir les détails")),
      );
      return;
    }
    context.push(
      '${EventsPage.routeName}/$eventId/details',
      extra: _currentUser,
    );
  }

  void _createEvent(context) {
    CreateEventPage.navigateTo(context);
  }

  void _showJoinEventDialog() {
    final TextEditingController codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rejoindre un événement"),
          content: TextField(
            controller: codeController,
            decoration: const InputDecoration(hintText: "Code de l'événement"),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                final code = codeController.text.trim();
                if (code.isNotEmpty) {
                  try {
                    final result = await EventServices.joinEventWithCode(code);
                    if (result["event"] != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Vous avez rejoint l'événement")),
                      );
                      // Navigator.of(context).pop();
                      await Future.delayed(const Duration(seconds: 1));
                      EventDetailsPage.navigateTo(
                          context, result["event"]["id"], _currentUser!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Code invalide")),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Impossible d'utiliser ce code")),
                    );
                  }
                }
              },
              child: const Text("Rejoindre"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Recherche...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _showOnlyMyEvents ? Icons.filter_list_off : Icons.filter_list,
            ),
            color: AppColors.purple,
            onPressed: () {
              setState(() {
                _showOnlyMyEvents = !_showOnlyMyEvents;
                ConnectivityUtils.listenConnectivityChanges(onConnected: () {
                  _fetchEvents();
                }, onDisconnected: () {
                  _fetchEventsOffline();
                });
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _createEvent(context),
            color: AppColors.purple,
          ),
          IconButton(
            icon: const Icon(Icons.add_link),
            onPressed: _showJoinEventDialog,
            color: AppColors.purple,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text(t.error.loadingEvents));
          }

          final events = snapshot.data!;

          if (events.isEmpty) {
            return const Center(child: Text("Aucun événement trouvé."));
          }

          // Filtrer les événements selon la recherche
          final filteredEvents = events.where((event) {
            return event.title.toLowerCase().contains(_searchQuery);
          }).toList();

          final now = DateTime.now();

          final pendingEvents = filteredEvents
              .where((event) => event.participantStatus == "PENDING")
              .where(
                  (element) => DateTime.parse(element.startDate).isAfter(now))
              .toList();

          final upcomingEvents = filteredEvents
              .where((event) => event.participantStatus == "ACCEPTED")
              .where((event) => DateTime.parse(event.startDate).isAfter(now))
              .toList();
          final pastEvents = filteredEvents
              .where((event) => event.participantStatus == "ACCEPTED")
              .where((event) => DateTime.parse(event.startDate).isBefore(now))
              .toList();

          return ListView(
            children: [
              if (pendingEvents.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Événements en attente",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pendingEvents.length,
                    itemBuilder: (context, index) {
                      final event = pendingEvents[index];
                      return GestureDetector(
                        onTap: () => _openEventPage(
                            context, event.id!, event.participantStatus),
                        child: SizedBox(
                          width: 300,
                          child: EventCard(
                            title: event.title,
                            date: event.startDate,
                            imageUrl: event.image ?? '',
                            participants: event.participantsCount.toString(),
                            isCurrentUserEvent:
                                event.createdBy == _currentUser!.id,
                            participantStatus: event.participantStatus,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (upcomingEvents.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Événements à venir",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ...upcomingEvents.map((event) {
                  return GestureDetector(
                    onTap: () => _openEventPage(
                        context, event.id!, event.participantStatus),
                    child: EventCard(
                      title: event.title,
                      date: event.startDate,
                      imageUrl: event.image ??
                          'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmFpbHxlbnwwfHwwfHx8Mg%3D%3D',
                      participants: event.participantsCount.toString(),
                      isCurrentUserEvent: event.createdBy == _currentUser!.id,
                      participantStatus: event.participantStatus,
                    ),
                  );
                }).toList(),
              ],
              if (pastEvents.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Événements passés",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ...pastEvents.map((event) {
                  return GestureDetector(
                    onTap: () => _openEventPage(
                        context, event.id!, event.participantStatus),
                    child: EventCard(
                      title: event.title,
                      date: event.startDate,
                      imageUrl: event.image ??
                          'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmFpbHxlbnwwfHwwfHx8Mg%3D%3D',
                      participants: event.participantsCount.toString(),
                      isCurrentUserEvent: event.createdBy == _currentUser!.id,
                      participantStatus: event.participantStatus,
                    ),
                  );
                }).toList(),
              ],
            ],
          );
        },
      ),
    );
  }
}

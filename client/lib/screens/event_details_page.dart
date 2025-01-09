import 'dart:async';

import 'package:client/core/models/event.dart';
import 'package:client/core/models/user.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/edit_event_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/widgets/event/event_header.dart';
import 'package:client/widgets/event/participants_list.dart';
import 'package:client/widgets/event/messages_preview.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/widgets/event/resources_section.dart';
import 'package:client/widgets/event/event_details_section.dart';
import 'package:go_router/go_router.dart';
import 'package:client/components/confirmation_dialog.dart';

import '../utils/connectivty_utils.dart';
import '../widgets/banner_message.dart';
import 'events_screen.dart';

class EventDetailsPage extends StatefulWidget {
  static const String routeName = 'details';
  static navigateTo(BuildContext context, String eventId, User currentUser) {
    context.go(
      '${EventsPage.routeName}/$eventId/$routeName',
      extra: currentUser,
    );
  }

  final String eventId;
  final User currentUser;

  const EventDetailsPage({
    super.key,
    required this.eventId,
    required this.currentUser,
  });

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarExpanded = false;
  Future<Event>? _eventFuture;
  late bool isCurrentUserEvent;
  bool shouldRefresh = false;
  bool _isConnected = false;
  bool _showReconnectBanner = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isExpanded = _scrollController.hasClients &&
          _scrollController.offset > (300 - kToolbarHeight);
      if (isExpanded != _isAppBarExpanded) {
        setState(() {
          _isAppBarExpanded = isExpanded;
        });
      }
    });
    _checkConnectivity();
    ConnectivityUtils.listenConnectivityChanges(
      onConnected: () {
        if (!_isConnected) {
          setState(() {
            _isConnected = true;
            _showReconnectBanner = true;
          });
          Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              _showReconnectBanner = false;
            });
          });
        }
        _fetchEvent();
      },
      onDisconnected: () {
        _fetchEventOffline();
        setState(() {
          _isConnected = false;
          _showReconnectBanner = true;
        });
      },
    );
  }

  void _checkConnectivity() async {
    _isConnected = await ConnectivityUtils.isConnected();
    _showReconnectBanner = !_isConnected;
  }

  void _fetchEvent() {
    _eventFuture = EventServices.getEventDetails(widget.eventId).then((event) {
      isCurrentUserEvent = event.createdBy == widget.currentUser.id;
      return event;
    });
    setState(() {});
  }

  void _fetchEventOffline() {
    _eventFuture = EventServices.getEventDetailsFromCache(widget.eventId).then((event) {
      isCurrentUserEvent = event.createdBy == widget.currentUser.id;
      return event;
    });
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    ConnectivityUtils.cancelSubscription();
    super.dispose();
  }

  void _navigateToChat(BuildContext context, Event event) {
    EventChatPage.navigateTo(context, event.id!);
  }

  Widget _buildNoEventFound() {
    return const Center(
        child: Text('Aucun évenement trouvée'));
  }

  Widget _buildEvent(Event event, String? currentParticipantId) {
    return Column(
      children: [
        EventDetailsSection(
          eventDate: event.startDate,
          address: event.physicalEvent?['location'],
          link: event.remoteEvent?['url'],
          code: isCurrentUserEvent ? event.code : null,
        ),
        const SizedBox(height: 20),
        AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 500),
          child: ParticipantsList(
            participants: event.participants ?? const [],
            isCurrentUserEvent: isCurrentUserEvent,
          ),
        ),
        const SizedBox(height: 20),
        AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 500),
          child: MessagesPreview(
            messages: event.lastMessages ?? const [],
            onSeeAllMessages: () => _navigateToChat(context, event),
          ),
        ),
        const SizedBox(height: 20),
        ResourcesSection(
          resources: event.documents ?? const [],
          eventId: event.id!,
        ),
        const SizedBox(height: 20),
        // Leave button
        if (!isCurrentUserEvent)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () async {

                  final bool? confirmed =
                  await ConfirmationDialog.show(
                    context,
                    title: "Quitter l'événement",
                    message:
                    "Êtes-vous sûr de vouloir quitter cet événement ? Cette action est irréversible.",
                    confirmText: "Quitter",
                    cancelText: "Annuler",
                    confirmColor: Colors.red,
                    icon: Icons.warning,
                  );

                  if (confirmed != true) return;

                  if (currentParticipantId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Participant introuvable.'),
                      ),
                    );
                    return;
                  }

                  EventServices.leaveEvent(currentParticipantId)
                      .then((_) {
                    if (!mounted) return;
                    EventsPage.navigateTo(context);
                  }).catchError((e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erreur: ${e.toString()}'),
                      ),
                    );
                  });
                },
                child: const Text(
                  "Quitter l'événement",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

        // Delete button
        if (isCurrentUserEvent)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () async {
                  final bool? confirmed =
                  await ConfirmationDialog.show(
                    context,
                    title: "Supprimer l'événement",
                    message:
                    "Êtes-vous sûr de vouloir supprimer cet événement ? Cette action est irréversible.",
                    confirmText: "Supprimer",
                    cancelText: "Annuler",
                    confirmColor: Colors.red,
                    icon: Icons.warning,
                  );

                  if (confirmed != true) return;

                  EventServices.deleteEvent(event.id!).then((_) {
                    if (!mounted) return;
                    EventsPage.navigateTo(context);
                  }).catchError((e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erreur: ${e.toString()}'),
                      ),
                    );
                  });
                },
                child: const Text(
                  "Supprimer l'événement",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Event>(
        future: _eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(t.error.details(error: snapshot.error.toString())),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text(t.error.no_events_found));
          }

          final event = snapshot.data!;
          String? currentParticipantId;

          if (!event.id!.isEmpty) {
            currentParticipantId = event.participants!.firstWhere(
                (participant) =>
                    participant['user']['id'] == widget.currentUser.id,
                orElse: () => null)?['id'];
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                flexibleSpace:
                    event.id!.isNotEmpty ?
                FlexibleSpaceBar(
                  background: EventHeader(
                    date: event.startDate,
                    image: event.image ??
                        'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmFpbHxlbnwwfHwwfHx8Mg%3D%3D',
                    title: event.title ?? '',
                    description: event.description ?? '',
                    participantsCount: event.participantsCount ?? 0,
                  ),
                ) : null,
                pinned: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: _isAppBarExpanded ? Colors.black : Colors.white,
                    weight: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(shouldRefresh);
                  },
                ),
                actions: [
                  if (isCurrentUserEvent)
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: _isAppBarExpanded ? Colors.black : Colors.white,
                      ),
                      onPressed: () async {
                        shouldRefresh = await context.push(
                          '${EventsPage.routeName}/${event.id}${EditEventPage.routeName}',
                        ) as bool;
                        if (shouldRefresh == true) {
                          setState(() {
                            _eventFuture =
                                EventServices.getEventDetails(event.id!);
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 12),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerMessage(
                      isVisible: _showReconnectBanner,
                      message: _isConnected ? t.app.offlineVerifyConnection : t.app.offlineVerifyConnection,
                      backgroundColor: _isConnected ? Colors.green : Colors.red,
                    ),
                    //si event.id est vide, on affiche un message d'erreur
                    if (event.id!.isEmpty)
                      _buildNoEventFound(),
                    if (event.id!.isNotEmpty)
                      _buildEvent(event, currentParticipantId),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
import 'package:client/core/models/user.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/components/event_card.dart';
import 'package:client/screens/event_details_page.dart';
import 'package:client/screens/create_event_screen.dart';
import 'package:client/core/models/event.dart';
import 'package:client/core/services/user_services.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool _showOnlyMyEvents = false;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() {
    UserServices().getUserInfo().then((value) {
      setState(() {
        _currentUser = value.data;
      });
    });
  }

  void _openEventPage(String eventId) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: EventDetailsPage(eventId: eventId),
          );
        },
      ),
    );
  }

  void _createEvent() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CreateEventPage()),
    );
  }

  Future<List<Event>> _fetchEvents() {
    return _showOnlyMyEvents
        ? EventServices.getEventsCreatedByCurrentUser()
        : EventServices.getCurrentUserEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        actions: [
          // TextButton.icon(
          //   icon: Icon(
          //     _showOnlyMyEvents ? Icons.filter_list_off : Icons.filter_list,
          //     color: AppColors.purple,
          //   ),
          //   label: const Text(
          //     "Mes événements",
          //     style: TextStyle(color: AppColors.purple),
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       _showOnlyMyEvents = !_showOnlyMyEvents;
          //     });
          //   },
          // ),
          IconButton(
            icon: Icon(
              _showOnlyMyEvents ? Icons.filter_list_off : Icons.filter_list,
            ),
            color: AppColors.purple,
            onPressed: () {
              setState(() {
                _showOnlyMyEvents = !_showOnlyMyEvents;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createEvent,
            color: AppColors.purple,
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: _fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text(t.error.loadingEvents));
          }

          final events = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return GestureDetector(
                        onTap: () => _openEventPage(event.id),
                        child: EventCard(
                          title: event.title,
                          date: event.startDate,
                          imageUrl: event.image,
                          participants: event.participantsCount.toString(),
                          isCurrentUserEvent: _currentUser != null &&
                              event.createdBy == _currentUser!.id,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

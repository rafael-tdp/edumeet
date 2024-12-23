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
import 'package:go_router/go_router.dart';

class EventsPage extends StatefulWidget {
  static const String routeName = '/events';
  static navigateTo(BuildContext context) {
    context.go(routeName);
  }
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

  void _fetchCurrentUser() async {
    try {
      final response = await UserServices().getUserInfo();
      setState(() {
        _currentUser = response.data;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not loaded")),
      );
    }
  }

// void _openEventPage(BuildContext context, String eventId) {
//   if (_currentUser == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("User not loaded")),
//     );
//     return;
//   }
//
//   EventDetailsPage.navigateTo(context, eventId, _currentUser!);
// }
  void _openEventPage(BuildContext context, String eventId) {
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not loaded")),
      );
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) {
          // context.go(EventDetailsPage.routeName, extra: {eventId, _currentUser});
          EventDetailsPage.navigateTo(context, eventId, _currentUser!);
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child:
                EventDetailsPage(eventId: eventId, currentUser: _currentUser!),
          );
        },
      ),
    );
  }

  void _createEvent() {
    context.go(CreateEventPage.routeName);
  }

  Future<List<Event>> _fetchEvents() {
    return _showOnlyMyEvents
        ? EventServices.getEventsCreatedByCurrentUser()
        : EventServices.getCurrentUserEvents();
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

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return GestureDetector(
                onTap: () => _openEventPage(context, event.id),
                child: EventCard(
                  title: event.title,
                  date: event.startDate,
                  imageUrl: event.image,
                  participants: event.participantsCount.toString(),
                  isCurrentUserEvent: event.createdBy == _currentUser!.id,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:client/core/models/user.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/components/event_card.dart';
import 'package:client/screens/create_event_screen.dart';
import 'package:client/core/models/event.dart';
import 'package:client/core/services/user_services.dart';
import 'package:go_router/go_router.dart';

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
  bool _showOnlyMyEvents = false;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _fetchEvents();
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
    context.push(
      '${EventsPage.routeName}/$eventId/details',
      extra: _currentUser,
    );
  }

  void _createEvent(context) {
    CreateEventPage.navigateTo(context);
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
            onPressed: () => _createEvent(context),
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
                onTap: () => _openEventPage(context, event.id!),
                child: EventCard(
                  title: event.title,
                  date: event.startDate,
                  imageUrl: event.image ??
                      'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmFpbHxlbnwwfHwwfHx8Mg%3D%3D',
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

import 'package:client/core/models/event.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/components/event/event_header.dart';
import 'package:client/components/event/participants_list.dart';
import 'package:client/components/event/messages_preview.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/components/event/resources_section.dart';
import 'package:client/components/event/event_details_section.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({super.key, required this.eventId});

  @override
  // ignore: library_private_types_in_public_api
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarExpanded = false;
  late Future<Event> _eventFuture;

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
    _eventFuture = EventServices.getEventDetails(widget.eventId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToChat(BuildContext context, dynamic event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventChatPage(event: event),
      ),
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
                child: Text(t.error.details(error: snapshot.error.toString())));
          } else if (!snapshot.hasData) {
            return Center(child: Text(t.error.no_events_found));
          }

          final event = snapshot.data;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  background: EventHeader(
                    date: event!.startDate,
                    image: event.image,
                    title: event.title,
                    description: event.description,
                    participantsCount: event.participantsCount,
                  ),
                ),
                pinned: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: _isAppBarExpanded ? Colors.black : Colors.white,
                    weight: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    EventDetailsSection(
                      eventDate: event.startDate,
                      address: event.physicalEvent?['location'],
                      link: event.remoteEvent?['url'],
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: ParticipantsList(
                          participants: event.participants ?? const []),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: MessagesPreview(
                        messages: const [],
                        onSeeAllMessages: () => _navigateToChat(context, event),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ResourcesSection(
                      resources: event.documents ?? const [],
                    ),
                    const SizedBox(height: 20),
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

import 'package:client/core/models/event.dart';
import 'package:client/core/models/user.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/event_services.dart';
import 'package:client/components/event/event_header.dart';
import 'package:client/components/event/participants_list.dart';
import 'package:client/components/event/messages_preview.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/components/event/resources_section.dart';
import 'package:client/components/event/event_details_section.dart';
import 'package:go_router/go_router.dart';

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
  late Future<Event> _eventFuture;
  late bool isCurrentUserEvent;

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
    _eventFuture = EventServices.getEventDetails(widget.eventId).then((event) {
      isCurrentUserEvent = event.createdBy == widget.currentUser.id;
      return event;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToChat(BuildContext context, Event event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) {
          EventChatPage.navigateTo(context, event.id!);
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child:
            EventChatPage(eventId: event.id!),
          );
        },
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
              child: Text(t.error.details(error: snapshot.error.toString())),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text(t.error.no_events_found));
          }

          final event = snapshot.data!;

          final currentParticipantId = event.participants!.firstWhere(
              (participant) =>
                  participant['user']['id'] == widget.currentUser.id,
              orElse: () => null)?['id'];

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                flexibleSpace: FlexibleSpaceBar(
                  background: EventHeader(
                    date: event.startDate,
                    image: event.image ??
                        'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmFpbHxlbnwwfHwwfHx8Mg%3D%3D',
                    title: event.title,
                    description: event.description,
                    participantsCount: event.participantsCount!,
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
                    EventsPage.navigateTo(context);
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
                        participants: event.participants ?? const [],
                        isCurrentUserEvent: isCurrentUserEvent,
                      ),
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
                      eventId: event.id!,
                    ),
                    const SizedBox(height: 20),
                    // Leave button
                    if (!isCurrentUserEvent)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
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
                            onTap: () {
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

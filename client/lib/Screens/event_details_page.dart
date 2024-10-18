import 'package:flutter/material.dart';
import 'package:client/components/event/event_header.dart';
import 'package:client/components/event/participants_list.dart';
import 'package:client/components/event/messages_preview.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/components/event/resources_section.dart';
import 'package:client/components/event/event_details_section.dart'; // Import du nouveau composant
import 'package:client/fake_data.dart';

class EventDetailsPage extends StatelessWidget {
  final dynamic event = FakeData.eventDetails;

  EventDetailsPage({super.key});

  void _navigateToChat(BuildContext context) {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: EventHeader(
                date: event['date']!,
                image: event['image']!,
                title: event['title']!,
                description: event['description']!,
                participantsCount: event['participants'].length,
              ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: Colors.white, weight: 30),
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
                  eventDate: event['date']!,
                  address: event['physical_event'] == null
                      ? null
                      : event['physical_event']['address'],
                  link: event['remote_event'] == null
                      ? null
                      : event['remote_event']['link'],
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: ParticipantsList(participants: event['participants']),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: MessagesPreview(
                      messages: event['last_messages'],
                      onSeeAllMessages: () => _navigateToChat(context)),
                ),
                const SizedBox(height: 20),
                ResourcesSection(resources: event['event_documents']),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:client/components/event/event_header.dart';
import 'package:client/components/event/participants_list.dart';
import 'package:client/components/event/messages_preview.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/components/event/resources_section.dart';
import 'package:client/components/event/event_details_section.dart';
import 'package:client/fake_data.dart';

class EventDetailsPage extends StatefulWidget {
  final dynamic event = FakeData.eventDetails;

  EventDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarExpanded = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isAppBarExpanded = _scrollController.hasClients &&
            _scrollController.offset > (400 - kToolbarHeight);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventChatPage(event: widget.event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: EventHeader(
                date: widget.event['date']!,
                image: widget.event['image']!,
                title: widget.event['title']!,
                description: widget.event['description']!,
                participantsCount: widget.event['participants'].length,
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
                  eventDate: widget.event['date']!,
                  address: widget.event['physical_event'] == null
                      ? null
                      : widget.event['physical_event']['address'],
                  link: widget.event['remote_event'] == null
                      ? null
                      : widget.event['remote_event']['link'],
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: ParticipantsList(
                      participants: widget.event['participants']),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: MessagesPreview(
                      messages: widget.event['last_messages'],
                      onSeeAllMessages: () => _navigateToChat(context)),
                ),
                const SizedBox(height: 20),
                ResourcesSection(
                  resources: widget.event['event_documents'],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:client/core/services/participant_services.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/core/services/event_services.dart';
import 'package:client/core/models/event.dart';
import 'package:client/core/models/subject.dart';
import 'package:client/core/services/location_services.dart';
import 'package:client/components/event/event_filters_dialog.dart';

class SwipeCardsComponent extends StatefulWidget {
  final bool showFilters;
  final void Function() hideFilters;

  const SwipeCardsComponent(
      {super.key, required this.showFilters, required this.hideFilters});

  @override
  _SwipeCardsComponentState createState() => _SwipeCardsComponentState();
}

class _SwipeCardsComponentState extends State<SwipeCardsComponent> {
  late MatchEngine _matchEngine;

  String? _eventType;
  double? _maxDistance;
  String? _selectedSubject;
  List<Subject> _subjects = [];
  dynamic location;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
    _getLocation();
  }

  Future<void> _loadSubjects() async {
    final subjects = await SubjectServices.getSubjects();
    setState(() {
      _subjects = subjects;
    });
  }

  _getLocation() async {
    try {
      location = await LocationService.getLocation();
    } catch (error) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Event>>(
                future: EventServices.getEvents(
                  [_selectedSubject ?? ''],
                  location?['latitude'],
                  location?['longitude'],
                  _eventType ?? '',
                  _maxDistance,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: Text(t.error.loadingEvents));
                  }

                  final events = snapshot.data!;
                  final swipeItems = events.map((event) {
                    return SwipeItem(
                      content: event,
                      likeAction: () async {
                        await ParticipantServices.joinEvent(event.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.event.hasJoinEvent(
                              event_title: event.title,
                            )),
                          ),
                        );
                      },
                    );
                  }).toList();

                  _matchEngine = MatchEngine(swipeItems: swipeItems);

                  return SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (context, index) {
                      final event = swipeItems[index].content as Event;
                      return _buildEventCard(event);
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(t.swipe_cards.end_of_list)),
                      );
                    },
                    itemChanged: (SwipeItem item, int index) {
                    },
                    upSwipeAllowed: false,
                    fillSpace: true,
                  );
                },
              ),
            ),
          ],
        ),
        if (widget.showFilters)
          EventFiltersDialog(
            eventType: _eventType,
            maxDistance: _maxDistance,
            selectedSubject: _selectedSubject,
            subjects: _subjects,
            onApply: (eventType, maxDistance, selectedSubject) {
              setState(() {
                _eventType = eventType;
                _maxDistance = maxDistance;
                _selectedSubject = selectedSubject;
              });
              widget.hideFilters();
            },
          ),
      ],
    );
  }

  Widget _buildEventCard(Event event) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.99,
        child: Card(
          color: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  event.image ??
                      'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhdmFpbHxlbnwwfHwwfHx8Mg%3D%3D',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error));
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildInfoChip(
                          icon: Icons.calendar_today,
                          label: custom_date_utils.DateUtils.isoToFormattedDate(
                              event.startDate),
                        ),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          icon: Icons.people,
                          label: event.participantsCount.toString(),
                        ),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          icon: event.remoteEvent != null
                              ? Icons.wifi
                              : Icons.location_on,
                          label: event.remoteEvent != null
                              ? t.event.online
                              : t.event.physical,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.description,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActionButtons(context, event.title),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            _matchEngine.currentItem?.nope();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Nope $title")),
            );
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Colors.white,
          ),
          child: const Icon(Icons.clear, color: Colors.red, size: 25),
        ),
        OutlinedButton(
          onPressed: () async {
            _matchEngine.currentItem?.like();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(t.swipe_cards.joined_event(title: title))),
            );
            await ParticipantServices.joinEvent(
                _matchEngine.currentItem!.content.id);
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Colors.white,
          ),
          child: const Icon(Icons.favorite, color: Colors.green, size: 25),
        ),
      ],
    );
  }
}

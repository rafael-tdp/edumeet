import 'package:client/core/services/participant_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/core/services/event_services.dart';
import 'package:client/core/models/event.dart';

class SwipeCardsComponent extends StatefulWidget {
  const SwipeCardsComponent({super.key});

  @override
  _SwipeCardsComponentState createState() => _SwipeCardsComponentState();
}

class _SwipeCardsComponentState extends State<SwipeCardsComponent> {
  late MatchEngine _matchEngine;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: EventServices.getEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(child: Text(t.error.loadingEvents));
        }

        final events = snapshot.data!;
        final swipeItems = events.map((event) {
          return SwipeItem(
            content: event,
            likeAction: () async {
              await ParticipantServices.joinEvent(event.id);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.event.hasJoinEvent(event_title: event.title))),
              );
            },
          );
        }).toList();
        _matchEngine = MatchEngine(swipeItems: swipeItems);

        return SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (context, index) {
            final event = swipeItems[index].content as Event;
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
                          event.image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
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
                                  label: custom_date_utils.DateUtils
                                      .isoToFormattedDate(event.startDate),
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
          },
          onStackFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(t.swipe_cards.end_of_list)),
            );
          },
          itemChanged: (SwipeItem item, int index) {
            print(t.swipe_cards.item_changed(title: (item.content as Event).title));
          },
          upSwipeAllowed: false,
          fillSpace: true,
        );
      },
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

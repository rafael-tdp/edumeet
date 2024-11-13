import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/core/services/event_services.dart';

class SwipeCardsComponent extends StatefulWidget {
  const SwipeCardsComponent({super.key});

  @override
  _SwipeCardsComponentState createState() => _SwipeCardsComponentState();
}

class _SwipeCardsComponentState extends State<SwipeCardsComponent> {
  late List<SwipeItem> _swipeItems;
  late MatchEngine _matchEngine;

  Future<void> loadEvents() async {
    try {
      // Appel de la méthode asynchrone pour récupérer la liste d'événements
      final List<Map<String, dynamic>> events = await EventServices.getEvents();

      // Transformation des événements en `SwipeItem`
      _swipeItems = events.map((event) {
        return SwipeItem(
          content: event,
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Liked ${event['title']}")));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Nope ${event['title']}")));
          },
        );
      }).toList();

      // Initialisation de `MatchEngine` avec la liste `_swipeItems`
      setState(() {
        _matchEngine = MatchEngine(swipeItems: _swipeItems);
      });
    } catch (e) {
      print("Error loading events: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error loading events")));
    }
  }

  @override
  void initState() {
    super.initState();
    _swipeItems = [];
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: _matchEngine,
      itemBuilder: (context, index) {
        final data = _swipeItems[index].content as Map<String, dynamic>;
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
                      data['image']!,
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
                          data['title']!,
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    custom_date_utils.DateUtils
                                        .isoToFormattedDate(
                                            data['start_date']!),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.people,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    data['participants_count']!.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    data.containsKey('remote_event') &&
                                            data['remote_event'] != null
                                        ? Icons.wifi
                                        : Icons.location_on,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    data.containsKey('remote_event') &&
                                            data['remote_event'] != null
                                        ? 'En ligne'
                                        : 'Physique',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['description']!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                _matchEngine.currentItem?.nope();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Nope ${data['title']}")),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(16.0),
                                backgroundColor: Colors.white,
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _matchEngine.currentItem?.like();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Liked ${data['title']}",
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(16.0),
                                backgroundColor: Colors.white,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.green,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
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
          const SnackBar(content: Text("You've reached the end of the list!")),
        );
      },
      itemChanged: (SwipeItem item, int index) {
        print("Item changed: ${item.content['title']}");
      },
      upSwipeAllowed: true,
      fillSpace: true,
    );
  }
}

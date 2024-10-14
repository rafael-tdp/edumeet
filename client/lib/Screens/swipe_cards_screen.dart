import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeCardsPage extends StatefulWidget {
  const SwipeCardsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwipeCardsPageState createState() => _SwipeCardsPageState();
}

class _SwipeCardsPageState extends State<SwipeCardsPage> {
  late List<SwipeItem> _swipeItems;
  late MatchEngine _matchEngine;

  final List<Map<String, String>> _mockData = [
    {
      "name": "Entrainement Tailwind",
      "image":
          "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
      "description": "Entraînement sur Tailwind CSS",
    },
    {
      "name": "Entraide projet Flutter",
      "image":
          "https://images.unsplash.com/photo-1716348300558-c81409ed958a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y291cnN8ZW58MHx8MHx8fDI%3D",
      "description": "Entraide sur un projet Flutter",
    },
    {
      "name": "Révisions de Sécurité Web",
      "image":
          "https://images.unsplash.com/photo-1670934265254-954bd96352ba?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
      "description": "Révisions de sécurité web",
    },
    {
      "name": "Entraide FYC",
      "image":
          "https://images.unsplash.com/photo-1653203187698-530a34a80ba5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGNvdXJzfGVufDB8fDB8fHwy",
      "description": "Entraide sur le projet FYC",
    },
  ];

  @override
  void initState() {
    super.initState();
    _swipeItems = _mockData.map((data) {
      return SwipeItem(
        content: data,
        likeAction: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Liked ${data['name']}")));
        },
        nopeAction: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Nope ${data['name']}")));
        },
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (context, index) {
            final data = _swipeItems[index].content as Map<String, String>;
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  color: Colors.black,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      // Image de fond
                      Positioned.fill(
                        child: Image.network(
                          data['image']!,
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
                      // Couche de dégradé noir
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
                      // Texte et boutons superposés
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Titre
                            Text(
                              data['name']!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Description
                            Text(
                              data['description']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Boutons Like et Nope
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Bouton Nope
                                OutlinedButton(
                                  onPressed: () {
                                    _matchEngine.currentItem?.nope();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Nope ${data['name']}")),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.red, // Bordure rouge
                                      width: 2.0,
                                    ),
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor:
                                        Colors.transparent, // Fond transparent
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                                // Bouton Like
                                OutlinedButton(
                                  onPressed: () {
                                    _matchEngine.currentItem?.like();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Liked ${data['name']}")),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.green, // Bordure verte
                                      width: 2.0,
                                    ),
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor:
                                        Colors.transparent, // Fond transparent
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.green,
                                    size: 30,
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
              const SnackBar(
                  content: Text("You've reached the end of the list!")),
            );
          },
          itemChanged: (SwipeItem item, int index) {
            print("Item changed: ${item.content['name']}");
          },
          upSwipeAllowed: true,
          fillSpace: true,
        ),
      ),
    );
  }
}

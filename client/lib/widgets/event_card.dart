import 'package:flutter/material.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:flutter_svg/flutter_svg.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final String participants;
  final bool isCurrentUserEvent;
  final String? participantStatus;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.participants,
    this.isCurrentUserEvent = false,
    this.participantStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                // Background image
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      onError: (error, stackTrace) {
                        // Handle error by showing a default image
                        AssetImage('assets/default_image.png');
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Event details
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            custom_date_utils.DateUtils.isoToFormattedDate(
                                date),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
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
                                  participants,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (participantStatus == "PENDING")
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (isCurrentUserEvent)
          Positioned(
            top: 5,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              // child: SvgPicture.asset(
              //   'icons/crown.svg',
              //   width: 30,
              //   height: 30,
              // ),
              // owner icon
              child: const Icon(
                Icons.star,
                size: 30,
                color: Colors.yellow,
              ),
            ),
          ),
        if (participantStatus == "PENDING")
          Positioned(
            top: 5,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: const Icon(
                Icons.hourglass_empty,
                size: 30,
              ),
            ),
          ),
      ],
    );
  }
}
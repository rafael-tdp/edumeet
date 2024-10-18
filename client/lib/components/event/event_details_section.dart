import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;

class EventDetailsSection extends StatelessWidget {
  final String eventDate;
  final String? address;
  final String? link;

  const EventDetailsSection({
    super.key,
    required this.eventDate,
    this.address,
    this.link,
  });

  bool _isEventPassed(DateTime eventDate) {
    return DateTime.now().isAfter(eventDate);
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(eventDate);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.event, color: AppColors.purple, size: 24),
                const SizedBox(width: 8),
                Text(
                  custom_date_utils.DateUtils.isoToFormattedDate(eventDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (address != null) ...[
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: AppColors.purple, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address!,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ] else if (link != null) ...[
              if (_isEventPassed(parsedDate)) ...[
                Row(
                  children: [
                    const Icon(Icons.link, color: Colors.blue, size: 24),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // todo: Open the link
                      },
                      child: Text(
                        link!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const Wrap(
                  children: [
                    Text(
                      'Le lien de connexion sera disponible ici lorsque l\'événement commencera.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

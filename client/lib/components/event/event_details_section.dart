import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:url_launcher/url_launcher.dart';

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
            GestureDetector(
              onTap: () {
                if (address != null) {
                  Clipboard.setData(ClipboardData(text: address!));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.event.address_copied)),
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.purple, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address!,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (link != null) ...[
            if (_isEventPassed(parsedDate)) ...[
              Row(
                children: [
                  const Icon(Icons.link, color: Colors.blue, size: 24),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(link!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print('Impossible d\'ouvrir le lien');
                      }
                    },
                    child: Text(
                      t.event.joinEvent,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Wrap(
                children: [
                  Text(
                    t.event.eventNotStarted,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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

import 'package:client/core/models/message.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/utils/colors.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';

class MessagesPreview extends StatelessWidget {
  final List<Message> messages;
  final VoidCallback onSeeAllMessages;

  const MessagesPreview({
    super.key,
    required this.messages,
    required this.onSeeAllMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            t.messages.latestMessages,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onSeeAllMessages,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (messages.isEmpty)
                    Center(
                      child: Text(
                        t.messages.noMessages,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    ...messages.take(3).map((message) {
                      final Avatar _avatar = DiceBearBuilder(
                        seed: message.user.username,
                        sprite: DiceBearSprite.bottts,
                      ).build();

                      _avatar.toImage(width: 50, height: 50);

                      print(message.user);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: DiceBearBuilder(
                                  seed: message.user.username,
                                  sprite: DiceBearSprite.bottts,
                                ).build().toImage(width: 40, height: 40)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${message.user.username}: ",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: message.content,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      t.messages.seeAllMessages,
                      style: const TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

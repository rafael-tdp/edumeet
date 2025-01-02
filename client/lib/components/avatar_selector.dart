import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';

class AvatarSelector extends StatefulWidget {
  final String username;
  final Function(String) onAvatarSelected;

  const AvatarSelector({Key? key, required this.username, required this.onAvatarSelected}) : super(key: key);

  @override
  _AvatarSelectorState createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  final List<DiceBearSprite> _sprites = [
    DiceBearSprite.adventurer,
    DiceBearSprite.avataaars,
    DiceBearSprite.bigSmile,
    DiceBearSprite.bottts,
    DiceBearSprite.bigEars,
    DiceBearSprite.identicon,
    DiceBearSprite.initials,
  ];

  String? _selectedSprite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: _sprites.map((sprite) {
            final avatar = DiceBearBuilder(seed: widget.username, sprite: sprite).build();
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSprite = sprite.name;
                });
                widget.onAvatarSelected(sprite.name);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedSprite == sprite.name ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: avatar.toImage(height: 50, width: 50),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
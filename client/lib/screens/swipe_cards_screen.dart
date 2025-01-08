import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/swipe_cards.dart';

class SwipeCardsPage extends StatefulWidget {
  const SwipeCardsPage({super.key});

  @override
  _SwipeCardsPageState createState() => _SwipeCardsPageState();
}

class _SwipeCardsPageState extends State<SwipeCardsPage> {
  bool _showFilters = false;

  hideFilters() {
    setState(() {
      _showFilters = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showFilters = !_showFilters;
          });
        },
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.purple,
        child: Icon(
          _showFilters ? Icons.filter_list_off : Icons.filter_list,
        ),
      ),
      floatingActionButtonLocation: TopRightFloatingActionButtonLocation(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SwipeCardsComponent(
            showFilters: _showFilters, hideFilters: hideFilters),
      ),
    );
  }
}

class TopRightFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        16;
    final double fabY = scaffoldGeometry.floatingActionButtonSize.height;
    return Offset(fabX, fabY);
  }
}

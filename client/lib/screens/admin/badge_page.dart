import 'package:client/core/models/badge.dart' as Model;
import 'package:client/core/services/badges_services.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:client/components/datatable.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BadgePage extends StatefulWidget {
  static const String routeName = '/badges';
  static navigateTo(BuildContext context) {
    context.go('${AdminPage.routeName}$routeName');
  }

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  List<Model.Badge> _badges = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBadges();
  }

  Future<void> _fetchBadges() async {
    try {
      final badges = await BadgeServices.getBadges();
      setState(() {
        _badges = badges;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching badges: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        title: const Text('Liste des Badges'),
        backgroundColor: AppColors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _badges.isEmpty
            ? const Center(child: Text('Aucune données disponible'))
            : DataTableWithPagination<Model.Badge>(
          data: _badges,
          initialRowsPerPage: 5,
          columns: const [
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Nb requirement event')),
            DataColumn(label: Text('SVG')),
          ],
          rowBuilder: (badge) {
            return [
              DataCell(Text(badge.id)),
              DataCell(Text(badge.name)),
              DataCell(Text(badge.type)),
              DataCell(Text(badge.nbRequirementEvent.toString())),
              DataCell(
                SvgPicture.string(
                  badge.svg,
                  height: 40,
                  width: 40,
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
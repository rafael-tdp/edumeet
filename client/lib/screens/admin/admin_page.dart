import 'package:client/core/models/user.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/screens/admin/badge_page.dart';
import 'package:client/screens/admin/dashboard_page.dart';
import 'package:client/screens/admin/event_page.dart';
import 'package:client/screens/admin/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'subject_page.dart';
import 'package:client/utils/colors.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);
  static const String routeName = '/admin';
  static navigateTo(BuildContext context) {
    context.go(routeName);
  }

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    try {
      final response = await UserServices().getUserInfo();
      setState(() {
        _currentUser = response.data;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not loaded")),
        );
      }
    }
  }

  final List<AdminMenuItem> _sideBarItems = const [
    AdminMenuItem(
      title: 'Dashboard',
      route: '/admin/dashboard',
      icon: Icons.dashboard,
    ),
    AdminMenuItem(
      title: 'Sujets',
      icon: Icons.menu_book,
      route: '${AdminPage.routeName}${SubjectPage.routeName}',
    ),
    AdminMenuItem(
      title: 'Badges',
      icon: Icons.star,
      route: '${AdminPage.routeName}${BadgePage.routeName}',
    ),
    AdminMenuItem(
      title: 'Evenements',
      icon: Icons.event,
      route: '${AdminPage.routeName}${EventsPageAdmin.routeName}',
    ),
    AdminMenuItem(
      title: 'Utilisateurs',
      icon: Icons.admin_panel_settings,
      route: '${AdminPage.routeName}${UserPageAdmin.routeName}',
    ),
  ];

  final List<AdminMenuItem> _adminMenuItems = const [
    AdminMenuItem(
      title: 'Déconnexion',
      icon: Icons.logout,
      route: '/login',
    ),
  ];

  List<Widget> get _pages {
    return [
      const DashboardPage(),
      SubjectPage(),
      BadgePage(),
      EventsPageAdmin(),
      UserPageAdmin(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: AppColors.white,
      leadingIcon: const Icon(Icons.menu, color: AppColors.white),
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        title: const Text(
          'Edumeet Admin',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.white,
              height: 1.0,
            )),
        actions: [
          PopupMenuButton<AdminMenuItem>(
            child: const Icon(Icons.account_circle, color: AppColors.white),
            itemBuilder: (context) {
              return _adminMenuItems.map((AdminMenuItem item) {
                return PopupMenuItem<AdminMenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(item.icon, color: AppColors.purple),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                              color: AppColors.purple, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
            onSelected: (item) {
              context.go(item.route!);
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      sideBar: SideBar(
        backgroundColor: Colors.grey.shade50,
        activeBackgroundColor: AppColors.lightPurple,
        borderColor: Colors.grey.shade300,
        iconColor: AppColors.purple,
        activeIconColor: AppColors.purple,
        textStyle: const TextStyle(
          color: AppColors.purple,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        activeTextStyle: const TextStyle(
          color: AppColors.darkBlue,
          fontSize: 13,
        ),
        items: _sideBarItems,
        selectedRoute: AdminPage.routeName,
        onSelected: (item) {
          if (item.route ==
              '${AdminPage.routeName}${DashboardPage.routeName}') {
            setState(() {
              _selectedIndex = 0;
            });
          } else if (item.route ==
              '${AdminPage.routeName}${SubjectPage.routeName}') {
            setState(() {
              _selectedIndex = 1;
            });
          } else if (item.route ==
              '${AdminPage.routeName}${BadgePage.routeName}') {
            setState(() {
              _selectedIndex = 2;
            });
          } else if (item.route ==
              '${AdminPage.routeName}${EventsPageAdmin.routeName}') {
            setState(() {
              _selectedIndex = 3;
            });
          } else if (item.route ==
              '${AdminPage.routeName}${UserPageAdmin.routeName}') {
            setState(() {
              _selectedIndex = 4;
            });
          }
        },
      ),
      body: _currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : _pages[_selectedIndex],
    );
  }
}

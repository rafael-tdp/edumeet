import 'package:client/core/models/user.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/screens/admin/badge_page.dart';
import 'package:client/screens/admin/dashboard_page.dart';
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
      title: 'Subject',
      icon: Icons.menu_book,
      route: '${AdminPage.routeName}${SubjectPage.routeName}',
    ),
    AdminMenuItem(
      title: 'Badge',
      icon: Icons.star,
      route: '${AdminPage.routeName}${BadgePage.routeName}',
    ),
  ];

  final List<AdminMenuItem> _adminMenuItems = const [
    AdminMenuItem(
      title: 'User Profile',
      icon: Icons.account_circle,
      route: '/admin/profile',
    ),
    AdminMenuItem(
      title: 'Settings',
      icon: Icons.settings,
      route: '/admin/settings',
    ),
    AdminMenuItem(
      title: 'Logout',
      icon: Icons.logout,
      route: '/logout',
    ),
  ];

  List<Widget> get _pages {
    return [
      DashboardPage(),
      SubjectPage(),
      BadgePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: AppColors.lightBlue,
      leadingIcon: const Icon(Icons.menu, color: AppColors.white),
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        title: const Text('Edumeet Admin', style: TextStyle(color: AppColors.white)),
        actions: [
          PopupMenuButton<AdminMenuItem>(
            child: const Icon(Icons.account_circle, color: AppColors.white),
            itemBuilder: (context) {
              return _adminMenuItems.map((AdminMenuItem item) {
                return PopupMenuItem<AdminMenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(item.icon, color: AppColors.white),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          item.title,
                          style: TextStyle(color: AppColors.white, fontSize: 14),
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
        ],
      ),
      sideBar: SideBar(
        backgroundColor: AppColors.darkBlue,
        activeBackgroundColor: AppColors.lightBlue,
        borderColor: AppColors.white,
        iconColor: AppColors.white,
        activeIconColor: AppColors.lightBlue,
        textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 13,
        ),
        activeTextStyle: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 13,
        ),
        items: _sideBarItems,
        selectedRoute: AdminPage.routeName,
        onSelected: (item) {
          if (item.route == '${AdminPage.routeName}${DashboardPage.routeName}') {
            setState(() {
              _selectedIndex = 0;
            });
          } else if (item.route == '${AdminPage.routeName}${SubjectPage.routeName}') {
            setState(() {
              _selectedIndex = 1;
            });
          } else if (item.route == '${AdminPage.routeName}${BadgePage.routeName}') {
            setState(() {
              _selectedIndex = 2;
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
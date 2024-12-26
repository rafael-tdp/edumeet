import 'package:client/core/models/user.dart';
import 'package:client/core/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'subject_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

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
      route: '/admin/subjects',
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
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Welcome to the Admin Dashboard! ${_currentUser != null ? '${_currentUser!.firstname} ${_currentUser!.lastname}' : ''}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      SubjectPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      leadingIcon: const Icon(Icons.menu),
      appBar: AppBar(
        title: const Text('Edumeet Admin'),
        actions: [
          PopupMenuButton<AdminMenuItem>(
            child: const Icon(Icons.account_circle),
            itemBuilder: (context) {
              return _adminMenuItems.map((AdminMenuItem item) {
                return PopupMenuItem<AdminMenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(item.icon),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          item.title,
                          style: const TextStyle(fontSize: 14),
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
        backgroundColor: const Color(0xFFEEEEEE),
        activeBackgroundColor: Colors.black26,
        borderColor: const Color(0xFFE7E7E7),
        iconColor: Colors.black87,
        activeIconColor: Colors.blue,
        textStyle: const TextStyle(
          color: Color(0xFF337ab7),
          fontSize: 13,
        ),
        activeTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        items: _sideBarItems,
        selectedRoute: '/admin',
        onSelected: (item) {
          if (item.route == '/admin/dashboard') {
            setState(() {
              _selectedIndex = 0;
            });
          } else if (item.route == '/admin/subjects') {
            setState(() {
              _selectedIndex = 1;
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
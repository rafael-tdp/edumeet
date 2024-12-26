import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'subject_page.dart'; // Importez la page SubjectPage

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  // Les éléments de la sidebar
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

  // Les éléments du menu utilisateur (profil, paramètres, déconnexion)
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

  // Contenu correspondant aux éléments de la sidebar
  final List<Widget> _pages = [
    // Vous pouvez ajouter ici d'autres pages si nécessaire.
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: const [
          Text(
            'Welcome to the Admin Dashboard!',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
    SubjectPage(), // La page Subject sera affichée ici.
  ];

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
              context.go(item.route!); // Utilisation de GoRouter pour la navigation
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
          print('sideBar: onTap(): title = ${item.title}, route = ${item.route}');
          // Mise à jour de l'index en fonction de la sélection dans la Sidebar
          if (item.route == '/admin/dashboard') {
            setState(() {
              _selectedIndex = 0; // Dashboard
            });
          } else if (item.route == '/admin/subjects') {
            setState(() {
              _selectedIndex = 1; // Subject
            });
          }
        },
      ),
      body: _pages[_selectedIndex], // Affichage du contenu en fonction de l'index sélectionné
    );
  }
}
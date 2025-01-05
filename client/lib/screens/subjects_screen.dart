import 'package:client/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/core/models/subject.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/subjects_services.dart';
import 'package:client/components/profile_button.dart';
import 'package:go_router/go_router.dart';

import '../core/services/cache_service.dart';
import '../core/services/user_services.dart';
import '../main.dart';
import 'package:client/components/profile_button.dart';

class SubjectsPage extends StatefulWidget {
  static const String routeName = '/subjects';
  static navigateTo(BuildContext context) {
    context.push(routeName);
  }
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  late Future<List<Subject>> _subjectsFuture;
  late Set<String> _selectedSubjects = {};
  final TextEditingController _searchController = TextEditingController();
  List<Subject> _filteredSubjects = [];
  List<Subject> _allSubjects = [];

  @override
  void initState() {
    super.initState();
    _subjectsFuture = SubjectServices.getSubjects();
    _searchController.addListener(_onSearchChanged);
    _loadUserSubjects();
  }

  Future<void> _loadUserSubjects() async {
    final response = await UserServices().getUserSubjects();
    if (response.success) {
      for (var subject in response.data!) {
        setState(() {
          _selectedSubjects.add(subject.id);
        });
      }
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSubjects = _allSubjects.where((subject) {
        return subject.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleSelection(String subjectId) {
    setState(() {
      if (_selectedSubjects.contains(subjectId)) {
        _selectedSubjects.remove(subjectId);
      } else {
        _selectedSubjects.add(subjectId);
      }
    });
  }

Future<bool> _isFirstLaunch() async {
  final isFirstLaunch = await CacheService.getDataFromCache("first_launch");
  return isFirstLaunch == null || isFirstLaunch == "true";
}

void _confirmSelection() async {
  final isFirstLaunch = await _isFirstLaunch();
  SubjectServices.subscribeToSubjects(_selectedSubjects.toList())
      .then((response) async {
    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vos matières ont été mises à jour")),
      );
      if (isFirstLaunch) {
        await CacheService.saveDataToCache("first_launch", "false");
        context.go(HomePage.routeName);
      } else {
        context.go(SettingsPage.routeName);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message!),
          backgroundColor: AppColors.purple,
        ),
      );
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: FutureBuilder<List<Subject>>(
            future: _subjectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Aucun sujet trouvé.');
              }

              if (_allSubjects.isEmpty) {
                _allSubjects = snapshot.data!;
                _filteredSubjects = _allSubjects;
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      children: [
                        const Text("Sélectionnez les matières qui vous intéressent. Vous pourrez les modifier plus tard sur votre page de profil."),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Rechercher',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredSubjects.length,
                      itemBuilder: (context, index) {
                        final subject = _filteredSubjects[index];
                        bool isSelected = _selectedSubjects.contains(subject.id);
                        return ListTile(
                          title: Text(subject.name),
                          leading: Checkbox(
                            value: isSelected,
                            onChanged: (bool? value) {
                              _toggleSelection(subject.id);
                            },
                          ),
                          onTap: () => _toggleSelection(subject.id),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ProfileButton(
                      text: 'Confirmer',
                      onPressed: _confirmSelection,
                      backgroundColor: AppColors.purple,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
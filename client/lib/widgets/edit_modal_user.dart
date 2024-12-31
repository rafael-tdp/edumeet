import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/core/models/user.dart' as Model;

class EditUserDialog extends StatefulWidget {
  final Model.User? initialUser;
  final void Function(Model.User newUser, void Function(bool shouldClose, String? errorMessage, bool isLoading) callback) onSave;

  const EditUserDialog({
    Key? key,
    required this.onSave,
    this.initialUser,
  }) : super(key: key);

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  bool _isSaving = false;
  String? _selectedRole;
  bool _isActivated = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    if (widget.initialUser != null) {
      _emailController = TextEditingController(text: widget.initialUser!.email);
      _usernameController = TextEditingController(text: widget.initialUser!.username);
      _firstnameController = TextEditingController(text: widget.initialUser!.firstname);
      _lastnameController = TextEditingController(text: widget.initialUser!.lastname);
      _selectedRole = widget.initialUser!.role;
      _isActivated = widget.initialUser!.activated ?? false;
    } else {
      _emailController = TextEditingController();
      _usernameController = TextEditingController();
      _firstnameController = TextEditingController();
      _lastnameController = TextEditingController();
      _selectedRole = 'USER';
      _isActivated = true;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  void _updateState(bool shouldClose, String? errorMessage, bool isLoading) {
    setState(() {
      _isSaving = isLoading;
      _errorMessage = errorMessage;

      if (shouldClose) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: 600,
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.initialUser == null ? 'Créer un utilisateur' : 'Modifier l\'utilisateur',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _isSaving
                  ? const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
                  : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'L\'email ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le nom d\'utilisateur ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _firstnameController,
                      decoration: const InputDecoration(
                        labelText: 'Prénom',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le prénom ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastnameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le nom ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: const InputDecoration(
                        labelText: 'Rôle',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRole = newValue;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'ADMIN',
                          child: Text('Administrateur'),
                        ),
                        DropdownMenuItem(
                          value: 'USER',
                          child: Text('Utilisateur'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'Le rôle ne peut pas être vide.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: const Text('Activé'),
                      value: _isActivated,
                      onChanged: (bool value) {
                        setState(() {
                          _isActivated = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final updatedUser = Model.User(
                          id: widget.initialUser?.id ?? '',
                          email: _emailController.text,
                          username: _usernameController.text,
                          firstname: _firstnameController.text,
                          lastname: _lastnameController.text,
                          role: _selectedRole ?? 'USER',
                          activated: _isActivated,
                          birthDate: DateTime.now(),
                        );

                        widget.onSave(updatedUser, _updateState);
                      }
                    },
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

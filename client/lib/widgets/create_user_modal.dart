import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateUserDialog extends StatefulWidget {
  final Future<void> Function(Map<String, dynamic> newUser) onCreate;

  const CreateUserDialog({required this.onCreate, Key? key}) : super(key: key);

  @override
  _CreateUserDialogState createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String _selectedRole = 'USER';
  DateTime? _birthDate;
  bool isLoading = false;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthDate = pickedDate;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _birthDate != null) {
      setState(() => isLoading = true); // Démarrer le loader

      try {
        await widget.onCreate({
          'email': _emailController.text,
          'password': _passwordController.text,
          'firstname': _firstnameController.text,
          'lastname': _lastnameController.text,
          'username': _usernameController.text,
          'role': _selectedRole,
          'birthdate': _birthDate!.toUtc().toIso8601String(),
        });
        Navigator.of(context).pop();
      } finally {
        setState(() => isLoading = false); // Désactiver le loader
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Loader
            : SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Créer un utilisateur',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                  value!.isEmpty ? 'Email requis' : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  validator: (value) =>
                  value!.isEmpty ? 'Mot de passe requis' : null,
                ),
                TextFormField(
                  controller: _firstnameController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                  validator: (value) =>
                  value!.isEmpty ? 'Prénom requis' : null,
                ),
                TextFormField(
                  controller: _lastnameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (value) =>
                  value!.isEmpty ? 'Nom requis' : null,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration:
                  const InputDecoration(labelText: 'Nom d\'utilisateur'),
                  validator: (value) => value!.isEmpty
                      ? 'Nom d\'utilisateur requis'
                      : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: const InputDecoration(labelText: 'Rôle'),
                  items: const [
                    DropdownMenuItem(value: 'USER', child: Text('Utilisateur')),
                    DropdownMenuItem(value: 'ADMIN', child: Text('Administrateur')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Date de naissance :'),
                    TextButton(
                      onPressed: _pickDate,
                      child: Text(
                        _birthDate == null
                            ? 'Choisir une date'
                            : DateFormat('dd/MM/yyyy').format(_birthDate!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Créer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

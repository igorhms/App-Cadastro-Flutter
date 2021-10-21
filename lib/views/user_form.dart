import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/user.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  UserForm({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  // final Map<String, String?> _formData = {};

  String id = '';
  String name = '';
  String email = '';
  String avatarUrl = '';

  void _loadFormData(User user) {
    id = user.id;
    name = user.name;
    email = user.email;
    avatarUrl = user.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    final Object? user = ModalRoute.of(context)!.settings.arguments;

    if (user != null) {
      user as User;
      _loadFormData(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Usuário"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState!.save();

                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: id,
                      name: name,
                      email: email,
                      avatarUrl: avatarUrl,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O nome deve ser informado.';
                  }
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O e-mail deve ser informado.';
                  }
                },
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                initialValue: avatarUrl,
                decoration: const InputDecoration(labelText: 'URL do avatar'),
                onSaved: (value) => avatarUrl = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

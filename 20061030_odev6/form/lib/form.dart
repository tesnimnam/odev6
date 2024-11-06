import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Kullanıcı Formu")),
        body: UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // E-posta doğrulama işlevi
  String? _validateEmail(String? value) {
    final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'E-posta adresi giriniz.';
    } else if (!regex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz.';
    }
    return null;
  }

  // Şifre doğrulama işlevi
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre giriniz.';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'İsim',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'İsim giriniz.';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
              ),
              validator: _validateEmail,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: _validatePassword,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Form başarıyla tamamlandı!')),
                  );
                }
              },
              child: Text('Formu Tamamla'),
            ),
          ],
        ),
      ),
    );
  }
}

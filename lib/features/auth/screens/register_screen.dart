import 'package:flutter/material.dart';
import 'package:taskify/features/auth/services/auth_service.dart';
import 'package:taskify/features/dashboard/screens/dashboard_screen.dart';
import '../widgets/auth_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void registerUser() async {
    try {
      await AuthService().register(emailCtrl.text, passCtrl.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AuthTextField(label: 'Email', controller: emailCtrl),
            const SizedBox(height: 10),
            AuthTextField(label: 'Password', controller: passCtrl, obscure: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: registerUser, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}

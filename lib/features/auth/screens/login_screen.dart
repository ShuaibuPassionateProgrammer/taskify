import 'package:flutter/material.dart';
import 'package:taskify/features/auth/screens/register_screen.dart';
import 'package:taskify/features/auth/services/auth_service.dart';
import 'package:taskify/features/dashboard/screens/dashboard_screen.dart';
import '../widgets/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void loginUser() async {
    try {
      await AuthService().signIn(emailCtrl.text, passCtrl.text);
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AuthTextField(label: 'Email', controller: emailCtrl),
            const SizedBox(height: 10),
            AuthTextField(label: 'Password', controller: passCtrl, obscure: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: loginUser, child: const Text('Login')),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              ),
              child: const Text("Don't have an account? Register"),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.8,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Container(
              height: 700,
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          label: Text('Email'),
                        ),
                        controller: emailController,
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        decoration: InputDecoration(
                          label: Text('Senha'),
                        ),
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Logar'),
                      ),
                    ],
                  )
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_event.dart';
import 'package:flutter_posts_test/app/bloc/login/login_state.dart';
import 'package:flutter_posts_test/app/shared/notifications/custom_notifications.dart';
import 'package:flutter_posts_test/app/shared/widget/custom_loading.dart';
import 'package:flutter_posts_test/app/shared/widget/custom_text_error.dart';
import 'package:flutter_posts_test/app/shared/widget/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final notifications = CustomNotifications();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.8,
              child: Center(child: const Text('Login')),
            ),
            const SizedBox(height: 20),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(child: CustomLoading());
                }

                if (state is LoginSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    notifications.showSnackBar(
                      context: context,
                      message: 'Usuário autenticado!',
                    );
                    //doMainView();
                  });
                }

                Widget genericErrorWidget = const SizedBox();
                String? emailError;
                String? passwordError;
                String? genericError;

                if (state is LoginFailure) {
                  emailError = state.emailMessage;
                  passwordError = state.passwordMessage;
                  genericError = state.genericMessage;
                  if (genericError != null) {
                    genericErrorWidget = CustomTextError(
                      message: genericError,
                    );
                  }
                }

                return Container(
                  height: 700,
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        label: 'Email',
                        controller: emailController,
                        error: emailError,  
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        label: 'Senha',
                        controller: passwordController,
                        isPassword: true,
                        error: passwordError,
                      ),
                      const SizedBox(height: 22),
                      genericErrorWidget,
                      const SizedBox(height: 8), 
                      ElevatedButton(onPressed: onLoginButtonPressed, child: Text('Logar')),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onLoginButtonPressed() {
    final email = emailController.text;
    final password = passwordController.text;

    context.read<LoginBloc>().add(LoginButtonPressed(
      email: email,
      password: password,
    ));
  }
}

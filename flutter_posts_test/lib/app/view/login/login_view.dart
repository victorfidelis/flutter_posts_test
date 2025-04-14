import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_event.dart';
import 'package:flutter_posts_test/app/bloc/login/login_state.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_event.dart';
import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_posts_test/app/shared/notifications/custom_notifications.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_loading.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_text_error.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_text_field.dart';
import 'package:flutter_posts_test/app/view/login/widgets/login_buttom.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final notifications = CustomNotifications();
  final ValueNotifier<bool> animate = ValueNotifier(false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animate.value = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
        title: animatedTitle(),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height / 4,
      ),
      body: animatedContainer(),
    );
  }

  Widget animatedTitle() {
    return ListenableBuilder(
      listenable: animate,
      builder: (context, _) {
        return AnimatedOpacity(
          opacity: animate.value ? 1 : 0,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInExpo,
          child: const Text('Login', 
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              )),
        );
      }
    );
  }

  Widget animatedContainer() {
    return ListenableBuilder(
      listenable: animate,
      builder: (context, _) {
        return Stack(
          children: [
            AnimatedPositioned(
              left: 0,
              top: animate.value ? 0 : 700,
              right: 0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                height: (MediaQuery.of(context).size.height / 4) * 3,
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: buildLoginControls(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildLoginControls() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          onLoginSuccess(state.user);
        }
      },
      builder: (context, state) {
        if (state is LoginSuccess) {
          return SizedBox();
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
            genericErrorWidget = CustomTextError(message: genericError);
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(label: 'Email', controller: emailController, error: emailError),
              const SizedBox(height: 18),
              CustomTextField(
                label: 'Senha',
                controller: passwordController,
                isPassword: true,
                error: passwordError,
              ),
              const SizedBox(height: 22),
              genericErrorWidget,
              const SizedBox(height: 30),
              state is LoginLoading
                  ? CustomLoading()
                  : LoginButtom(onTap: onLoginButtonPressed, label: 'Entrar'),
            ],
          ),
        );
      },
    );
  }

  void onLoginButtonPressed() {
    final email = emailController.text;
    final password = passwordController.text;

    context.read<LoginBloc>().add(LoginButtonPressed(email: email, password: password));
  }

  void onLoginSuccess(User user) {
    context.read<WrapperBloc>().add(LogIn(user));
    notifications.showSnackBar(context: context, message: 'Usuário autenticado!');
  }
}

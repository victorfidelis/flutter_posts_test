import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_state.dart';
import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_posts_test/app/shared/widgets/profile_image.dart';
import 'package:flutter_posts_test/app/shared/widgets/theme_buttom.dart';

class CustomPostHeader extends StatefulWidget {
  final Function() onClickImageProfile;
  const CustomPostHeader({super.key, required this.onClickImageProfile});

  @override
  State<CustomPostHeader> createState() => _CustomPostHeaderState();
}

class _CustomPostHeaderState extends State<CustomPostHeader> {
  late User user;
  final animateUserInfo = ValueNotifier<bool>(false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animateUserInfo.value = true;
    });
    user = (context.read<WrapperBloc>().state as LoggedIn).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).appBarTheme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, top: 54, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImage(),
            const SizedBox(width: 16),
            Expanded(child: buildAnimatedUserInfo()),
            ThemeButtom(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return GestureDetector(
      onTap: widget.onClickImageProfile,
      child: ProfileImage(url: user.profilePicture, width: 50, height: 50),
    );
  }

  Widget buildAnimatedUserInfo() {
    return ListenableBuilder(
      listenable: animateUserInfo,
      builder: (context, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: animateUserInfo.value ? 1 : 0,
          curve: Curves.easeInOut,
          child: Row(
            children: [
              const Text('Bem-vindo, ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_state.dart';
import 'package:flutter_posts_test/app/model/user.dart';

class CustomPostHeader extends StatefulWidget {
  final Function() onClickImageProfile;
  const CustomPostHeader({super.key, required this.onClickImageProfile});

  @override
  State<CustomPostHeader> createState() => _CustomPostHeaderState();
}

class _CustomPostHeaderState extends State<CustomPostHeader> {
  late User user;

  @override
  void initState() {
    user = (context.read<WrapperBloc>().state as LoggedIn).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Color(0x50000000), offset: const Offset(0, 8), blurRadius: 8)],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, top: 40, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildImage(), const SizedBox(width: 16), Expanded(child: buildUserInfo())],
        ),
      ),
    );
  }

  Widget buildImage() {
    return GestureDetector(
      onTap: widget.onClickImageProfile,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(user.profilePicture, width: 50, height: 50, fit: BoxFit.cover),
      ),
    );
  }

  Widget buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Bem-vindo, ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

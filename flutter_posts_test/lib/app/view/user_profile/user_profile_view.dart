import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_event.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_event.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_state.dart';
import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_posts_test/app/shared/notifications/custom_notifications.dart';
import 'package:flutter_posts_test/app/shared/widgets/back_navigation.dart';
import 'package:flutter_posts_test/app/shared/widgets/profile_image.dart';
import 'package:transparent_image/transparent_image.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late final User user;
  final notifications = CustomNotifications();

  @override
  void initState() {
    user = (context.read<WrapperBloc>().state as LoggedIn).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            const Divider(thickness: 1),
            SizedBox(height: 4),
            buildUserInfo(),
            SizedBox(height: 4),
            const Divider(thickness: 1),
            SizedBox(height: 4),
            buildLikes(),
            const SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: buildLogOutButton(),
    );
  }

  Widget buildHeader() {
    return Stack(
      children: [
        buildImageBackgoundHeader(),
        Positioned(top: 110, left: 12, child: buildProfileImage()),
        Positioned(top: 170, left: 150, child: buildUserName()),
        Positioned(top: 50, left: 6, child: BackNavigation(onTap: () => Navigator.pop(context))),
      ],
    );
  }

  Widget buildImageBackgoundHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: user.backgroundImage,
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 150,
        ),
        SizedBox(height: 100),
      ],
    );
  }

  Widget buildProfileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Container(
        padding: EdgeInsets.all(3),
        color: Theme.of(context).colorScheme.surface,
        child: ProfileImage(url: user.profilePicture, width: 120, height: 120),
      ),
    );
  }

  Widget buildUserName() {
    return SizedBox(
      width: 220,
      child: Text(
        user.fullName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }

  Widget buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            '${user.age} anos',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${user.numberOfPosts} postagens',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildLikes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            user.likes.map((like) {
              return Chip(
                label: Text(
                  like,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff303030)),
                ),
                backgroundColor: Colors.blue[100],
              );
            }).toList(),
      ),
    );
  }

  Widget buildLogOutButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: ElevatedButton(
        onPressed: onLogOut,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, color: Colors.red, size: 24),
            SizedBox(width: 8),
            const Text(
              'Sair',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void onLogOut() {
    notifications.showQuestionAlert(
      context: context,
      title: 'Deseja sair?',
      content: 'Tem certeza que deseja encerrar a sessão atual?',
      confirmCallback: doLogout,
    );
  }

  void doLogout() {
    Navigator.popUntil(context, (route) => route.isFirst);
    context.read<LoginBloc>().add(LogoutButtonPressed());
    context.read<WrapperBloc>().add(LogOut());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/model/user_of_post.dart';

class UserOfPostCard extends StatefulWidget {
  final UserOfPost user;
  const UserOfPostCard({super.key, required this.user});

  @override
  State<UserOfPostCard> createState() => _UserOfPostCardState();
}

class _UserOfPostCardState extends State<UserOfPostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'User of Post',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(widget.user.name, style: TextStyle(fontSize: 18)),
          Text(widget.user.email, style: TextStyle(fontSize: 14)),
          Text(widget.user.phone, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
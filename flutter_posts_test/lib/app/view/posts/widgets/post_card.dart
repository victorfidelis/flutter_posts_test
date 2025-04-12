import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/model/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final Function(Post post) onTap;

  const PostCard({super.key, required this.post, required this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isExpanded = false;
  bool get isExpanable => widget.post.body.length > 100;
  String get text =>
      isExpanded || !isExpanable ? widget.post.body : '${widget.post.body.substring(0, 100)}...';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.post),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceBright),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            buildBody(),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          buildClickableText(),
        ],
      ),
    );
  }

  InlineSpan buildClickableText() {
    if (isExpanable && !isExpanded) {
      return buildSpanClickable('   Ver mais');
    } else {
      return TextSpan();
    }
  }

  TextSpan buildSpanClickable(String text) {
    final tapGesture = TapGestureRecognizer();
    tapGesture.onTap = resize;

    return TextSpan(
      text: text,
      recognizer: tapGesture,
      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    );
  }

  void resize() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

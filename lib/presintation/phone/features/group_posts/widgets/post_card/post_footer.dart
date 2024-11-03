import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });

  final String likeCount;
  final String commentCount;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.06; // Dynamic icon size based on screen width
    final fontSize = screenWidth * 0.04; // Dynamic font size based on screen width
    final padding = screenWidth * 0.02; // Dynamic padding based on screen width

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                IconButton(
                  iconSize: iconSize,
                  icon: Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.grey.shade800,
                  ),
                  onPressed: () {},
                ),
                Text(
                  commentCount,
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                IconButton(
                  iconSize: iconSize,
                  icon: Icon(
                    isLiked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                    color: isLiked ? Colors.blue : Colors.grey.shade800,
                  ),
                  onPressed: () {
                    // Handle like toggle functionality here
                  },
                ),
                Text(
                  likeCount,
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

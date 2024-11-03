
import 'package:flutter/material.dart';

class DetailesFooter extends StatelessWidget {
  const DetailesFooter({
    super.key, required this.likeCount, required this.commentCount, required this.isLiked,
  });
  final String likeCount;
  final String commentCount;
  final bool isLiked ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFooterItem(Icons.thumb_up, '$likeCount Likes'),
        _buildFooterItem(Icons.comment, '$commentCount Comments'),
      ],
    );
  }
    Widget _buildFooterItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: isLiked ? Colors.blueAccent : Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

}

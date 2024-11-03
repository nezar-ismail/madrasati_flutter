
import 'package:flutter/material.dart';

class DetailesCommentSection extends StatelessWidget {
  const DetailesCommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comments',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10, // Replace with actual comment count
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                title: Text('Comment #$index'),
                subtitle: Text('This is a placeholder comment text.'),
                contentPadding: const EdgeInsets.all(16.0),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FeedbackDetails extends StatelessWidget {
  final String feedbackCreatedAt;
  final String feedbackAuthor;
  final String feedbackText;

  const FeedbackDetails({
    super.key,
    required this.feedbackCreatedAt,
    required this.feedbackAuthor,
    required this.feedbackText,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the screen width and calculate responsive sizes
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: isLargeScreen ? 32.0 : 16.0,
      ),
      child: Padding(
        padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          feedbackAuthor,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeText(
                          feedbackCreatedAt
                              .replaceAll('-', '/')
                              .replaceAll('T', ' - ')
                              .substring(0, 18),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            Text(
              feedbackText,
              style: TextStyle(
                fontSize: isLargeScreen ? 16 : 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

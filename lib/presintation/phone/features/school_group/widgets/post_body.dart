
import 'package:flutter/material.dart';

class PostBody extends StatelessWidget {
  const PostBody({
    super.key,
    required this.caption,
  });

  final String caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        caption,
        style: const TextStyle(fontFamily: 'Roboto'),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        // ignore: deprecated_member_use
        textScaleFactor: 1.0,
        textWidthBasis: TextWidthBasis.parent,
        textHeightBehavior: null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';

class SchoolGroup extends StatelessWidget {
  const SchoolGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'School Group',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Post Header
              Expanded(flex: 1, child: PostHeader()),

              //Post Body
              Expanded(flex: 3, child: PostBody()),

              //Post Footer
              Expanded(flex: 1, child: PostFooter()),
            ],
          ),
        ),
      ),
    );
  }
}

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
              ),
              color: Colors.grey.shade300,
            ),
            child: IconButton(
                onPressed: () {}, icon: const Icon(FontAwesomeIcons.comment)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16.0),
              ),
              color: Colors.grey.shade300,
            ),
            child: IconButton(
                onPressed: () {}, icon: const Icon(FontAwesomeIcons.thumbsUp)),
          ),
        ),
      ],
    );
  }
}

class PostBody extends StatelessWidget {
  const PostBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amman, Jabal-altaj', style: TextStyle(fontFamily: 'Roboto')),
        ],
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('asset/static/image/school.png'),
        ),
        Text(
          'User Name',
          style: TextStyle(
            fontSize: scaleText(24, context),
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          '11:30 AM',
          style: TextStyle(fontSize: scaleText(16, context), fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}

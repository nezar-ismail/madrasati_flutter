import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madrasati/presintation/features/home/widgets/school_card.dart';
import 'package:madrasati/presintation/features/school_info/school_details_page.dart';
import 'package:madrasati/presintation/features/sign_in/role_desesion.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome in Madrasati', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          TextButton(
            onPressed: () {
              //show List of options wich have logout option
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          // Perform logout functionality here
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  RoleDesesion()), (route) => false);
                        },
                      ),  
                    ],
                  );
                },
              );

              
            }, child: const Text('Logout', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Schools...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            // School List
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        // detail page
                        log('index: $index');
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  SchoolDetailPage()));
                      },
                      child: SchoolCard(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
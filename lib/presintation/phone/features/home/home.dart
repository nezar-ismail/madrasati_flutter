import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card.dart';
import 'package:madrasati/presintation/phone/features/school_info/school_details_page.dart';
import 'package:madrasati/presintation/phone/features/sign_in/role_desesion.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome in Madrasati', style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),),
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
                    title: const Text('Logout', style: TextStyle(color: Colors.grey, fontFamily: 'Roboto'),),
                    content: const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),),
                    actions: [
                      TextButton(
                        child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontFamily: 'Roboto'),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout', style: TextStyle(color: Colors.orange, fontFamily: 'Roboto'),),
                        onPressed: () {
                          // Perform logout functionality here
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  RoleDesesion()), (route) => false);
                        },
                      ),  
                    ],
                  );
                },
              );

              
            }, child: const Text('Logout', style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),),
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
              style: const TextStyle( fontFamily: 'Roboto')
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SchoolDetailPage()));
                      },
                      child: const SchoolCard(),
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
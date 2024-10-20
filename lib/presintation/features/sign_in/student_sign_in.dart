import 'package:flutter/material.dart';
import 'package:madrasati/presintation/features/student/view/student_home.dart';

class StudentSignIn extends StatelessWidget {
  const StudentSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Sign In'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 2,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3.0),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('asset/static/image/student.png'),
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentHomePage(),
                  ),
                );
                // Perform login functionality here
              },
              child: const Text(
                'Login as Student',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}

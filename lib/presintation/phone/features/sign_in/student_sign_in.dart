import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/presintation/phone/features/student/view/student_home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StudentSignIn extends StatelessWidget {
  const StudentSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Sign In',
            style: TextStyle(fontFamily: 'Roboto')),
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
                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Roboto'),
                  labelStyle: TextStyle(color: Colors.blue,fontFamily: 'Roboto'),
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
                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Roboto'),
                  labelStyle: TextStyle(color: Colors.blue,fontFamily: 'Roboto'),
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
            final overlayState = Overlay.of(context);
            showTopSnackBar(
              overlayState,
              CustomSnackBar.success(
                message: "Success! This is a success snackbar!",
                backgroundColor: Colors.blue,
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:  Icon(FontAwesomeIcons.book, color: Colors.grey.shade200.withOpacity(0.8), size: 50,),
                ),
                textStyle: const TextStyle(color: Colors.white, fontFamily: 'Roboto'),
              ),
            );
          
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const StudentHomePage(),
                //   ),
                // );
                // Perform login functionality here
              },
              child: const Text(
                'Login as Student',
                style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}

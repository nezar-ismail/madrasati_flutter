import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';

class StudentSignInUi extends StatelessWidget {
  StudentSignInUi({
    super.key,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  hintStyle:
                      TextStyle(color: Colors.grey, fontFamily: 'Roboto'),
                  labelStyle:
                      TextStyle(color: Colors.blue, fontFamily: 'Roboto'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password),
                  hintText: 'Enter your password',
                  hintStyle:
                      TextStyle(color: Colors.grey, fontFamily: 'Roboto'),
                  labelStyle:
                      TextStyle(color: Colors.blue, fontFamily: 'Roboto'),
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
              onPressed: () async {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  final overlayState = Overlay.of(context);
                  customSnackbar(overlayState, 'All fields are required',
                      // ignore: deprecated_member_use
                      FontAwesomeIcons.frown, Colors.red);
                } else {
                  await context.read<SignInCubit>().studentSignIn(
                      email: _emailController.text,
                      password: _passwordController.text
                  );
                }
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

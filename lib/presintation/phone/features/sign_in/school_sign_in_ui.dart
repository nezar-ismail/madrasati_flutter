import 'package:flutter/material.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';

class SchoolSignInUi extends StatelessWidget {
  SchoolSignInUi({
    super.key,
  });

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Sign In',
            style: TextStyle(
              fontFamily: 'Roboto',
            )),
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
                    border: Border.all(color: Colors.green, width: 3.0),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('asset/static/image/school.png'),
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                showCursor: true,
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
                      TextStyle(color: Colors.green, fontFamily: 'Roboto'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                showCursor: true,
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
                      TextStyle(color: Colors.green, fontFamily: 'Roboto'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  final overlayState = Overlay.of(context);
                  customSnackbar(
                      overlayState,
                      "Please enter email and password",
                      Icons.error,
                      Colors.red);
                } else {
                  getIt<SignInCubit>().schoolSignIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
              child: const Text(
                'Login as School',
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

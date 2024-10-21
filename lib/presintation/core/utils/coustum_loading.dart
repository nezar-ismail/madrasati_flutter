import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            
            child: LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    colors: const [
            Colors.black,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.blue,
            Colors.green
                    ],
                    pathBackgroundColor: Colors.white,
                  ),
          )),
    );
  }
}

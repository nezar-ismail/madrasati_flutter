import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Progress',
              style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            LinearProgressIndicator(
              minHeight: MediaQuery.of(context).size.height * 0.03,
              value: 0.6,
              backgroundColor: Colors.grey.shade300,
              color: Colors.black,
              semanticsLabel: 'Linear progress indicator',
              semanticsValue: '60%',
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              borderRadius: BorderRadius.circular(50),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const Text('60%', style: TextStyle(color: Colors.orange,fontFamily: 'Roboto')),
          ],
        ),
      ),
    );
  }
}

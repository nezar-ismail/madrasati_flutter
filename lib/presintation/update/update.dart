import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Update extends StatelessWidget {
  const Update({super.key, required this.updateUrl});

  // Define the URL you want to open
  final String updateUrl; // Replace with your update URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple.shade300,
        title: const Text('Update Required'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ops!, Your App is Outdated'),
            const Text('Please Update Your App'),
            Container(
              height: 50,
              width: 100,
              color: Colors.purple.shade300,
              child: TextButton(
                onPressed: () async {
                  // Try to launch the URL
                  final Uri url = Uri.parse(updateUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    // Handle the case when the URL cannot be opened
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open the update URL.')),
                    );
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

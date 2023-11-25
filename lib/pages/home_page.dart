import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // Create an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle the logout button press
  Future<void> _logout() async {
    await _auth.signOut();
    print("Logged out successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bacelar Co'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("fon!"),
            ElevatedButton(
              onPressed: () async {
                await _logout();
                // navigate back to login page
                Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

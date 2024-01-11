import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_generator/homePage.dart';

class OTPPage extends StatelessWidget {
  final String verificationId;
  final TextEditingController otpController = TextEditingController();

  OTPPage({Key? key, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // OTP Input
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                hintText: 'Enter the 6-digit OTP',
              ),
            ),
            const SizedBox(height: 16.0), // Add some spacing

            // Button to Verify OTP
            ElevatedButton(
              onPressed: () async {
                // Get the entered OTP
                String enteredOTP = otpController.text.trim();

                // Create a PhoneAuthCredential using the entered OTP and verificationId
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: enteredOTP,
                );

                try {
                  // Sign in with the PhoneAuthCredential
                  await FirebaseAuth.instance.signInWithCredential(credential);

                  // Verification successful, navigate to the next screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                } catch (e) {
                  // Verification failed, show an error message or handle it accordingly
                  print('Error verifying OTP: $e');
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

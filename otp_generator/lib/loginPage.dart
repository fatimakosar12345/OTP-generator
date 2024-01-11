import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_generator/OTPpage.dart';
import 'package:otp_generator/homePage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Phone Number Input
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 16.0), // Add some spacing

            // Button to Send OTP
            ElevatedButton(
              onPressed: () {
                // Get the entered phone number
                String phoneNumber = phoneNumberController.text.trim();

                // Call the sendOTP method with the phone number
                sendOTP(context, phoneNumber);
              },
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void sendOTP(BuildContext context, String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          print('Verification completed.');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error in OTP verification: ${e.message}');
          log('Error in OTP verification: ${e.message}', error: e);
        },
        codeSent: (String verificationId, int? resendToken) {
          print('Code sent successfully. Verification ID: $verificationId');
          // Save verificationId for later use
          // Navigate to the OTPPage and pass the verificationId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(
              'Code auto retrieval timed out. Verification ID: $verificationId');
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      log('Error sending OTP: $e', error: e);
    }
  }
}

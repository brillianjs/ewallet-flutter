import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:crypto_wallet_app/screen/home_page.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void verifyOTP() {
    // Logika untuk memverifikasi OTP. Misalnya, memeriksa OTP dengan API atau Firebase.
    String enteredOTP = _otpController.text;
    if (enteredOTP == '123456') {
      // Misalnya OTP yang valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified Successfully!')),
      );
      // Arahkan ke halaman berikutnya setelah OTP valid
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 64, right: 16),
            child: Column(
              children: [
                const SizedBox(height: 50),
                FadeInDown(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/NFT_4.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Enter the OTP sent to your phone',
                  style:
                      TextStyle(color: Colors.yellowAccent[700], fontSize: 20),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                        color: Colors.yellowAccent[700], fontSize: 20),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 50),
                // Menggunakan SizedBox untuk membuat tombol lebar penuh
                SizedBox(
                  width: double.infinity, // Lebar penuh
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellowAccent[700],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        verifyOTP(); // Verifikasi OTP
                      }
                    },
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

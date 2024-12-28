import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Mengubah warna teks dan ikon
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Judul tentang aplikasi
            const Text(
              'About This App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Accordion
            ExpansionTile(
              title: const Text(
                'What is this app?',
                style: TextStyle(color: Colors.white),
              ),
              children: const [
                ListTile(
                  title: Text(
                    'This app is a cryptocurrency wallet that allows you to manage your crypto assets efficiently and securely. With features like transaction tracking, wallet management, and secure storage, it ensures a seamless user experience.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Features',
                style: TextStyle(color: Colors.white),
              ),
              children: const [
                ListTile(
                  title: Text(
                    '• Secure wallet management\n• Transaction tracking\n• Easy-to-use interface\n• Real-time market updates\n• Customizable settings',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'How to use?',
                style: TextStyle(color: Colors.white),
              ),
              children: const [
                ListTile(
                  title: Text(
                    'To get started, create an account, set up your wallet, and begin managing your crypto assets. You can add new transactions, view your balance, and stay updated with market trends.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Contact Us',
                style: TextStyle(color: Colors.white),
              ),
              children: const [
                ListTile(
                  title: Text(
                    'For support, inquiries, or feedback, please reach out to us at: support@crypto-wallet.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

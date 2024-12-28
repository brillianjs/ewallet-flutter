import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:crypto_wallet_app/screen/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import the LoginPage
import 'package:crypto_wallet_app/screen/edit_profile.dart'; // Import the LoginPage
import 'package:crypto_wallet_app/screen/update_password.dart'; // Import the LoginPage
import 'package:crypto_wallet_app/screen/about_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    // final displayName = user?.userMetadata['email'] ?? 'No Name';
    final displayEmail = user?.email ?? 'No Email';
    final displayName = user!.userMetadata!['display_name'] ?? 'No Email';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/profile_picture.png'), // Replace with your profile picture
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                displayName,
                style: TextStyle(
                  color: Colors.yellowAccent[700],
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                displayEmail,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 20),
            _profileOption(
              context,
              icon: IconlyBroken.profile,
              title: 'Edit Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            _profileOption(
              context,
              icon: IconlyBroken.lock,
              title: 'Change Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatePasswordPage()),
                );
              },
            ),
            _profileOption(
              context,
              icon: IconlyBroken.notification,
              title: 'Notifications',
              onTap: () {
                // Implement notifications logic here
              },
            ),
            _profileOption(
              context,
              icon: IconlyBroken.info_circle,
              title: 'About',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent[700],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // Implement logout logic here
                  await Supabase.instance.client.auth.signOut();
                  // Navigate to the login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[400]),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[300], fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}

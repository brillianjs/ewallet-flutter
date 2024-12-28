import 'package:crypto_wallet_app/screen/home_page.dart';
import 'package:crypto_wallet_app/screen/intro_page.dart';
import 'package:crypto_wallet_app/screen/login_page.dart';
import 'package:crypto_wallet_app/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const ProviderScope(child: MyApp()),
    ),
  );
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}

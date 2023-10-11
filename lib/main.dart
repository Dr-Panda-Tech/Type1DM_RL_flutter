import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:type1dm_rl_flutter/views/home.dart';
import 'package:type1dm_rl_flutter/views/home_page.dart';
import 'package:type1dm_rl_flutter/views/auth_page.dart';
import 'package:type1dm_rl_flutter/views/record_page.dart';
import 'package:type1dm_rl_flutter/views/graph_page.dart';
import 'package:type1dm_rl_flutter/views/profile_page.dart';
import 'package:type1dm_rl_flutter/views/signup_page.dart';
import 'package:type1dm_rl_flutter/views/login_page.dart';
import 'package:type1dm_rl_flutter/views/registration_details_page.dart';
import 'package:type1dm_rl_flutter/views/insulin_settings_page.dart';
import 'package:type1dm_rl_flutter/views/news_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Type 1 DM insulin app',
      theme: pandaTheme,
      home: const AuthPage(),
      routes: {
        '/authPage': (context) => const AuthPage(),
        '/signUpPage': (context) => const SignUpPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registrationDetailPage': (context) => const RegistrationDetailsPage(),
        '/insulinSettingsPage': (context) => InsulinSettingsPage(),
        '/home': (context) => const Home(),
        '/homePage': (context) => const HomePage(),
        '/graphPage': (context) => const GraphPage(),
        '/recordPage': (context) => const RecordPage(),
        '/newsPage': (context) => const NewsPage(),
        '/profilePage': (context) => const ProfilePage(),
      },
    );
  }
}

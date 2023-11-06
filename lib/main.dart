import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/firebase_options.dart';

import 'package:type1dm_rl_flutter/views/root_page.dart';
import 'package:type1dm_rl_flutter/views/auth/auth_page.dart';
import 'package:type1dm_rl_flutter/views/auth/demographics_setting.dart';
import 'package:type1dm_rl_flutter/views/auth/user_image_setting.dart';
import 'package:type1dm_rl_flutter/views/auth/insulin_settings_page.dart';
import 'package:type1dm_rl_flutter/views/auth/primary_care_setting_page.dart';
import 'package:type1dm_rl_flutter/views/home/home_page.dart';
import 'package:type1dm_rl_flutter/views/graph/graph_page.dart';
import 'package:type1dm_rl_flutter/views/record/blood_test_page.dart';
import 'package:type1dm_rl_flutter/views/record/record_page.dart';
import 'package:type1dm_rl_flutter/views/record/insulin_update_page.dart';
import 'package:type1dm_rl_flutter/views/record/demographics_mutable_update_page.dart';
import 'package:type1dm_rl_flutter/views/news/news_page.dart';

import 'package:type1dm_rl_flutter/views/profile/profile_page.dart';

import 'package:type1dm_rl_flutter/views/profile/profile_setting/profile_edit_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_setting/external_service_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_setting/notification_setting_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_setting/language_setting_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_setting/security_setting_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_setting/other_setting_page.dart';

import 'package:type1dm_rl_flutter/views/profile/profile_info/privacy_policy.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_info/help_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_info/user_guide_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_info/terms_of_service_page.dart';

import 'package:type1dm_rl_flutter/views/profile/profile_others/contact_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_others/withdrawal_page.dart';

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
      theme: pandaTheme,
      locale: Locale('ja', 'JP'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // これも追加
      ],
      supportedLocales: [
        const Locale('ja', 'JP'), // 日本語
      ],
      home: const AuthPage(),
      routes: {
        '/authPage': (context) => const AuthPage(),
        '/demographicsSettingPage': (context) =>
            const DemographicsSettingPage(),
        '/userImageSettingsPage': (context) => UserImageSettingPage(),
        '/insulinSettingsPage': (context) => InsulinSettingsPage(),
        '/primaryCareSettingsPage': (context) => PrimaryCareSettingsPage(
              fromSettings: false,
            ),
        '/rootPage': (context) => const RootPage(),
        '/homePage': (context) => const HomePage(),
        '/graphPage': (context) => const GraphPage(),
        '/recordPage': (context) => const RecordPage(),
        '/insulinUpdatePage': (context) => InsulinUpdatePage(),
        '/demographicsMutableUpdatePage': (context) => DemographicsMutableUpdatePage(),
        '/bloodTestPage': (context) => BloodTestInputPage(),
        '/newsPage': (context) => NewsPage(),
        '/profilePage': (context) => const ProfilePage(),
        '/externalServicePage': (context) => ExternalServicePage(),
        '/notificationSettingPage': (context) => NotificationSettingPage(),
        '/profileEditPage': (context) => ProfileEditPage(),
        '/otherSettingPage': (context) => OtherSettingsPage(),
        '/languageSettingPage': (context) => LanguageSettingPage(),
        '/securitySettingPage': (context) => SecuritySettingPage(),
        '/privacyPolicyPage': (context) => PrivacyPolicyPage(),
        '/termsOfServicePage': (context) => TermsOfServicePage(),
        '/helpPage': (context) => HelpAndFAQPage(),
        '/userGuidePage': (context) => UserGuidePage(),
        '/contactPage': (context) => ContactPage(),
        '/withdrawalPage': (context) => WithdrawalPage(),
      },
    );
  }
}

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:onze_cofe_project/screens/Home_screen/home_screen.dart';
import 'package:onze_cofe_project/screens/auth/create_account_screen.dart';
import 'package:onze_cofe_project/screens/auth/login_screen.dart';
import 'package:onze_cofe_project/screens/auth/verify_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://atlxmjlltfikucaizoeg.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0bHhtamxsdGZpa3VjYWl6b2VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjczNzkyNDMsImV4cCI6MjA0Mjk1NTI0M30.tdRENvJ39QV3yoTiEDTagQr7xQ3k-sHENQxwGGEuvF8",
  );

  setup();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MainApp(), // Wrap your app
  ));
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("7ea96437-6ba1-4b48-bcc3-6f8767f99504");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomeScreen(),
    );
  }
}

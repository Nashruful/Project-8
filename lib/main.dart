import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/drawer/drawer.dart';

import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://atlxmjlltfikucaizoeg.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0bHhtamxsdGZpa3VjYWl6b2VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjczNzkyNDMsImV4cCI6MjA0Mjk1NTI0M30.tdRENvJ39QV3yoTiEDTagQr7xQ3k-sHENQxwGGEuvF8",
  );
  setup();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MainApp(), // Wrap your app
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: DrawerPage(),
    );
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;
  Map? currentUserInfo = {};

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("user_id", 'a57e1a5d-11ea-4237-a85c-f9504db3ad51')
        .single();
  }
}

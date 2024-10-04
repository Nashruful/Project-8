import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;
  Map? currentUserInfo = {};

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("user_id", supabase.auth.currentUser!.id)
        .single();

      
  }
}

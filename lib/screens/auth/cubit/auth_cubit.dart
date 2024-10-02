import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  AuthCubit() : super(AuthInitial());
  final supabase = getIt.get<DataLayer>().supabase;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController logInController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  signUp() async {
    emit(LoadingState());
    try {
      await supabase.auth.signInWithOtp(email: emailController.text);
      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (_) {
      emit(ErrorState(msg: "Account already registered"));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  signIn() async {
    emit(LoadingState());
    try {
      await supabase.auth.signInWithOtp(email: logInController.text);
      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  verifyOTP({required String email, required String otp}) async {
    emit(LoadingState());
    try {
      await supabase.auth.signOut();
      print(supabase.auth.currentSession?.user.lastSignInAt);
      // await supabase.auth
      //     .verifyOTP(type: OtpType.signup, email: email, token: otp);

      // await supabase.auth
      //     .verifyOTP(type: OtpType.magiclink, email: email, token: otp);

      await supabase
          .from("users")
          .insert({"email": email, "name": nameController.text});
      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    emailController.dispose();
    return super.close();
  }
}

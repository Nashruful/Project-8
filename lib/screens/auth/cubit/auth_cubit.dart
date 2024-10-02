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

  signUp() async {
    emit(LoadingState());
    try {
      final response = await supabase
          .from("users")
          .select()
          .eq("email", emailController.text);
      if (response.isNotEmpty) {
        emit(ErrorState(msg: "Account Already registered."));
      } else {
        await supabase.auth.signInWithOtp(email: emailController.text);
        emit(SuccessState());
      }
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
      final response = await supabase
          .from("users")
          .select()
          .eq("email", logInController.text);
      if (response.isEmpty) {
        emit(ErrorState(msg: "Account not found."));
      } else {
        await supabase.auth.signInWithOtp(email: logInController.text);
        emit(SuccessState());
      }
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  verifyOTP({required String otp, required String email}) async {
    emit(LoadingState());
    try {
      await supabase.auth
          .verifyOTP(type: OtpType.magiclink, email: email, token: otp);

      await getIt.get<DataLayer>().getUserInfo();

      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  firstTimeVerifyOTP(
      {required String otp,
      required String email,
      required String name}) async {
    emit(LoadingState());
    try {
      final data = await supabase.auth
          .verifyOTP(type: OtpType.signup, email: email, token: otp);

      await supabase
          .from("users")
          .insert({"user_id": data.user?.id, "email": email, "name": name});

      await getIt.get<DataLayer>().getUserInfo();

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

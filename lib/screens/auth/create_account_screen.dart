import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/components/text_form_field/custom_text_form_field.dart';
import 'package:onze_cofe_project/screens/auth/cubit/auth_cubit.dart';
import 'package:onze_cofe_project/screens/auth/first_time_verify.dart';
import 'package:onze_cofe_project/screens/auth/login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthStatee>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                        content: CircularProgressIndicator(),
                      ));
            }
            if (state is SuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FirstTimeVerify(
                          firstName: cubit.nameController.text,
                          email: cubit.emailController.text)));
            }
            if (state is ErrorState) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.msg)));
            }
          },
          child: Scaffold(
            body: CustomBackgroundContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/pattren 1.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: "Sign Up",
                                color: Color(0xffD7D2CB),
                                size: 24)),
                        const SizedBox(
                          height: 40,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Email",
                              color: Color(0x72FFFFFF),
                              size: 12),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        CustomTextFormField(
                            controller: cubit.emailController,
                            hintText: "Enter Your Email"),
                        const SizedBox(
                          height: 21,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Name", color: Color(0x72FFFFFF), size: 12),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        CustomTextFormField(
                            controller: cubit.nameController,
                            hintText: "Enter Your Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                                text: "Already have an account?",
                                color: Color(0x71FFFFFF),
                                size: 12),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const CustomText(
                                  text: "Login",
                                  color: Color(0xffA8483D),
                                  size: 12),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffA8483D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(21.5))),
                              onPressed: () {
                                cubit.signUp();
                              },
                              child: const Center(
                                child: CustomText(
                                    text: "Sign up",
                                    color: Color(0xffF4F4F4),
                                    size: 12),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

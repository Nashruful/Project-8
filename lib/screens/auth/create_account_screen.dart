import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/components/text_form_field/custom_text_form_field.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          text: "Sign in", color: Color(0xffD7D2CB), size: 24)),
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        text: "Email", color: Color(0x72FFFFFF), size: 12),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  const CustomTextFormField(hintText: "Enter Your Email"),
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
                  const CustomTextFormField(hintText: "Enter Your Name"),
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
                                borderRadius: BorderRadius.circular(21.5))),
                        onPressed: () {},
                        child: const Center(
                          child: const CustomText(
                              text: "Sign in",
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
    );
  }
}

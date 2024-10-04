import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/screens/welcome_screen/cubit/welcome_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocBuilder<WelcomeCubit, WelcomeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                        onPageChanged: (index) {
                          context.read<WelcomeCubit>().goToPage(index);
                        },
                        controller: _pageController,
                        children: [
                          Stack(
                            children: [
                              Flexible(
                                child: Opacity(
                                  opacity: 0.85,
                                  child: Image.asset(
                                    "assets/images/unsplash_TYIzeCiZ_60.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          text: "Sip. Smile. Create.",
                                          color: Color(0xffE1DBD4),
                                          size: 24),
                                    ),
                                    SizedBox(
                                      child: CustomText(
                                          text:
                                              "Lorem ipsum dolor sit amet consectetur. Eget purus rhoncus fringilla fermentum semper ornare sit tempus nullam. ",
                                          color: Color(0x72FFFFFF),
                                          size: 16),
                                    ),
                                    SizedBox(
                                      height: 119,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              Flexible(
                                child: Opacity(
                                  opacity: 0.85,
                                  child: Image.asset(
                                    "assets/images/image 12.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          text: "Sip. Smile. Create.",
                                          color: Color(0xffE1DBD4),
                                          size: 24),
                                    ),
                                    SizedBox(
                                      child: CustomText(
                                          text:
                                              "Lorem ipsum dolor sit amet consectetur. Eget purus rhoncus fringilla fermentum semper ornare sit tempus nullam. ",
                                          color: Color(0x72FFFFFF),
                                          size: 16),
                                    ),
                                    SizedBox(
                                      height: 119,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              Flexible(
                                child: Opacity(
                                  opacity: 0.85,
                                  child: Image.asset(
                                    "assets/images/image.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          text: "Sip. Smile. Create.",
                                          color: Color(0xffE1DBD4),
                                          size: 24),
                                    ),
                                    SizedBox(
                                      child: CustomText(
                                          text:
                                              "Lorem ipsum dolor sit amet consectetur. Eget purus rhoncus fringilla fermentum semper ornare sit tempus nullam. ",
                                          color: Color(0x72FFFFFF),
                                          size: 16),
                                    ),
                                    SizedBox(
                                      height: 119,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                context.read<WelcomeCubit>().nextPage();
                                _pageController.animateToPage(
                                  context.read<WelcomeCubit>().currentPage,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff3D6B7D)),
                              child: const CustomText(
                                  text: "Next",
                                  color: Color(0xffF4F4F4),
                                  size: 12)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  context.read<WelcomeCubit>().currentPage == 0
                                      ? 8
                                      : 6,
                              width:
                                  context.read<WelcomeCubit>().currentPage == 0
                                      ? 8
                                      : 6,
                              decoration: BoxDecoration(
                                color:
                                    context.read<WelcomeCubit>().currentPage ==
                                            0
                                        ? Colors.white
                                        : const Color(0x51FFFFFF),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height:
                                  context.read<WelcomeCubit>().currentPage == 1
                                      ? 8
                                      : 6,
                              width:
                                  context.read<WelcomeCubit>().currentPage == 1
                                      ? 8
                                      : 6,
                              decoration: BoxDecoration(
                                color:
                                    context.read<WelcomeCubit>().currentPage ==
                                            1
                                        ? Colors.white
                                        : const Color(0x51FFFFFF),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height:
                                  context.read<WelcomeCubit>().currentPage == 2
                                      ? 8
                                      : 6,
                              width:
                                  context.read<WelcomeCubit>().currentPage == 2
                                      ? 8
                                      : 6,
                              decoration: BoxDecoration(
                                color:
                                    context.read<WelcomeCubit>().currentPage ==
                                            2
                                        ? Colors.white
                                        : const Color(0x51FFFFFF),
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

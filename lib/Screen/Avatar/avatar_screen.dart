import 'package:cached_network_image/cached_network_image.dart';
import 'package:days_21/Data/Repository/sing_avatar_repository.dart';
import 'package:days_21/Helper/helper.dart';
import 'package:days_21/Screen/Avatar/bloc/avatar_bloc.dart';
import 'package:days_21/Screen/Goal/goals_screen.dart';
import 'package:days_21/Screen/widget/days_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingAvatarScreen extends StatefulWidget {
  const SingAvatarScreen({super.key});

  @override
  State<SingAvatarScreen> createState() => _SingAvatarScreenState();
}

class _SingAvatarScreenState extends State<SingAvatarScreen> {
  final PageController _pageController = PageController();
  int imageId = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        imageId = _pageController.page!.round() + 1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextEditingController name = TextEditingController();

    return BlocProvider(
      create: (context) {
        final singAvatarBloc = AvatarBloc(singAvatarRepository);
        singAvatarBloc.stream.forEach((state) {
          if (state is AvatarErrorState) {
            setState(() {
              isLoading = false;
            });
            massanger(context: context, text: state.appException.message);
          } else if (state is AvatarUpdateProfileSuccessState) {
            setState(() {
              isLoading = false;
            });
            navigatorPush(
                context: context,
                screen: GoalScreen(
                  golas: state.avatarsGoalsRespone,
                ));
          }
        });
        singAvatarBloc.add(AvatarStartEvent());
        return singAvatarBloc;
      },
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: BlocBuilder<AvatarBloc, AvatarState>(
                buildWhen: (previous, current) {
                  return current is AvatarInitial ||
                      current is AvatarLoadState ||
                      current is AvatarSuccessState;
                },
                builder: (context, state) {
                  if (state is AvatarSuccessState) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
                          child: Text(
                            'به برنامه تغییر عادات \nو ساختن سبک زندگی خوش آمدید',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: themeData.colorScheme.primary,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 150,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          controller: _pageController,
                                          itemCount: state.avatarsGoalsRespone
                                              .avatars.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: CachedNetworkImage(
                                                imageUrl: state
                                                    .avatarsGoalsRespone
                                                    .avatars[index]
                                                    .image,
                                              ),
                                            );
                                          },
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          left: 0,
                                          right: 0,
                                          child: Center(
                                            child: SizedBox(
                                              width: 242,
                                              height: 40,
                                              child: TextField(
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black),
                                                controller: name,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(32),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor: themeData
                                                        .colorScheme.surface,
                                                    hintText: 'اسمتون لطفا',
                                                    hintStyle: themeData
                                                        .textTheme.bodyMedium!
                                                        .copyWith(fontSize: 22),
                                                    alignLabelWithHint: true),
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 64,
                                  ),
                                  SizedBox(
                                    width: 78,
                                    height: 34,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (name.text.length < 3) {
                                          massanger(
                                              context: context,
                                              text:
                                                  'نام نمی تواند کمتر از 3 حرف باشد');
                                        } else {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          BlocProvider.of<AvatarBloc>(context)
                                              .add(
                                            AvatarButtonClickedEvent(
                                              name.text,
                                              imageId,
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            themeData.colorScheme.secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 12,
                                              height: 12,
                                              child:
                                                  CircularProgressIndicator())
                                          : Text(
                                              'تایید',
                                              style: TextStyle(
                                                color: themeData
                                                    .colorScheme.primary,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 48),
                                              child: Hero(
                                                tag: 'days',
                                                child: Image.asset(
                                                  'assets/images/Days.png',
                                                  width: 128,
                                                  height: 80,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 82,
                                              child: Hero(
                                                tag: '21',
                                                child: Image.asset(
                                                  'assets/images/21.png',
                                                  width: 98,
                                                  height: 133,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const DaysWhite(),
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (state is AvatarLoadState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AvatarErrorState) {
                    return const Text('خطا');
                  } else {
                    return const Text('خطای نا مشخص');
                  }
                },
              ),
            ),
          )),
    );
  }
}

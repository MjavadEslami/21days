import 'package:days_21/Data/Model/avatars_goals_response.dart';
import 'package:days_21/Data/Repository/sing_avatar_repository.dart';
import 'package:days_21/Helper/helper.dart';
import 'package:days_21/Screen/Goal/bloc/goal_bloc.dart';
import 'package:days_21/Screen/Planing/planing_screen.dart';
import 'package:days_21/Screen/widget/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoalScreen extends StatefulWidget {
  final AvatarsGoalsRespone golas;
  const GoalScreen({super.key, required this.golas});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showModal(context);
    });
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          message:
              'لطفا از موارد زیر ۳ مورد رو انتخاب کن، اونهایی که دوست داری با عادت های جدید توی شخصیت خودت بیشتر ببینیشون',
        );
      },
    );
  }

  List<int> selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Directionality(
        textDirection: TextDirection.ltr,
        child: BlocProvider(
          create: (context) {
            final bloc = GoalBloc(singAvatarRepository);
            bloc.stream.forEach((state) {
              if (state is GoalSubmitErrorState) {
                massanger(context: context, text: state.exception.message);
              } else if (state is GoalSubmitSuccessState) {
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (context) => const PlaningScreen()),
                //     (Route<dynamic> route) => false);
                navigatorPush(context: context, screen: const PlaningScreen());
              }
            });
            bloc.add(GoalSubmitStartEvent());
            return bloc;
          },
          child: BlocBuilder<GoalBloc, GoalState>(
            buildWhen: (previous, current) {
              return current is GoalSubmitLoadingState ||
                  current is GoalSubmitErrorState ||
                  current is GoalSubmitSuccessState;
            },
            builder: (context, state) {
              return Scaffold(
                floatingActionButton: Visibility(
                    visible: selectedSkills.length == 3 ? true : false,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20, bottom: 8),
                      child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: const Color.fromARGB(255, 94, 94, 94),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: state is GoalSubmitLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : SvgPicture.asset(
                                    'assets/images/checked.svg',
                                    // ignore: deprecated_member_use
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<GoalBloc>(context)
                              .add(GoalSubmitButtonClickEvent(selectedSkills));
                        },
                      ),
                    )),
                backgroundColor: themeData.colorScheme.primary,
                body: SafeArea(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const _TopHeader();
                        case 1:
                          return SizedBox(
                            height: 515,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.golas.goals.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          if (selectedSkills.length > 2) {
                                            if (!selectedSkills.contains(
                                                widget.golas.goals[index].id)) {
                                              selectedSkills.removeAt(0);
                                              selectedSkills.add(
                                                  widget.golas.goals[index].id);
                                            }
                                          } else if (selectedSkills.contains(
                                              widget.golas.goals[index].id)) {
                                            selectedSkills
                                                .removeWhere((element) {
                                              return element ==
                                                  widget.golas.goals[index].id;
                                            });
                                          } else {
                                            selectedSkills.add(
                                                widget.golas.goals[index].id);
                                          }
                                        },
                                      );
                                    },
                                    child: Opacity(
                                      opacity: selectedSkills.contains(
                                              widget.golas.goals[index].id)
                                          ? 1
                                          : .3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            64, 4, 0, 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    widget.golas.goals[index]
                                                        .image,
                                                    width: 96,
                                                    height: 96,
                                                  ),
                                                  Positioned(
                                                    left: 70,
                                                    top: 30,
                                                    child: Container(
                                                      width: 180,
                                                      height: 38,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16),
                                                      decoration: BoxDecoration(
                                                        color: themeData
                                                            .colorScheme
                                                            .surface,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(64),
                                                        border: Border.all(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                85,
                                                                85,
                                                                85),
                                                            width: 1),
                                                      ),
                                                      child: Text(widget.golas
                                                          .goals[index].text),
                                                    ),
                                                  )
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
                        default:
                          return null;
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
              ),
              Positioned(
                  child: Hero(
                      tag: 'new-habbits',
                      child: SvgPicture.asset('assets/images/habits.svg'))),
              Positioned(
                left: 15,
                top: 25,
                child: Hero(
                  tag: 'days',
                  child: Image.asset(
                    'assets/images/Days.png',
                    width: 200,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                left: -18,
                top: -22,
                child: Hero(
                  tag: '21',
                  child: Image.asset(
                    'assets/images/21.png',
                    width: 135,
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

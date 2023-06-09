import 'package:cached_network_image/cached_network_image.dart';
import 'package:days_21/Data/Model/plans_response.dart';
import 'package:days_21/Data/Repository/planing_repository.dart';
import 'package:days_21/Helper/helper.dart';
import 'package:days_21/Screen/Planing/bloc/plan_bloc.dart';
import 'package:days_21/Screen/payment_getway_screen.dart';
import 'package:days_21/Screen/widget/days_white.dart';
import 'package:days_21/Screen/widget/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

int planId = 1;
bool isLoading = false;
String name = '';
String image = '';

class PlaningScreen extends StatefulWidget {
  const PlaningScreen({super.key});

  @override
  State<PlaningScreen> createState() => _PlaningScreenState();
}

class _PlaningScreenState extends State<PlaningScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          message:
              'برای استفاده از برنامه لطفا ابتدا جهت خرید اشتراک اقدام کنید',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (context) {
        final planBloc = PlanBloc(planingRepository);
        planBloc.stream.forEach((state) {
          if (state is PlanBuyingSuccessSatet) {
            setState(() {
              isLoading = false;
            });
            navigatorPush(
                context: context,
                screen: PaymentGetWayScreen(
                  bankGateWayUrl: state.bankGetWay,
                  name: name,
                  image: image,
                ));
          }
        });
        planBloc.add(PlanStartEvent());
        return planBloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<PlanBloc, PlanState>(
            buildWhen: (previous, current) {
              if (current is PlanSuccessSate) {
                Future.delayed(Duration.zero, () {
                  _showModal(context);
                });
              }
              return current is PlanLoadingState || current is PlanSuccessSate;
            },
            builder: (context, state) {
              if (state is PlanSuccessSate) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'avatar',
                            child: CachedNetworkImage(
                              imageUrl: state.user.avatarUrl,
                              width: 78,
                              height: 99,
                            ),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('سلام ${state.user.name}',
                                  style: themeData.textTheme.titleLarge),
                              Text(
                                  'خیلی قشنگه که داری روی بهتر\n شدنت کار میکنی',
                                  style: themeData.textTheme.bodySmall)
                            ],
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 700,
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
                              height: 180,
                            ),
                            SizedBox(
                              height: 385,
                              child: _PlansList(
                                plans: state.plans.plans,
                                themeData: themeData,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 40),
                                        child: Image.asset(
                                          'assets/images/Days.png',
                                          width: 128,
                                          height: 80,
                                        ),
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: 82,
                                        child: Image.asset(
                                          'assets/images/21.png',
                                          width: 98,
                                          height: 133,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 61),
                                  child: SizedBox(
                                    width: 100,
                                    height: 34,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          isLoading = true;
                                          name = state.user.name;
                                          image = state.user.avatarUrl;
                                        });
                                        BlocProvider.of<PlanBloc>(context)
                                            .add(PlanBuyingButtonEvent(planId));
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
                                              width: 16,
                                              height: 16,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'پرداخت',
                                              style: TextStyle(
                                                  color: themeData
                                                      .colorScheme.primary),
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const DaysWhite(),
                      ],
                    )
                  ],
                );
              } else if (state is PlanLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else if (state is PlanLoadingError) {
                return Center(
                  child: Text(state.exception.message),
                );
              } else {
                return const Center(
                  child: Text('خطای نا سیستمی'),
                );
              }
            },
          ),
        ))),
      ),
    );
  }
}

class _PlansList extends StatefulWidget {
  final List<Plan> plans;
  const _PlansList({
    required this.plans,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  State<_PlansList> createState() => _PlansListState();
}

class _PlansListState extends State<_PlansList> {
  int selecetdPlan = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.plans.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: widget.themeData.colorScheme.secondary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selecetdPlan = index;
                        planId = widget.plans[index].id;
                      });
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.plans[index].totalPrice.toString(),
                              style: widget.themeData.textTheme.titleLarge!
                                  .copyWith(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                            ),
                            Text(widget.plans[index].titleUnderPrice),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.plans[index].title),
                            Text(widget.plans[index].subTitle1),
                            Text(widget.plans[index].subTitle2),
                          ],
                        )),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: widget.themeData.colorScheme.primary
                                    .withOpacity(.5),
                                width: 1),
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: selecetdPlan == index
                              ? Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 30,
                                    child: SvgPicture.asset(
                                      'assets/images/checked.svg',
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

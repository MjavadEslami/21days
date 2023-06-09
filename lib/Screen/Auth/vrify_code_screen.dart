import 'package:days_21/Data/Repository/auth_repository.dart';
import 'package:days_21/Helper/helper.dart';
import 'package:days_21/Screen/Auth/bloc/auth_bloc.dart';
import 'package:days_21/Screen/Planing/planing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Avatar/avatar_screen.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String phone;
  const VerifyCodeScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final TextEditingController code = TextEditingController();

    final ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
          child: BlocProvider<AuthBloc>(
        create: (context) {
          final bloc = AuthBloc(authRepository);
          bloc.stream.forEach((state) {
            if (state is AuthErrorState) {
              massanger(context: context, text: state.exception.message);
            } else if (state is AuthVerfiyCodeSuccessState) {
              if (!state.userReponse.user.registerCompleted ||
                  state.userReponse.goals.isEmpty) {
                navigatorPush(
                    context: context, screen: const SingAvatarScreen());
              } else if (!state.userReponse.user.isPremium) {
                navigatorPush(context: context, screen: const PlaningScreen());
              } else {
                massanger(context: context, text: 'همه چی اوکیه');
              }
            }
          });
          bloc.add(AuthStartEvent());
          return bloc;
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            return current is AuthVerfiyCodeLoadingState ||
                current is AuthInitial ||
                current is AuthVerfiyCodeSuccessState ||
                current is AuthErrorState;
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: themeData.colorScheme.surface,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.PNG'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: TextField(
                      controller: code,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      maxLength: 11,
                      decoration: InputDecoration(
                          isDense: true,
                          counterText: "",
                          hintText: 'کد ورود',
                          hintStyle: themeData.textTheme.bodyMedium!
                              .copyWith(fontSize: 20),
                          alignLabelWithHint: true),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 200,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                        if (code.text.isEmpty || code.text.length != 4) {
                          massanger(context: context, text: 'کد را وارد کنید');
                        } else {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthVerfiyCodeEvent(phone, code.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontFamily: 'iranYekan', fontSize: 22),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: state is AuthVerfiyCodeLoadingState
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'تایید کد',
                              style: TextStyle(
                                  color: themeData.colorScheme.surface),
                            ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}

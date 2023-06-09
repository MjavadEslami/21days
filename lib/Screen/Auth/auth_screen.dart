import 'package:days_21/Data/Repository/auth_repository.dart';
import 'package:days_21/Helper/helper.dart';
import 'package:days_21/Screen/Auth/bloc/auth_bloc.dart';
import 'package:days_21/Screen/Auth/vrify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phone = TextEditingController();

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
            } else if (state is AuthSendSmsSuccessState) {
              navigatorPush(
                  context: context,
                  screen: VerifyCodeScreen(phone: phone.text));
            }
          });
          bloc.add(AuthStartEvent());
          return bloc;
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            return current is AuthSendSmsLoadingState ||
                current is AuthInitial ||
                current is AuthSendSmsSuccessState ||
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
                      controller: phone,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      maxLength: 11,
                      decoration: InputDecoration(
                          isDense: true,
                          counterText: "",
                          hintText: 'شماره تماس',
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
                        if (phone.text.isEmpty) {
                          massanger(
                              context: context,
                              text: 'شماره تماس را وارد کنید');
                        } else {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthSendSmsEvent(phone.text));
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
                      child: state is AuthSendSmsLoadingState
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'دریافت کد تایید',
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../core/app_cubit/base_state.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/constants.dart';
import '../../../core/views/widgets/phone_number_field.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../model/auth_model.dart';
import '../widgets/auth_scaffold.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isPasswordVisible = false;
  AuthCubit authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        middle: Container(
          height: 100,
          alignment: Alignment.topCenter,
          child:
              SizedBox(width: 100,child: Hero(tag: 'logo', child: Image.asset('assets/images/logo.png'))),
        ),
        child: Form(
          key: formKey,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(
                height: 32,
              ),
              EmailField(

                controller: controllerEmail,
                borderRadius: 10,
              ),
              const SizedBox(
                height: 16,
              ),
              StatefulBuilder(builder: (context, hello) {
                return TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: controllerPassword,
                  validator: Validators.validatePassword,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'password'.tr(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          hello(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye)),
                  ),
                );
              }),
              // Align(
              //     alignment: AlignmentDirectional.topEnd,
              //     child: TextButton(
              //         onPressed: () {
              //           context.push(NamedRoutes.forgotPassword);
              //         },
              //         child: Text('forgot_password'.tr()))),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<AuthCubit, BaseState<AuthModel>>(
                bloc: authCubit,
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      loaded: (data) {
                        if ((data as AuthModel).token != null) {
                          if (authCubit.getUserType() == UserType.patient) {
                            context.go(NamedRoutes.home);
                          } else {
                            context.go(NamedRoutes.callsHistory);
                          }
                        }
                      });
                },
                builder: (context, state) {
                  return state.maybeWhen(
                      orElse: () => MainButton(
                            title: 'signin'.tr(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                authCubit.login(
                                    email: controllerEmail.text,
                                    password: controllerPassword.text);
                              } else {
                                HapticFeedback.vibrate();
                              }
                            },
                          ),
                      loading: () => MainButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            title: '',
                            onPressed: () {},
                            isLoading: true,
                          ));
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dont_have_account'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                      onPressed: () {
                        context.push(NamedRoutes.signup);
                      },
                      style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.titleLarge),
                      child: Text(
                        'signup'.tr(),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/phone_number_field.dart';
import '../../../core/app_cubit/base_state.dart';
import '../../../core/di/injection_container.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../model/auth_model.dart';
import '../widgets/auth_scaffold.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  bool isPasswordVisible = false;
  AuthCubit authCubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        middle: Container(
          height: 100,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 100,
            child: Hero(
              tag: 'logo',
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ),
        child: Form(
          key: formKey,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: Validators.validateName,
                controller: controllerName,
                decoration: InputDecoration(
                  hintText: 'first_name'.tr(),
                ),
              ),
              const SizedBox(
                height: 16,
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
                            title: 'signup'.tr(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                authCubit.register(
                                  name: controllerName.text,
                                  email:  controllerEmail.text,
                                  password: controllerPassword.text,
                                );
                              } else {
                                HapticFeedback.vibrate();
                              }
                            },
                          ),
                      loading: () => MainButton(
                            title: '',
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            isLoading: true,
                            onPressed: () {},
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
                    'already_have_account'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.titleLarge),
                      child: Text(
                        'signin'.tr(),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

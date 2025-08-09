import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/go_router.dart';
import '../../../auth/cubit/auth_cubit/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthCubit _authCubit = getIt<AuthCubit>();
  bool showLogo = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        showLogo = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      // getIt<HomeCubit>().appLocale = context.locale;

      final token = _authCubit.getToken();
      if (token == null) {
        context.go(NamedRoutes.signin);
      } else {
        if (_authCubit.getUserType() == UserType.patient) {
          context.go(NamedRoutes.home);
        } else {
          context.go(NamedRoutes.callsHistory);
        }
        // _authCubit.getProfile();
        // _authCubit.stream.listen((event) {
        //   event.maybeWhen(
        //       orElse: () {},
        //       error: (error) {
        //         if (error.statusCode == 401) {
        //           getIt<SharedPreferences>().remove(Constants.tokenKey);
        //           context.go(NamedRoutes.login);
        //         }
        //       },
        //       loaded: (data) {
        //         if (mounted&&data!=null) {
        //           if ((data.hasVerifiedPhone ?? false)||(data.hasVerifiedEmail ?? false)) {
        //             context.go(NamedRoutes.home);
        //           } else {
        //             _authCubit.phoneNumber =
        //                 splitCountryCode(data.phone ?? '')['phone_number'] ??
        //                     '';
        //             context.go(NamedRoutes.verification);
        //           }
        //         }
        //       });
        // });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AnimatedOpacity(
        opacity: showLogo ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 200, child: Hero(tag: 'logo',child: Image.asset('assets/images/logo.png'))),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: BlocBuilder<AuthCubit, AuthState>(
    //     bloc: _authCubit,
    //     builder: (context, state) => state.maybeWhen(
    //         orElse: () => const LoaderWidget(
    //               size: 100,
    //             ),
    //         error: (error) => ErrorView(
    //             error: error.statusMessage,
    //             onRetry: () {
    //               _authCubit.getProfile();
    //             })),
    //   ),
    // );
  }
}

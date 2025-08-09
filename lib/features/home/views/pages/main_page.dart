
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/color_light_scheme.dart';
import '../../../../core/utils/go_router.dart';
import '../../../auth/cubit/auth_cubit/auth_cubit.dart';
import '../../cubit/main_cubit/bottom_nav_state.dart';
import '../../cubit/main_cubit/botttom_nav_cubit.dart';

class MainPage extends StatefulWidget {
  final Widget currentPage;
  final String currentRoute;

  const MainPage(
      {super.key, required this.currentPage, required this.currentRoute});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late BottomNavCubit _bottomNavCubit;

  @override
  void initState() {
    super.initState();

    _bottomNavCubit = getIt<BottomNavCubit>();
    _bottomNavCubit.init(widget.currentRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
        bloc: _bottomNavCubit,
        builder: (context, state) {
          bool canPop =
              _bottomNavCubit.selectedPageIndex == _bottomNavCubit.mainPage;
          return PopScope(
            canPop: canPop,
            onPopInvoked: (value) {
              if (_bottomNavCubit.selectedPageIndex !=
                  _bottomNavCubit.mainPage) {
                _bottomNavCubit.updatePageIndex(
                    context, _bottomNavCubit.mainPage);
              }
            },
            child: Scaffold(
              key: scaffoldKey,
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 60),
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                  'logout'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  'logout_warning'.tr(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () async {
                                      context.go(NamedRoutes.signin);
                                      final loggedOut =
                                          await getIt<AuthCubit>().logout();
                                    },
                                    child: Text(
                                      'logout'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                    child: Text(
                                      'cancel'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: lightColorScheme.primary),
                                    ),
                                    onPressed: () {
                                      context.pop();
                                    },
                                  )
                                ],
                              ));
                    },
                  ),
                  title: Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                ),
              ),
              body: widget.currentPage,
              // bottomNavigationBar: SizedBox(
              //   height: 72,
              //   child: BottomNavigationBar(
              //     backgroundColor: lightColorScheme.primary,
              //     items: _bottomNavCubit.navItems(),
              //     elevation: 0,
              //     onTap: (index) {
              //       _bottomNavCubit.updatePageIndex(context, index);
              //     },
              //     type: BottomNavigationBarType.fixed,
              //     currentIndex: _bottomNavCubit.selectedPageIndex,
              //     selectedItemColor: Colors.white,
              //     unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
              //   ),
              // ),
            ),
          );
        });
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

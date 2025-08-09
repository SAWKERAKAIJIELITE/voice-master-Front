import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/color_light_scheme.dart';
import '../../../../core/utils/go_router.dart';
import '../../../auth/cubit/auth_cubit/auth_cubit.dart';
import '../../views/widgets/route_bottom_navigation_bar_item.dart';
import 'bottom_nav_state.dart';

@lazySingleton
class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState.initial());

  int selectedPageIndex = (getIt<AuthCubit>().getUserType() == UserType.patient)?0:1;
  int mainPage=(getIt<AuthCubit>().getUserType() == UserType.patient)?0:1;

  List<MyCustomBottomNavBarItem> navItems() => [
          _bottomNavigationBarItem(
            title: 'home'.tr(),
            route: NamedRoutes.home,
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
          ),
          _bottomNavigationBarItem(
            title: 'calls_history'.tr(),
            route: NamedRoutes.callsHistory,
            activeIcon: const Icon(Icons.phone_callback),
            icon: const Icon(Icons.phone_callback_outlined),
          ),
      ];

  updatePageIndex(
    BuildContext context,
    int index, {
    Object? extra,
  }) {
    emit(const BottomNavState.initial());
    selectedPageIndex = index;
    context.go(navItems()[index].route, extra: extra);
    emit(BottomNavState.bottomNavLoaded(index));
  }

  init(String currentRoute) {
    emit(const BottomNavState.initial());
    final index =
        navItems().indexWhere((element) => element.route == currentRoute);
    selectedPageIndex = index;
    emit(BottomNavState.bottomNavLoaded(index));
  }

  MyCustomBottomNavBarItem _bottomNavigationBarItem(
      {required Widget icon,
      required Widget activeIcon,
      required String title,
      required String route}) {
    return MyCustomBottomNavBarItem(
      icon: icon,
      activeIcon: activeIcon,
      label: title,
      tooltip: title,
      route: route,
    );
  }
}

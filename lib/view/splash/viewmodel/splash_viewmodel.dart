import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_api/_product/constant/routes_path.dart';
import 'package:marvel_api/core/base/model/base_viewmodel.dart';
import 'package:marvel_api/core/config/navigation/navigation_service.dart';
import 'package:mobx/mobx.dart';
part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => mContext = context;

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 3350), () {
      NavigationService.instance.navigateToReset(path: RoutesPath.home);
    });
  }
}

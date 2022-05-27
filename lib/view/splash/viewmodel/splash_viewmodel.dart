import 'package:flutter/material.dart';
import 'package:marvel_api/core/base/model/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => mContext = context;

  @override
  void init() async {}
}

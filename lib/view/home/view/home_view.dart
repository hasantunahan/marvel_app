import 'package:flutter/material.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
import 'package:marvel_api/_product/widget/marve_base_widget/marvel_base_widget.dart';
import 'package:marvel_api/core/base/view/base_view.dart';
import 'package:marvel_api/view/home/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeViewModel _homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: _homeViewModel,
      routeObserver: CustomNavigationRouter.instance.routeObserver,
      builder: (context, value) {
        return MarvelBaseWidget(
          child: Container(),
        );
      },
    );
  }
}

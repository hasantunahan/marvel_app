import 'package:flutter/material.dart';
import 'package:marvel_api/_product/constant/animation_offset.dart';
import 'package:marvel_api/_product/constant/assets.dart';
import 'package:marvel_api/_product/widget/marve_base_widget/marvel_base_widget.dart';
import 'package:marvel_api/core/base/view/base_view.dart';
import 'package:marvel_api/core/extension/context_extension.dart';
import 'package:marvel_api/core/widgets/delayed_widget/delayed_widget.dart';
import 'package:marvel_api/view/splash/viewmodel/splash_viewmodel.dart';

const _IMAGE_WIDTH_RATIO = .7;
const _ANIMATION_DURATION = Duration(milliseconds: 1350);

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final SplashViewModel _splashViewModel = SplashViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: _splashViewModel,
      builder: (context, value) {
        return MarvelBaseWidget(
          hideAppBar: true,
          child: _renderBody(context),
        );
      },
    );
  }

  Widget _renderBody(BuildContext context) {
    return DelayedDisplay(
      slidingBeginOffset: AnimationPosition.TOP.animate(),
      slidingCurve: Curves.linear,
      fadingDuration: _ANIMATION_DURATION,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: context.theme.colorScheme.primary,
                spreadRadius: 1,
              ),
            ],
          ),
          child: _renderImage(context),
        ),
      ),
    );
  }

  Widget _renderImage(BuildContext context) {
    return Image.asset(
      Assets.instance.logo,
      width: context.width * _IMAGE_WIDTH_RATIO,
    );
  }
}

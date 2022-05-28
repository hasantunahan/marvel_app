import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
import 'package:marvel_api/_product/constant/assets.dart';
import 'package:marvel_api/_product/constant/padding.dart';
import 'package:marvel_api/_product/widget/marve_base_widget/marvel_base_widget.dart';
import 'package:marvel_api/core/base/view/base_view.dart';
import 'package:marvel_api/core/extension/context_extension.dart';
import 'package:marvel_api/core/widgets/delayed_widget/delayed_widget.dart';
import 'package:marvel_api/generated/language_extension.dart';
import 'package:marvel_api/view/home/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeViewModel _homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: _homeViewModel,
      routeObserver: CustomNavigationRouter.instance.routeObserver,
      builder: (context, viewModel) {
        return MarvelBaseWidget(
          hideAppBar: true,
          child: _renderBody(context, viewModel),
        );
      },
    );
  }

  Widget _renderBody(BuildContext context, HomeViewModel viewModel) {
    return Container(
      decoration: _renderBackgroundDecoration(),
      child: Stack(
        children: [
          Column(
            children: [
              _renderTopTitle(context),
              _renderMarvelCharacterList(viewModel),
            ],
          ),
          _renderLoadingWidget(context, viewModel),
        ],
      ),
    );
  }

  BoxDecoration _renderBackgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage("https://i.pinimg.com/originals/30/97/2c/30972cd9960912d77cab2b52e878ac2f.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _renderTopTitle(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: context.width,
        padding: AppPadding.instance.symmetricPaddingHorizontalMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.instance.logo,
              width: 80,
              height: 40,
            ),
            const SizedBox(height: 16.0),
            Text(
              context.lang.choose_character,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _renderMarvelCharacterList(HomeViewModel viewModel) {
    return Observer(
      builder: (context) {
        if (viewModel.characterList == null) {
          return const SizedBox();
        } else {
          return Flexible(
            child: DelayedDisplay(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                controller: viewModel.scrollController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: context.width * .33,
                  childAspectRatio: 40 / 60,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: viewModel.characterList!.length,
                itemBuilder: (context, index) {
                  return _renderCharacterWidget(
                    viewModel,
                    index,
                    context,
                    () {
                      log(viewModel.characterList![index].name!);
                    },
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _renderCharacterWidget(HomeViewModel viewModel, int index, BuildContext context, VoidCallback onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: AppPadding.instance.allPaddingLow,
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _renderCharacterImage(viewModel, index, context),
                  ),
                  _renderCharacterName(viewModel, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _renderCharacterName(HomeViewModel viewModel, int index) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: AppPadding.instance.allPaddingLow,
            child: Text(
              viewModel.characterList![index].name ?? "",
              maxLines: 5,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Image _renderCharacterImage(HomeViewModel viewModel, int index, BuildContext context) {
    return Image.network(
      "${viewModel.characterList![index].thumbnail!.path!}/portrait_xlarge.jpg",
      height: context.width * .6,
      width: context.width * .5,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.withOpacity(0.2),
          height: context.width * .6,
        );
      },
    );
  }

  Widget _renderLoadingWidget(BuildContext context, HomeViewModel viewModel) {
    return Observer(builder: (context) {
      return Visibility(
        visible: viewModel.isLoading,
        child: Container(
          width: context.width,
          color: context.theme.colorScheme.background.withOpacity(0.15),
          child: Padding(
            padding: AppPadding.instance.allPaddingMedium,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      );
    });
  }
}

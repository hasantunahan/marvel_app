import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
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
          title: context.lang.marvel_character_list,
          child: Stack(
            children: [
              _renderMarvelCharacterList(viewModel),
              _renderLoadingWidget(context, viewModel),
            ],
          ),
        );
      },
    );
  }

  Widget _renderMarvelCharacterList(HomeViewModel viewModel) {
    return Observer(
      builder: (context) {
        if (viewModel.characterList == null) {
          return const SizedBox();
        } else {
          return DelayedDisplay(
            child: GridView.builder(
              controller: viewModel.scrollController,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 40 / 60,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
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
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: AppPadding.instance.allPaddingLow,
                          child: Text(
                            viewModel.characterList![index].name ?? "",
                            maxLines: 5,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderLoadingWidget(BuildContext context, HomeViewModel viewModel) {
    return Observer(builder: (context) {
      return Visibility(
        visible: viewModel.isLoading,
        child: Container(
          width: context.width,
          color: context.theme.colorScheme.secondary.withOpacity(0.15),
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

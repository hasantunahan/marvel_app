import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
import 'package:marvel_api/_product/constant/padding.dart';
import 'package:marvel_api/_product/widget/marve_base_widget/marvel_base_widget.dart';
import 'package:marvel_api/core/base/view/base_view.dart';
import 'package:marvel_api/core/extension/context_extension.dart';
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
              Column(
                children: [
                  const SizedBox(height: 16),
                  _renderMarvelCharacterList(viewModel),
                ],
              ),
              _renderLoadingWidget(context, viewModel),
            ],
          ),
        );
      },
    );
  }

  Observer _renderMarvelCharacterList(HomeViewModel viewModel) {
    return Observer(
      builder: (context) {
        if (viewModel.characterList == null) {
          return const SizedBox();
        } else {
          return Flexible(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 40 / 63,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: viewModel.characterList!.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "${viewModel.characterList![index].thumbnail!.path!}/portrait_xlarge.jpg",
                        height: context.width * .6,
                        width: context.width * .4,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.withOpacity(0.2),
                            height: context.width * .6,
                            width: context.width * .4,
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          viewModel.characterList![index].name ?? "",
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
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

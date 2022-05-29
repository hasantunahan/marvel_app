import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
import 'package:marvel_api/_product/constant/padding.dart';
import 'package:marvel_api/_product/widget/marve_base_widget/marvel_base_widget.dart';
import 'package:marvel_api/core/base/view/base_view.dart';
import 'package:marvel_api/core/config/navigation/arguments.dart';
import 'package:marvel_api/core/config/navigation/navigation_service.dart';
import 'package:marvel_api/core/extension/context_extension.dart';
import 'package:marvel_api/generated/language_extension.dart';
import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/view/character_detail/viewmodel/character_detail_viewmodel.dart';

class CharacterDetailView extends StatefulWidget {
  const CharacterDetailView({Key? key}) : super(key: key);

  @override
  State<CharacterDetailView> createState() => _CharacterDetailViewState();
}

class _CharacterDetailViewState extends State<CharacterDetailView> {
  bool once = false;
  late CharacterDetailViewModel _characterDetailViewModel;
  late CharacterResponseModel _args;
  NavigationArguments? pageArguments;

  void initialize(BuildContext context) {
    if (!once) {
      once = true;
      if (ModalRoute.of(context)!.settings.arguments != null) {
        pageArguments = ModalRoute.of(context)!.settings.arguments as NavigationArguments;
      }
      _args = pageArguments?.data != null ? pageArguments?.data as CharacterResponseModel : CharacterResponseModel();
      _characterDetailViewModel = CharacterDetailViewModel(_args);
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize(context);
    return BaseView<CharacterDetailViewModel>(
      viewModel: _characterDetailViewModel,
      onBackAction: (viewmodel) async {
        NavigationService.instance.back();
        return Future.value(true);
      },
      routeObserver: CustomNavigationRouter.instance.routeObserver,
      builder: (context, viewModel) {
        return MarvelBaseWidget(
          hideAppBar: true,
          child: Stack(
            children: [
              _renderBody(context, viewModel),
              _renderLoadingWidget(context, viewModel),
            ],
          ),
        );
      },
    );
  }

  Widget _renderBody(BuildContext context, CharacterDetailViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderTopImage(context),
        _renderCharacterName(context),
        _renderCharacterDescription(),
        _renderComicsTitle(context),
        _renderComicsWidget(viewModel),
      ],
    );
  }

  Observer _renderComicsWidget(CharacterDetailViewModel viewModel) {
    return Observer(builder: (context) {
      if (viewModel.comicList == null) {
        return const SizedBox();
      } else if (viewModel.comicList!.isEmpty) {
        return Padding(
          padding: AppPadding.instance.symmetricPaddingHorizontalMedium,
          child: Text(
            context.lang.after_2005_empty,
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 0.24,
              color: context.theme.colorScheme.onError,
            ),
          ),
        );
      } else {
        return Expanded(
          child: Padding(
            padding: AppPadding.instance.symmetricPaddingHorizontalMedium,
            child: _renderComicList(viewModel),
          ),
        );
      }
    });
  }

  ListView _renderComicList(CharacterDetailViewModel viewModel) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: viewModel.comicList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: AppPadding.instance.symmetricPaddingVerticalLow,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "${viewModel.comicList![index].thumbnail!.path!}/portrait_xlarge.jpg",
                height: context.width * .21,
                width: context.width * .14,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.withOpacity(0.2),
                    height: context.width * .21,
                  );
                },
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.comicList![index].title ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      viewModel.comicList![index].description == null
                          ? context.lang.description_not_found
                          : viewModel.comicList![index].description! == ""
                              ? context.lang.description_not_found
                              : viewModel.comicList![index].description!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _renderComicsTitle(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.allPaddingMedium,
      child: Row(
        children: [
          const Icon(
            Icons.book,
            size: 15,
          ),
          Text(
            context.lang.comics,
            style: const TextStyle(fontSize: 15, letterSpacing: 0.24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Padding _renderCharacterDescription() {
    return Padding(
      padding: AppPadding.instance.symmetricPaddingHorizontalMedium,
      child: Text(
        _args.description == null
            ? context.lang.description_not_found
            : _args.description! == ""
                ? context.lang.description_not_found
                : _args.description!,
        style: const TextStyle(
          fontSize: 13,
          letterSpacing: 0.24,
        ),
      ),
    );
  }

  Padding _renderCharacterName(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.allPaddingMedium,
      child: Text(
        _args.name!,
        style: context.theme.textTheme.headline5
            ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black, letterSpacing: 0.24),
      ),
    );
  }

  Widget _renderTopImage(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          "${_args.thumbnail!.path}/landscape_incredible.jpg",
          height: context.width * .5625,
          fit: BoxFit.contain,
          width: context.width,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.withOpacity(0.2),
              height: context.width,
            );
          },
        ),
        Positioned(
          top: MediaQuery.of(context).viewInsets.top + 44,
          left: 12.0,
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: IconButton(
              onPressed: () {
                NavigationService.instance.back();
              },
              splashColor: context.theme.colorScheme.primary,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderLoadingWidget(BuildContext context, CharacterDetailViewModel viewModel) {
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

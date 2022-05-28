import 'package:flutter/material.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
import 'package:marvel_api/_product/widget/marve_base_widget/marvel_base_widget.dart';
import 'package:marvel_api/core/base/view/base_view.dart';
import 'package:marvel_api/core/config/navigation/arguments.dart';
import 'package:marvel_api/core/config/navigation/navigation_service.dart';
import 'package:marvel_api/core/extension/context_extension.dart';
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
      builder: (context, value) {
        return MarvelBaseWidget(
          hideAppBar: true,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    "${_args.thumbnail!.path}/standard_amazing.jpg",
                    height: context.width,
                    fit: BoxFit.cover,
                    width: context.width,
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
              ),
            ],
          ),
        );
      },
    );
  }
}

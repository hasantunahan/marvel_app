import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:marvel_api/core/base/model/base_viewmodel.dart';
import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/view/home/repository/home_repository.dart';
import 'package:mobx/mobx.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;
const int _LIMIT = 30;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  final HomeRepository _homeRepository = HomeRepository();
  final ScrollController scrollController = ScrollController();
  @observable
  List<CharacterResponseModel>? characterList;

  @observable
  bool isLoading = false;

  @observable
  int _offset = 0;

  @observable
  int totalCount = 0;

  @action
  void pagination() {
    if (characterList != null) {
      if ((scrollController.position.pixels == scrollController.position.maxScrollExtent) && (_offset <= totalCount)) {
        _offset += _LIMIT;
        getCharacterList();
      }
    }
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> getCharacterList() async {
    changeLoading();
    final res = await _homeRepository.getCharacters(
      limit: _LIMIT,
      offset: _offset,
    );
    totalCount = res.data!.total!;
    characterList = [...?characterList, ...res.data!.results!];
    changeLoading();
  }

  @override
  void setContext(BuildContext context) => mContext = context;

  @override
  Future<void> init() async {
    await getCharacterList();
    scrollController.addListener(pagination);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:marvel_api/core/base/model/base_viewmodel.dart';
import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/view/home/repository/home_repository.dart';
import 'package:mobx/mobx.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  final HomeRepository _homeRepository = HomeRepository();

  @observable
  List<CharacterResponseModel>? characterList;

  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> getCharacterList() async {
    changeLoading();
    final res = await _homeRepository.getCharacters();
    characterList = res.data!.results;
    changeLoading();
    log("ok");
  }

  @override
  void setContext(BuildContext context) => mContext = context;

  @override
  Future<void> init() async {
    await getCharacterList();
  }
}

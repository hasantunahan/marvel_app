import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:marvel_api/core/base/model/base_viewmodel.dart';
import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/network/model/comics/comics_response_model.dart';
import 'package:marvel_api/view/character_detail/repository/character_detail_repository.dart';
import 'package:mobx/mobx.dart';
part 'character_detail_viewmodel.g.dart';

const String _ORDER_BY = "-onsaleDate";
const int _LIMIT = 10;
const int _COMPARATOR_DATE = 2005;

class CharacterDetailViewModel = _CharacterDetailViewModelBase with _$CharacterDetailViewModel;

abstract class _CharacterDetailViewModelBase with Store, BaseViewModel {
  final CharacterResponseModel args;
  _CharacterDetailViewModelBase(this.args);

  final CharacterDetailRepository _characterDetailRepository = CharacterDetailRepository();

  @observable
  List<ComicResponseModel>? comicList;

  @observable
  bool isLoading = false;
  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> getCharacterComics({required int characterId}) async {
    changeLoading();
    final res = await _characterDetailRepository.getCharacterComics(
      characterId: characterId,
      limit: _LIMIT,
      orderBy: _ORDER_BY,
    );
    if (res.data != null) {
      if (res.data!.results!.isEmpty) {
        comicList = [];
      } else {
        for (var element in res.data!.results!) {
          DateTime _date = DateTime.parse(element.dates![0].date!);
          log("${_date.year.toString()} // ${element.title}");
          if (_date.year >= _COMPARATOR_DATE) {
            comicList = [...?comicList, element];
          } else {
            comicList = [...?comicList];
          }
        }
      }
    } else {
      comicList = [];
    }
    changeLoading();
    log("details ok");
  }

  @override
  void setContext(BuildContext context) => mContext = context;

  @override
  Future<void> init() async {
    await getCharacterComics(characterId: args.id!);
  }
}

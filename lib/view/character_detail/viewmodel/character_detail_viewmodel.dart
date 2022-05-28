import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:marvel_api/core/base/model/base_viewmodel.dart';
import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:mobx/mobx.dart';
part 'character_detail_viewmodel.g.dart';

class CharacterDetailViewModel = _CharacterDetailViewModelBase with _$CharacterDetailViewModel;

abstract class _CharacterDetailViewModelBase with Store, BaseViewModel {
  final CharacterResponseModel args;
  _CharacterDetailViewModelBase(this.args);

  @override
  void setContext(BuildContext context) => mContext = context;

  @override
  Future<void> init() async {
    log(args.name!);
  }
}

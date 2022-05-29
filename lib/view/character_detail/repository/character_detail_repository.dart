import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/network/model/comics/comics_response_model.dart';
import 'package:marvel_api/network/response/pagination_model.dart';
import 'package:marvel_api/network/response/response_model.dart';
import 'package:marvel_api/network/services/characters/character_service.dart';
import 'package:marvel_api/view/character_detail/repository/i_character_details_repository.dart';

class CharacterDetailRepository extends ICharacterDetailRepository {
  CharacterService get _characterService => CharacterService();

  @override
  Future<ResponseModel<PaginationModel<ComicResponseModel>>> getCharacterComics(
      {required int characterId, int? limit, int? offset, String? name, int? series, int? comics,String? orderBy})
  async {
    try {
      final res = await _characterService.getCharacterComics(characterId, limit, offset, name, series, comics,orderBy);
      if (res.code == 200) {
        return res;
      } else {
        return ResponseModel();
      }
    } catch (e) {
      return ResponseModel();
    }
  }
}

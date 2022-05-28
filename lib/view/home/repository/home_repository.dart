import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/network/response/pagination_model.dart';
import 'package:marvel_api/network/response/response_model.dart';
import 'package:marvel_api/network/services/characters/character_service.dart';
import 'package:marvel_api/view/home/repository/i_home_repository.dart';

class HomeRepository extends IHomeRepository {
  CharacterService get _characterService => CharacterService();

  @override
  Future<ResponseModel<PaginationModel<CharacterResponseModel>>> getCharacters(
      {int? limit, int? offset, String? name, int? series, int? comics}) async {
    try {
      final res = await _characterService.getCharacters( limit, offset, name, series, comics);
      if (res.code == 200) {
        return res;
      }

      /// TODO :: error handling can be added -> Future maybe
      else {
        return ResponseModel();
      }
    } catch (e) {
      return ResponseModel();
    }
  }
}

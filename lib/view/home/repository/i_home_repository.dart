import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/network/response/pagination_model.dart';
import 'package:marvel_api/network/response/response_model.dart';

abstract class IHomeRepository {
  Future<ResponseModel<PaginationModel<CharacterResponseModel>>> getCharacters(
      {int? limit, int? offset, String? name, int? series, int? comics});
}

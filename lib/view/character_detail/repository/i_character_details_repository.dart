import 'package:marvel_api/network/model/comics/comics_response_model.dart';
import 'package:marvel_api/network/response/pagination_model.dart';
import 'package:marvel_api/network/response/response_model.dart';

abstract class ICharacterDetailRepository {
  Future<ResponseModel<PaginationModel<ComicResponseModel>>> getCharacterComics(
      {required int characterId, int? limit, int? offset, String? name, int? series, int? comics, String? orderBy});
}

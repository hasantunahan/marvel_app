import "package:dio/dio.dart";
import 'package:marvel_api/network/api.dart';
import 'package:marvel_api/network/api_path.dart';
import 'package:marvel_api/network/model/characters/characters_response_model.dart';
import 'package:marvel_api/network/model/comics/comics_response_model.dart';
import 'package:marvel_api/network/response/pagination_model.dart';
import 'package:marvel_api/network/response/response_model.dart';
import "package:retrofit/retrofit.dart";

part "character_service.g.dart";

@RestApi()
abstract class CharacterService {
  factory CharacterService({Dio? dio}) => _CharacterService(dio ?? API.instance.createDio());

  @GET(ApiPath.character + ApiPath.authParams)
  Future<ResponseModel<PaginationModel<CharacterResponseModel>>> getCharacters(
    @Query("limit") int? limit,
    @Query("offset") int? offset,
    @Query("name") String? name,
    @Query("series") int? series,
    @Query("comics") int? comics,
  );

  @GET("${ApiPath.character}/{characterId}/${ApiPath.comics}${ApiPath.authParams}")
  Future<ResponseModel<PaginationModel<ComicResponseModel>>> getCharacterComics(
    @Path("characterId") int characterId,
    @Query("limit") int? limit,
    @Query("offset") int? offset,
    @Query("name") String? name,
    @Query("series") int? series,
    @Query("comics") int? comics,
    @Query("orderBy") String? orderBy,
  );
}

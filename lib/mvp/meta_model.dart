import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class MetaModel extends Object {
  @JsonKey(name: 'pagination')
  Pagination pagination;

  MetaModel(
    this.pagination,
  );

  factory MetaModel.fromJson(Map<String, dynamic> srcJson) =>
      _$MetaModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}

@JsonSerializable()
class Pagination extends Object {
  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'count')
  int pagCount;

  @JsonKey(name: 'per_page')
  int perPage;

  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'total_pages')
  int totalPages;

  Pagination(
    this.total,
    this.pagCount,
    this.perPage,
    this.currentPage,
    this.totalPages,
  );

  factory Pagination.fromJson(Map<String, dynamic> srcJson) =>
      _$PaginationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

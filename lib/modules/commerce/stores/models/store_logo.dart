import 'package:core/modules/storage/models/file_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_logo.freezed.dart';
part 'store_logo.g.dart';


@freezed
class StoreLogo with _$StoreLogo {

  factory StoreLogo({
    FileModel? image,
    FileModel? darkImage,
  }) = _StoreLogo;

  factory StoreLogo.fromJson(Map<String, dynamic> json) => _$StoreLogoFromJson(json);
}
import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_model.freezed.dart';
part 'store_model.g.dart';

@freezed
class StoreModel with _$StoreModel implements Model {

  factory StoreModel({
    @ModelRefSerializer()
    required ModelRef ref,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
    ///
    required String name,
    String? title,
    String? description,
    AddressModel? address,
    // StoreLogo logo, 


  }) = _StoreModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) => _$StoreModelFromJson(json);
}
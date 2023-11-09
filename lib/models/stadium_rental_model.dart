import 'package:core/models/stadium_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core.dart';

part 'stadium_rental_model.freezed.dart';
part 'stadium_rental_model.g.dart';

enum StadiumRentalStatus {
  paid,
  unpaid,
  halfPaid,
  canceled,
  expired,
}


@freezed
class StadiumRentalModel with _$StadiumRentalModel implements Model {

  factory StadiumRentalModel({
    @ModelRefSerializer()
    required ModelRef ref,
    required StadiumModel stadium,
    required ProfileModel client,
    // the admin who created this rental
    required ProfileModel createdBy,
    required StadiumRentalStatus status,
    @TimestampDateTimeSerializer()
    @DurationSerializer()
    required Map<DateTime,Duration> rents,
    @TimestampDateTimeSerializer()
    @Default({}) Map<String,dynamic> metadata,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
  }) = _StadiumRentalModel;

  factory StadiumRentalModel.fromJson(Map<String, dynamic> json) => _$StadiumRentalModelFromJson(json);



  static ModelDescription<StadiumRentalModel> get description => ModelDescription<StadiumRentalModel>(
        fields: {
          FieldDescription(
            name: "status",
            path: "status",
            nullable: true,
            type: FieldType.text,
            map: (m) => m.status.name,
            group: FieldGroup.primary,
          ),
        },
        name: "Stadium Rental",
        path: "stadiumRentals",
        fromJson: StadiumRentalModel.fromJson,
        tileBuilder: (model) => ModelGeneralData(
          title: model.stadium.name + " - " + model.client.displayName + " (" + model.status.name + ")",
          // subtitle: model..toString().split(" ")[0] + " -> " + model.to.toString().split(" ")[0],
        ),
        actions: [],
      );
}

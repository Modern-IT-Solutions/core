// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_logo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreLogoImpl _$$StoreLogoImplFromJson(Map<String, dynamic> json) =>
    _$StoreLogoImpl(
      image: json['image'] == null
          ? null
          : FileModel.fromJson(json['image'] as Map<String, dynamic>),
      darkImage: json['darkImage'] == null
          ? null
          : FileModel.fromJson(json['darkImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StoreLogoImplToJson(_$StoreLogoImpl instance) =>
    <String, dynamic>{
      'image': instance.image?.toJson(),
      'darkImage': instance.darkImage?.toJson(),
    };

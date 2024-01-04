// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_logo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoreLogo _$StoreLogoFromJson(Map<String, dynamic> json) {
  return _StoreLogo.fromJson(json);
}

/// @nodoc
mixin _$StoreLogo {
  FileModel? get image => throw _privateConstructorUsedError;
  FileModel? get darkImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreLogoCopyWith<StoreLogo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreLogoCopyWith<$Res> {
  factory $StoreLogoCopyWith(StoreLogo value, $Res Function(StoreLogo) then) =
      _$StoreLogoCopyWithImpl<$Res, StoreLogo>;
  @useResult
  $Res call({FileModel? image, FileModel? darkImage});

  $FileModelCopyWith<$Res>? get image;
  $FileModelCopyWith<$Res>? get darkImage;
}

/// @nodoc
class _$StoreLogoCopyWithImpl<$Res, $Val extends StoreLogo>
    implements $StoreLogoCopyWith<$Res> {
  _$StoreLogoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? darkImage = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as FileModel?,
      darkImage: freezed == darkImage
          ? _value.darkImage
          : darkImage // ignore: cast_nullable_to_non_nullable
              as FileModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FileModelCopyWith<$Res>? get image {
    if (_value.image == null) {
      return null;
    }

    return $FileModelCopyWith<$Res>(_value.image!, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FileModelCopyWith<$Res>? get darkImage {
    if (_value.darkImage == null) {
      return null;
    }

    return $FileModelCopyWith<$Res>(_value.darkImage!, (value) {
      return _then(_value.copyWith(darkImage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreLogoImplCopyWith<$Res>
    implements $StoreLogoCopyWith<$Res> {
  factory _$$StoreLogoImplCopyWith(
          _$StoreLogoImpl value, $Res Function(_$StoreLogoImpl) then) =
      __$$StoreLogoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FileModel? image, FileModel? darkImage});

  @override
  $FileModelCopyWith<$Res>? get image;
  @override
  $FileModelCopyWith<$Res>? get darkImage;
}

/// @nodoc
class __$$StoreLogoImplCopyWithImpl<$Res>
    extends _$StoreLogoCopyWithImpl<$Res, _$StoreLogoImpl>
    implements _$$StoreLogoImplCopyWith<$Res> {
  __$$StoreLogoImplCopyWithImpl(
      _$StoreLogoImpl _value, $Res Function(_$StoreLogoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? darkImage = freezed,
  }) {
    return _then(_$StoreLogoImpl(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as FileModel?,
      darkImage: freezed == darkImage
          ? _value.darkImage
          : darkImage // ignore: cast_nullable_to_non_nullable
              as FileModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreLogoImpl implements _StoreLogo {
  _$StoreLogoImpl({this.image, this.darkImage});

  factory _$StoreLogoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreLogoImplFromJson(json);

  @override
  final FileModel? image;
  @override
  final FileModel? darkImage;

  @override
  String toString() {
    return 'StoreLogo(image: $image, darkImage: $darkImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreLogoImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.darkImage, darkImage) ||
                other.darkImage == darkImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, image, darkImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreLogoImplCopyWith<_$StoreLogoImpl> get copyWith =>
      __$$StoreLogoImplCopyWithImpl<_$StoreLogoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreLogoImplToJson(
      this,
    );
  }
}

abstract class _StoreLogo implements StoreLogo {
  factory _StoreLogo({final FileModel? image, final FileModel? darkImage}) =
      _$StoreLogoImpl;

  factory _StoreLogo.fromJson(Map<String, dynamic> json) =
      _$StoreLogoImpl.fromJson;

  @override
  FileModel? get image;
  @override
  FileModel? get darkImage;
  @override
  @JsonKey(ignore: true)
  _$$StoreLogoImplCopyWith<_$StoreLogoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

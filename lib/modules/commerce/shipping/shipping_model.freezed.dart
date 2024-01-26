// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipping_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShippingModel _$ShippingModelFromJson(Map<String, dynamic> json) {
  return _ShippingModel.fromJson(json);
}

/// @nodoc
mixin _$ShippingModel {
  AddressModel get address => throw _privateConstructorUsedError;
  ProfileModel? get profile => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get phoneNumbers => throw _privateConstructorUsedError;
  List<String> get emails => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShippingModelCopyWith<ShippingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingModelCopyWith<$Res> {
  factory $ShippingModelCopyWith(
          ShippingModel value, $Res Function(ShippingModel) then) =
      _$ShippingModelCopyWithImpl<$Res, ShippingModel>;
  @useResult
  $Res call(
      {AddressModel address,
      ProfileModel? profile,
      String name,
      List<String> phoneNumbers,
      List<String> emails,
      String? note,
      Map<String, dynamic> metadata});

  $AddressModelCopyWith<$Res> get address;
  $ProfileModelCopyWith<$Res>? get profile;
}

/// @nodoc
class _$ShippingModelCopyWithImpl<$Res, $Val extends ShippingModel>
    implements $ShippingModelCopyWith<$Res> {
  _$ShippingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? profile = freezed,
    Object? name = null,
    Object? phoneNumbers = null,
    Object? emails = null,
    Object? note = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumbers: null == phoneNumbers
          ? _value.phoneNumbers
          : phoneNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emails: null == emails
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res> get address {
    return $AddressModelCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $ProfileModelCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShippingModelImplCopyWith<$Res>
    implements $ShippingModelCopyWith<$Res> {
  factory _$$ShippingModelImplCopyWith(
          _$ShippingModelImpl value, $Res Function(_$ShippingModelImpl) then) =
      __$$ShippingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AddressModel address,
      ProfileModel? profile,
      String name,
      List<String> phoneNumbers,
      List<String> emails,
      String? note,
      Map<String, dynamic> metadata});

  @override
  $AddressModelCopyWith<$Res> get address;
  @override
  $ProfileModelCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$ShippingModelImplCopyWithImpl<$Res>
    extends _$ShippingModelCopyWithImpl<$Res, _$ShippingModelImpl>
    implements _$$ShippingModelImplCopyWith<$Res> {
  __$$ShippingModelImplCopyWithImpl(
      _$ShippingModelImpl _value, $Res Function(_$ShippingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? profile = freezed,
    Object? name = null,
    Object? phoneNumbers = null,
    Object? emails = null,
    Object? note = freezed,
    Object? metadata = null,
  }) {
    return _then(_$ShippingModelImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumbers: null == phoneNumbers
          ? _value._phoneNumbers
          : phoneNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emails: null == emails
          ? _value._emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShippingModelImpl implements _ShippingModel {
  const _$ShippingModelImpl(
      {required this.address,
      this.profile,
      required this.name,
      required final List<String> phoneNumbers,
      required final List<String> emails,
      this.note,
      final Map<String, dynamic> metadata = const {}})
      : _phoneNumbers = phoneNumbers,
        _emails = emails,
        _metadata = metadata;

  factory _$ShippingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShippingModelImplFromJson(json);

  @override
  final AddressModel address;
  @override
  final ProfileModel? profile;
  @override
  final String name;
  final List<String> _phoneNumbers;
  @override
  List<String> get phoneNumbers {
    if (_phoneNumbers is EqualUnmodifiableListView) return _phoneNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phoneNumbers);
  }

  final List<String> _emails;
  @override
  List<String> get emails {
    if (_emails is EqualUnmodifiableListView) return _emails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emails);
  }

  @override
  final String? note;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'ShippingModel(address: $address, profile: $profile, name: $name, phoneNumbers: $phoneNumbers, emails: $emails, note: $note, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShippingModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._phoneNumbers, _phoneNumbers) &&
            const DeepCollectionEquality().equals(other._emails, _emails) &&
            (identical(other.note, note) || other.note == note) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      profile,
      name,
      const DeepCollectionEquality().hash(_phoneNumbers),
      const DeepCollectionEquality().hash(_emails),
      note,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShippingModelImplCopyWith<_$ShippingModelImpl> get copyWith =>
      __$$ShippingModelImplCopyWithImpl<_$ShippingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShippingModelImplToJson(
      this,
    );
  }
}

abstract class _ShippingModel implements ShippingModel {
  const factory _ShippingModel(
      {required final AddressModel address,
      final ProfileModel? profile,
      required final String name,
      required final List<String> phoneNumbers,
      required final List<String> emails,
      final String? note,
      final Map<String, dynamic> metadata}) = _$ShippingModelImpl;

  factory _ShippingModel.fromJson(Map<String, dynamic> json) =
      _$ShippingModelImpl.fromJson;

  @override
  AddressModel get address;
  @override
  ProfileModel? get profile;
  @override
  String get name;
  @override
  List<String> get phoneNumbers;
  @override
  List<String> get emails;
  @override
  String? get note;
  @override
  Map<String, dynamic> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ShippingModelImplCopyWith<_$ShippingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

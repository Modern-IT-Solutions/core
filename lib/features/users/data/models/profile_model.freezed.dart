// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;
  List<Role> get roles => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  Map<String, dynamic> get customClaims => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime? get lastSignInAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      String displayName,
      String email,
      String? phoneNumber,
      DateTime? birthday,
      String photoUrl,
      Address? address,
      String uid,
      bool disabled,
      List<Role> roles,
      bool emailVerified,
      Map<String, dynamic> metadata,
      Map<String, dynamic> customClaims,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime? updatedAt,
      @TimestampDateTimeSerializer() DateTime? deletedAt,
      @TimestampDateTimeSerializer() DateTime? lastSignInAt});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? displayName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? birthday = freezed,
    Object? photoUrl = null,
    Object? address = freezed,
    Object? uid = null,
    Object? disabled = null,
    Object? roles = null,
    Object? emailVerified = null,
    Object? metadata = null,
    Object? customClaims = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? lastSignInAt = freezed,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Role>,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      customClaims: null == customClaims
          ? _value.customClaims
          : customClaims // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInAt: freezed == lastSignInAt
          ? _value.lastSignInAt
          : lastSignInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProfileModelCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$_ProfileModelCopyWith(
          _$_ProfileModel value, $Res Function(_$_ProfileModel) then) =
      __$$_ProfileModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      String displayName,
      String email,
      String? phoneNumber,
      DateTime? birthday,
      String photoUrl,
      Address? address,
      String uid,
      bool disabled,
      List<Role> roles,
      bool emailVerified,
      Map<String, dynamic> metadata,
      Map<String, dynamic> customClaims,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime? updatedAt,
      @TimestampDateTimeSerializer() DateTime? deletedAt,
      @TimestampDateTimeSerializer() DateTime? lastSignInAt});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$_ProfileModelCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$_ProfileModel>
    implements _$$_ProfileModelCopyWith<$Res> {
  __$$_ProfileModelCopyWithImpl(
      _$_ProfileModel _value, $Res Function(_$_ProfileModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? displayName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? birthday = freezed,
    Object? photoUrl = null,
    Object? address = freezed,
    Object? uid = null,
    Object? disabled = null,
    Object? roles = null,
    Object? emailVerified = null,
    Object? metadata = null,
    Object? customClaims = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? lastSignInAt = freezed,
  }) {
    return _then(_$_ProfileModel(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Role>,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      customClaims: null == customClaims
          ? _value._customClaims
          : customClaims // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInAt: freezed == lastSignInAt
          ? _value.lastSignInAt
          : lastSignInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfileModel implements _ProfileModel {
  _$_ProfileModel(
      {@ModelRefSerializer() required this.ref,
      required this.displayName,
      required this.email,
      this.phoneNumber,
      this.birthday,
      required this.photoUrl,
      required this.address,
      required this.uid,
      required this.disabled,
      required final List<Role> roles,
      required this.emailVerified,
      final Map<String, dynamic> metadata = const {},
      final Map<String, dynamic> customClaims = const {},
      @TimestampDateTimeSerializer() required this.createdAt,
      @TimestampDateTimeSerializer() this.updatedAt,
      @TimestampDateTimeSerializer() this.deletedAt,
      @TimestampDateTimeSerializer() this.lastSignInAt})
      : _roles = roles,
        _metadata = metadata,
        _customClaims = customClaims;

  factory _$_ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileModelFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final DateTime? birthday;
  @override
  final String photoUrl;
  @override
  final Address? address;
  @override
  final String uid;
  @override
  final bool disabled;
  final List<Role> _roles;
  @override
  List<Role> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final bool emailVerified;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final Map<String, dynamic> _customClaims;
  @override
  @JsonKey()
  Map<String, dynamic> get customClaims {
    if (_customClaims is EqualUnmodifiableMapView) return _customClaims;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customClaims);
  }

  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime? updatedAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime? deletedAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime? lastSignInAt;

  @override
  String toString() {
    return 'ProfileModel(ref: $ref, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, birthday: $birthday, photoUrl: $photoUrl, address: $address, uid: $uid, disabled: $disabled, roles: $roles, emailVerified: $emailVerified, metadata: $metadata, customClaims: $customClaims, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, lastSignInAt: $lastSignInAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileModel &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._customClaims, _customClaims) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.lastSignInAt, lastSignInAt) ||
                other.lastSignInAt == lastSignInAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ref,
      displayName,
      email,
      phoneNumber,
      birthday,
      photoUrl,
      address,
      uid,
      disabled,
      const DeepCollectionEquality().hash(_roles),
      emailVerified,
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_customClaims),
      createdAt,
      updatedAt,
      deletedAt,
      lastSignInAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfileModelCopyWith<_$_ProfileModel> get copyWith =>
      __$$_ProfileModelCopyWithImpl<_$_ProfileModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileModelToJson(
      this,
    );
  }
}

abstract class _ProfileModel implements ProfileModel {
  factory _ProfileModel(
          {@ModelRefSerializer() required final ModelRef ref,
          required final String displayName,
          required final String email,
          final String? phoneNumber,
          final DateTime? birthday,
          required final String photoUrl,
          required final Address? address,
          required final String uid,
          required final bool disabled,
          required final List<Role> roles,
          required final bool emailVerified,
          final Map<String, dynamic> metadata,
          final Map<String, dynamic> customClaims,
          @TimestampDateTimeSerializer() required final DateTime createdAt,
          @TimestampDateTimeSerializer() final DateTime? updatedAt,
          @TimestampDateTimeSerializer() final DateTime? deletedAt,
          @TimestampDateTimeSerializer() final DateTime? lastSignInAt}) =
      _$_ProfileModel;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$_ProfileModel.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  String get displayName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  DateTime? get birthday;
  @override
  String get photoUrl;
  @override
  Address? get address;
  @override
  String get uid;
  @override
  bool get disabled;
  @override
  List<Role> get roles;
  @override
  bool get emailVerified;
  @override
  Map<String, dynamic> get metadata;
  @override
  Map<String, dynamic> get customClaims;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  @TimestampDateTimeSerializer()
  DateTime? get updatedAt;
  @override
  @TimestampDateTimeSerializer()
  DateTime? get deletedAt;
  @override
  @TimestampDateTimeSerializer()
  DateTime? get lastSignInAt;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileModelCopyWith<_$_ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewOrderStatusState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderStatusEntity> orders) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderStatusEntity> orders)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderStatusEntity> orders)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_newOrderInitial value) initial,
    required TResult Function(_newOrderLoading value) loading,
    required TResult Function(_newOrderSuccess value) success,
    required TResult Function(_newOrderError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_newOrderInitial value)? initial,
    TResult? Function(_newOrderLoading value)? loading,
    TResult? Function(_newOrderSuccess value)? success,
    TResult? Function(_newOrderError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_newOrderInitial value)? initial,
    TResult Function(_newOrderLoading value)? loading,
    TResult Function(_newOrderSuccess value)? success,
    TResult Function(_newOrderError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewOrderStatusStateCopyWith<$Res> {
  factory $NewOrderStatusStateCopyWith(
          NewOrderStatusState value, $Res Function(NewOrderStatusState) then) =
      _$NewOrderStatusStateCopyWithImpl<$Res, NewOrderStatusState>;
}

/// @nodoc
class _$NewOrderStatusStateCopyWithImpl<$Res, $Val extends NewOrderStatusState>
    implements $NewOrderStatusStateCopyWith<$Res> {
  _$NewOrderStatusStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$newOrderInitialImplCopyWith<$Res> {
  factory _$$newOrderInitialImplCopyWith(_$newOrderInitialImpl value,
          $Res Function(_$newOrderInitialImpl) then) =
      __$$newOrderInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$newOrderInitialImplCopyWithImpl<$Res>
    extends _$NewOrderStatusStateCopyWithImpl<$Res, _$newOrderInitialImpl>
    implements _$$newOrderInitialImplCopyWith<$Res> {
  __$$newOrderInitialImplCopyWithImpl(
      _$newOrderInitialImpl _value, $Res Function(_$newOrderInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$newOrderInitialImpl implements _newOrderInitial {
  const _$newOrderInitialImpl();

  @override
  String toString() {
    return 'NewOrderStatusState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$newOrderInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderStatusEntity> orders) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderStatusEntity> orders)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderStatusEntity> orders)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_newOrderInitial value) initial,
    required TResult Function(_newOrderLoading value) loading,
    required TResult Function(_newOrderSuccess value) success,
    required TResult Function(_newOrderError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_newOrderInitial value)? initial,
    TResult? Function(_newOrderLoading value)? loading,
    TResult? Function(_newOrderSuccess value)? success,
    TResult? Function(_newOrderError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_newOrderInitial value)? initial,
    TResult Function(_newOrderLoading value)? loading,
    TResult Function(_newOrderSuccess value)? success,
    TResult Function(_newOrderError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _newOrderInitial implements NewOrderStatusState {
  const factory _newOrderInitial() = _$newOrderInitialImpl;
}

/// @nodoc
abstract class _$$newOrderLoadingImplCopyWith<$Res> {
  factory _$$newOrderLoadingImplCopyWith(_$newOrderLoadingImpl value,
          $Res Function(_$newOrderLoadingImpl) then) =
      __$$newOrderLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$newOrderLoadingImplCopyWithImpl<$Res>
    extends _$NewOrderStatusStateCopyWithImpl<$Res, _$newOrderLoadingImpl>
    implements _$$newOrderLoadingImplCopyWith<$Res> {
  __$$newOrderLoadingImplCopyWithImpl(
      _$newOrderLoadingImpl _value, $Res Function(_$newOrderLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$newOrderLoadingImpl implements _newOrderLoading {
  const _$newOrderLoadingImpl();

  @override
  String toString() {
    return 'NewOrderStatusState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$newOrderLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderStatusEntity> orders) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderStatusEntity> orders)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderStatusEntity> orders)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_newOrderInitial value) initial,
    required TResult Function(_newOrderLoading value) loading,
    required TResult Function(_newOrderSuccess value) success,
    required TResult Function(_newOrderError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_newOrderInitial value)? initial,
    TResult? Function(_newOrderLoading value)? loading,
    TResult? Function(_newOrderSuccess value)? success,
    TResult? Function(_newOrderError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_newOrderInitial value)? initial,
    TResult Function(_newOrderLoading value)? loading,
    TResult Function(_newOrderSuccess value)? success,
    TResult Function(_newOrderError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _newOrderLoading implements NewOrderStatusState {
  const factory _newOrderLoading() = _$newOrderLoadingImpl;
}

/// @nodoc
abstract class _$$newOrderSuccessImplCopyWith<$Res> {
  factory _$$newOrderSuccessImplCopyWith(_$newOrderSuccessImpl value,
          $Res Function(_$newOrderSuccessImpl) then) =
      __$$newOrderSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderStatusEntity> orders});
}

/// @nodoc
class __$$newOrderSuccessImplCopyWithImpl<$Res>
    extends _$NewOrderStatusStateCopyWithImpl<$Res, _$newOrderSuccessImpl>
    implements _$$newOrderSuccessImplCopyWith<$Res> {
  __$$newOrderSuccessImplCopyWithImpl(
      _$newOrderSuccessImpl _value, $Res Function(_$newOrderSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$newOrderSuccessImpl(
      null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderStatusEntity>,
    ));
  }
}

/// @nodoc

class _$newOrderSuccessImpl implements _newOrderSuccess {
  const _$newOrderSuccessImpl(final List<OrderStatusEntity> orders)
      : _orders = orders;

  final List<OrderStatusEntity> _orders;
  @override
  List<OrderStatusEntity> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'NewOrderStatusState.success(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$newOrderSuccessImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$newOrderSuccessImplCopyWith<_$newOrderSuccessImpl> get copyWith =>
      __$$newOrderSuccessImplCopyWithImpl<_$newOrderSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderStatusEntity> orders) success,
    required TResult Function(String message) error,
  }) {
    return success(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderStatusEntity> orders)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderStatusEntity> orders)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_newOrderInitial value) initial,
    required TResult Function(_newOrderLoading value) loading,
    required TResult Function(_newOrderSuccess value) success,
    required TResult Function(_newOrderError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_newOrderInitial value)? initial,
    TResult? Function(_newOrderLoading value)? loading,
    TResult? Function(_newOrderSuccess value)? success,
    TResult? Function(_newOrderError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_newOrderInitial value)? initial,
    TResult Function(_newOrderLoading value)? loading,
    TResult Function(_newOrderSuccess value)? success,
    TResult Function(_newOrderError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _newOrderSuccess implements NewOrderStatusState {
  const factory _newOrderSuccess(final List<OrderStatusEntity> orders) =
      _$newOrderSuccessImpl;

  List<OrderStatusEntity> get orders;

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$newOrderSuccessImplCopyWith<_$newOrderSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$newOrderErrorImplCopyWith<$Res> {
  factory _$$newOrderErrorImplCopyWith(
          _$newOrderErrorImpl value, $Res Function(_$newOrderErrorImpl) then) =
      __$$newOrderErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$newOrderErrorImplCopyWithImpl<$Res>
    extends _$NewOrderStatusStateCopyWithImpl<$Res, _$newOrderErrorImpl>
    implements _$$newOrderErrorImplCopyWith<$Res> {
  __$$newOrderErrorImplCopyWithImpl(
      _$newOrderErrorImpl _value, $Res Function(_$newOrderErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$newOrderErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$newOrderErrorImpl implements _newOrderError {
  const _$newOrderErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NewOrderStatusState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$newOrderErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$newOrderErrorImplCopyWith<_$newOrderErrorImpl> get copyWith =>
      __$$newOrderErrorImplCopyWithImpl<_$newOrderErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderStatusEntity> orders) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderStatusEntity> orders)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderStatusEntity> orders)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_newOrderInitial value) initial,
    required TResult Function(_newOrderLoading value) loading,
    required TResult Function(_newOrderSuccess value) success,
    required TResult Function(_newOrderError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_newOrderInitial value)? initial,
    TResult? Function(_newOrderLoading value)? loading,
    TResult? Function(_newOrderSuccess value)? success,
    TResult? Function(_newOrderError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_newOrderInitial value)? initial,
    TResult Function(_newOrderLoading value)? loading,
    TResult Function(_newOrderSuccess value)? success,
    TResult Function(_newOrderError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _newOrderError implements NewOrderStatusState {
  const factory _newOrderError(final String message) = _$newOrderErrorImpl;

  String get message;

  /// Create a copy of NewOrderStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$newOrderErrorImplCopyWith<_$newOrderErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

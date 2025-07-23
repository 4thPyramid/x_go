// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewOrderStatusState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewOrderStatusState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderStatusState()';
}


}

/// @nodoc
class $NewOrderStatusStateCopyWith<$Res>  {
$NewOrderStatusStateCopyWith(NewOrderStatusState _, $Res Function(NewOrderStatusState) __);
}


/// Adds pattern-matching-related methods to [NewOrderStatusState].
extension NewOrderStatusStatePatterns on NewOrderStatusState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _newOrderInitial value)?  initial,TResult Function( _newOrderLoading value)?  loading,TResult Function( _newOrderSuccess value)?  success,TResult Function( _newOrderError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _newOrderInitial() when initial != null:
return initial(_that);case _newOrderLoading() when loading != null:
return loading(_that);case _newOrderSuccess() when success != null:
return success(_that);case _newOrderError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _newOrderInitial value)  initial,required TResult Function( _newOrderLoading value)  loading,required TResult Function( _newOrderSuccess value)  success,required TResult Function( _newOrderError value)  error,}){
final _that = this;
switch (_that) {
case _newOrderInitial():
return initial(_that);case _newOrderLoading():
return loading(_that);case _newOrderSuccess():
return success(_that);case _newOrderError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _newOrderInitial value)?  initial,TResult? Function( _newOrderLoading value)?  loading,TResult? Function( _newOrderSuccess value)?  success,TResult? Function( _newOrderError value)?  error,}){
final _that = this;
switch (_that) {
case _newOrderInitial() when initial != null:
return initial(_that);case _newOrderLoading() when loading != null:
return loading(_that);case _newOrderSuccess() when success != null:
return success(_that);case _newOrderError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrderStatusEntity> orders)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _newOrderInitial() when initial != null:
return initial();case _newOrderLoading() when loading != null:
return loading();case _newOrderSuccess() when success != null:
return success(_that.orders);case _newOrderError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrderStatusEntity> orders)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _newOrderInitial():
return initial();case _newOrderLoading():
return loading();case _newOrderSuccess():
return success(_that.orders);case _newOrderError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrderStatusEntity> orders)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _newOrderInitial() when initial != null:
return initial();case _newOrderLoading() when loading != null:
return loading();case _newOrderSuccess() when success != null:
return success(_that.orders);case _newOrderError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _newOrderInitial implements NewOrderStatusState {
  const _newOrderInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _newOrderInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderStatusState.initial()';
}


}




/// @nodoc


class _newOrderLoading implements NewOrderStatusState {
  const _newOrderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _newOrderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderStatusState.loading()';
}


}




/// @nodoc


class _newOrderSuccess implements NewOrderStatusState {
  const _newOrderSuccess(final  List<OrderStatusEntity> orders): _orders = orders;
  

 final  List<OrderStatusEntity> _orders;
 List<OrderStatusEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of NewOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$newOrderSuccessCopyWith<_newOrderSuccess> get copyWith => __$newOrderSuccessCopyWithImpl<_newOrderSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _newOrderSuccess&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'NewOrderStatusState.success(orders: $orders)';
}


}

/// @nodoc
abstract mixin class _$newOrderSuccessCopyWith<$Res> implements $NewOrderStatusStateCopyWith<$Res> {
  factory _$newOrderSuccessCopyWith(_newOrderSuccess value, $Res Function(_newOrderSuccess) _then) = __$newOrderSuccessCopyWithImpl;
@useResult
$Res call({
 List<OrderStatusEntity> orders
});




}
/// @nodoc
class __$newOrderSuccessCopyWithImpl<$Res>
    implements _$newOrderSuccessCopyWith<$Res> {
  __$newOrderSuccessCopyWithImpl(this._self, this._then);

  final _newOrderSuccess _self;
  final $Res Function(_newOrderSuccess) _then;

/// Create a copy of NewOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(_newOrderSuccess(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderStatusEntity>,
  ));
}


}

/// @nodoc


class _newOrderError implements NewOrderStatusState {
  const _newOrderError(this.message);
  

 final  String message;

/// Create a copy of NewOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$newOrderErrorCopyWith<_newOrderError> get copyWith => __$newOrderErrorCopyWithImpl<_newOrderError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _newOrderError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NewOrderStatusState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$newOrderErrorCopyWith<$Res> implements $NewOrderStatusStateCopyWith<$Res> {
  factory _$newOrderErrorCopyWith(_newOrderError value, $Res Function(_newOrderError) _then) = __$newOrderErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$newOrderErrorCopyWithImpl<$Res>
    implements _$newOrderErrorCopyWith<$Res> {
  __$newOrderErrorCopyWithImpl(this._self, this._then);

  final _newOrderError _self;
  final $Res Function(_newOrderError) _then;

/// Create a copy of NewOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_newOrderError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accepted_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AcceptedStatusState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcceptedStatusState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcceptedStatusState()';
}


}

/// @nodoc
class $AcceptedStatusStateCopyWith<$Res>  {
$AcceptedStatusStateCopyWith(AcceptedStatusState _, $Res Function(AcceptedStatusState) __);
}


/// Adds pattern-matching-related methods to [AcceptedStatusState].
extension AcceptedStatusStatePatterns on AcceptedStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _acceptedOrderInitial value)?  acceptedOrderInitial,TResult Function( _acceptedOrderLoading value)?  acceptedOrderLoading,TResult Function( _acceptedOrderSuccess value)?  acceptedOrderSuccess,TResult Function( _acceptedError value)?  acceptedError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _acceptedOrderInitial() when acceptedOrderInitial != null:
return acceptedOrderInitial(_that);case _acceptedOrderLoading() when acceptedOrderLoading != null:
return acceptedOrderLoading(_that);case _acceptedOrderSuccess() when acceptedOrderSuccess != null:
return acceptedOrderSuccess(_that);case _acceptedError() when acceptedError != null:
return acceptedError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _acceptedOrderInitial value)  acceptedOrderInitial,required TResult Function( _acceptedOrderLoading value)  acceptedOrderLoading,required TResult Function( _acceptedOrderSuccess value)  acceptedOrderSuccess,required TResult Function( _acceptedError value)  acceptedError,}){
final _that = this;
switch (_that) {
case _acceptedOrderInitial():
return acceptedOrderInitial(_that);case _acceptedOrderLoading():
return acceptedOrderLoading(_that);case _acceptedOrderSuccess():
return acceptedOrderSuccess(_that);case _acceptedError():
return acceptedError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _acceptedOrderInitial value)?  acceptedOrderInitial,TResult? Function( _acceptedOrderLoading value)?  acceptedOrderLoading,TResult? Function( _acceptedOrderSuccess value)?  acceptedOrderSuccess,TResult? Function( _acceptedError value)?  acceptedError,}){
final _that = this;
switch (_that) {
case _acceptedOrderInitial() when acceptedOrderInitial != null:
return acceptedOrderInitial(_that);case _acceptedOrderLoading() when acceptedOrderLoading != null:
return acceptedOrderLoading(_that);case _acceptedOrderSuccess() when acceptedOrderSuccess != null:
return acceptedOrderSuccess(_that);case _acceptedError() when acceptedError != null:
return acceptedError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  acceptedOrderInitial,TResult Function()?  acceptedOrderLoading,TResult Function( List<OrderStatusEntity> orders)?  acceptedOrderSuccess,TResult Function( String message)?  acceptedError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _acceptedOrderInitial() when acceptedOrderInitial != null:
return acceptedOrderInitial();case _acceptedOrderLoading() when acceptedOrderLoading != null:
return acceptedOrderLoading();case _acceptedOrderSuccess() when acceptedOrderSuccess != null:
return acceptedOrderSuccess(_that.orders);case _acceptedError() when acceptedError != null:
return acceptedError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  acceptedOrderInitial,required TResult Function()  acceptedOrderLoading,required TResult Function( List<OrderStatusEntity> orders)  acceptedOrderSuccess,required TResult Function( String message)  acceptedError,}) {final _that = this;
switch (_that) {
case _acceptedOrderInitial():
return acceptedOrderInitial();case _acceptedOrderLoading():
return acceptedOrderLoading();case _acceptedOrderSuccess():
return acceptedOrderSuccess(_that.orders);case _acceptedError():
return acceptedError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  acceptedOrderInitial,TResult? Function()?  acceptedOrderLoading,TResult? Function( List<OrderStatusEntity> orders)?  acceptedOrderSuccess,TResult? Function( String message)?  acceptedError,}) {final _that = this;
switch (_that) {
case _acceptedOrderInitial() when acceptedOrderInitial != null:
return acceptedOrderInitial();case _acceptedOrderLoading() when acceptedOrderLoading != null:
return acceptedOrderLoading();case _acceptedOrderSuccess() when acceptedOrderSuccess != null:
return acceptedOrderSuccess(_that.orders);case _acceptedError() when acceptedError != null:
return acceptedError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _acceptedOrderInitial implements AcceptedStatusState {
  const _acceptedOrderInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _acceptedOrderInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcceptedStatusState.acceptedOrderInitial()';
}


}




/// @nodoc


class _acceptedOrderLoading implements AcceptedStatusState {
  const _acceptedOrderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _acceptedOrderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcceptedStatusState.acceptedOrderLoading()';
}


}




/// @nodoc


class _acceptedOrderSuccess implements AcceptedStatusState {
  const _acceptedOrderSuccess(final  List<OrderStatusEntity> orders): _orders = orders;
  

 final  List<OrderStatusEntity> _orders;
 List<OrderStatusEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of AcceptedStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$acceptedOrderSuccessCopyWith<_acceptedOrderSuccess> get copyWith => __$acceptedOrderSuccessCopyWithImpl<_acceptedOrderSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _acceptedOrderSuccess&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'AcceptedStatusState.acceptedOrderSuccess(orders: $orders)';
}


}

/// @nodoc
abstract mixin class _$acceptedOrderSuccessCopyWith<$Res> implements $AcceptedStatusStateCopyWith<$Res> {
  factory _$acceptedOrderSuccessCopyWith(_acceptedOrderSuccess value, $Res Function(_acceptedOrderSuccess) _then) = __$acceptedOrderSuccessCopyWithImpl;
@useResult
$Res call({
 List<OrderStatusEntity> orders
});




}
/// @nodoc
class __$acceptedOrderSuccessCopyWithImpl<$Res>
    implements _$acceptedOrderSuccessCopyWith<$Res> {
  __$acceptedOrderSuccessCopyWithImpl(this._self, this._then);

  final _acceptedOrderSuccess _self;
  final $Res Function(_acceptedOrderSuccess) _then;

/// Create a copy of AcceptedStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(_acceptedOrderSuccess(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderStatusEntity>,
  ));
}


}

/// @nodoc


class _acceptedError implements AcceptedStatusState {
  const _acceptedError(this.message);
  

 final  String message;

/// Create a copy of AcceptedStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$acceptedErrorCopyWith<_acceptedError> get copyWith => __$acceptedErrorCopyWithImpl<_acceptedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _acceptedError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AcceptedStatusState.acceptedError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$acceptedErrorCopyWith<$Res> implements $AcceptedStatusStateCopyWith<$Res> {
  factory _$acceptedErrorCopyWith(_acceptedError value, $Res Function(_acceptedError) _then) = __$acceptedErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$acceptedErrorCopyWithImpl<$Res>
    implements _$acceptedErrorCopyWith<$Res> {
  __$acceptedErrorCopyWithImpl(this._self, this._then);

  final _acceptedError _self;
  final $Res Function(_acceptedError) _then;

/// Create a copy of AcceptedStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_acceptedError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

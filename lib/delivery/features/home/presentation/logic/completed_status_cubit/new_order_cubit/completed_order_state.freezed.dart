// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'completed_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompletedOrderStatusState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompletedOrderStatusState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompletedOrderStatusState()';
}


}

/// @nodoc
class $CompletedOrderStatusStateCopyWith<$Res>  {
$CompletedOrderStatusStateCopyWith(CompletedOrderStatusState _, $Res Function(CompletedOrderStatusState) __);
}


/// Adds pattern-matching-related methods to [CompletedOrderStatusState].
extension CompletedOrderStatusStatePatterns on CompletedOrderStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _completedOrderInitial value)?  initial,TResult Function( _completedOrderLoading value)?  loading,TResult Function( _completedOrderSuccess value)?  success,TResult Function( _completedOrderError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _completedOrderInitial() when initial != null:
return initial(_that);case _completedOrderLoading() when loading != null:
return loading(_that);case _completedOrderSuccess() when success != null:
return success(_that);case _completedOrderError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _completedOrderInitial value)  initial,required TResult Function( _completedOrderLoading value)  loading,required TResult Function( _completedOrderSuccess value)  success,required TResult Function( _completedOrderError value)  error,}){
final _that = this;
switch (_that) {
case _completedOrderInitial():
return initial(_that);case _completedOrderLoading():
return loading(_that);case _completedOrderSuccess():
return success(_that);case _completedOrderError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _completedOrderInitial value)?  initial,TResult? Function( _completedOrderLoading value)?  loading,TResult? Function( _completedOrderSuccess value)?  success,TResult? Function( _completedOrderError value)?  error,}){
final _that = this;
switch (_that) {
case _completedOrderInitial() when initial != null:
return initial(_that);case _completedOrderLoading() when loading != null:
return loading(_that);case _completedOrderSuccess() when success != null:
return success(_that);case _completedOrderError() when error != null:
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
case _completedOrderInitial() when initial != null:
return initial();case _completedOrderLoading() when loading != null:
return loading();case _completedOrderSuccess() when success != null:
return success(_that.orders);case _completedOrderError() when error != null:
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
case _completedOrderInitial():
return initial();case _completedOrderLoading():
return loading();case _completedOrderSuccess():
return success(_that.orders);case _completedOrderError():
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
case _completedOrderInitial() when initial != null:
return initial();case _completedOrderLoading() when loading != null:
return loading();case _completedOrderSuccess() when success != null:
return success(_that.orders);case _completedOrderError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _completedOrderInitial implements CompletedOrderStatusState {
  const _completedOrderInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _completedOrderInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompletedOrderStatusState.initial()';
}


}




/// @nodoc


class _completedOrderLoading implements CompletedOrderStatusState {
  const _completedOrderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _completedOrderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompletedOrderStatusState.loading()';
}


}




/// @nodoc


class _completedOrderSuccess implements CompletedOrderStatusState {
  const _completedOrderSuccess(final  List<OrderStatusEntity> orders): _orders = orders;
  

 final  List<OrderStatusEntity> _orders;
 List<OrderStatusEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of CompletedOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$completedOrderSuccessCopyWith<_completedOrderSuccess> get copyWith => __$completedOrderSuccessCopyWithImpl<_completedOrderSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _completedOrderSuccess&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'CompletedOrderStatusState.success(orders: $orders)';
}


}

/// @nodoc
abstract mixin class _$completedOrderSuccessCopyWith<$Res> implements $CompletedOrderStatusStateCopyWith<$Res> {
  factory _$completedOrderSuccessCopyWith(_completedOrderSuccess value, $Res Function(_completedOrderSuccess) _then) = __$completedOrderSuccessCopyWithImpl;
@useResult
$Res call({
 List<OrderStatusEntity> orders
});




}
/// @nodoc
class __$completedOrderSuccessCopyWithImpl<$Res>
    implements _$completedOrderSuccessCopyWith<$Res> {
  __$completedOrderSuccessCopyWithImpl(this._self, this._then);

  final _completedOrderSuccess _self;
  final $Res Function(_completedOrderSuccess) _then;

/// Create a copy of CompletedOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(_completedOrderSuccess(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderStatusEntity>,
  ));
}


}

/// @nodoc


class _completedOrderError implements CompletedOrderStatusState {
  const _completedOrderError(this.message);
  

 final  String message;

/// Create a copy of CompletedOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$completedOrderErrorCopyWith<_completedOrderError> get copyWith => __$completedOrderErrorCopyWithImpl<_completedOrderError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _completedOrderError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompletedOrderStatusState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$completedOrderErrorCopyWith<$Res> implements $CompletedOrderStatusStateCopyWith<$Res> {
  factory _$completedOrderErrorCopyWith(_completedOrderError value, $Res Function(_completedOrderError) _then) = __$completedOrderErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$completedOrderErrorCopyWithImpl<$Res>
    implements _$completedOrderErrorCopyWith<$Res> {
  __$completedOrderErrorCopyWithImpl(this._self, this._then);

  final _completedOrderError _self;
  final $Res Function(_completedOrderError) _then;

/// Create a copy of CompletedOrderStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_completedOrderError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

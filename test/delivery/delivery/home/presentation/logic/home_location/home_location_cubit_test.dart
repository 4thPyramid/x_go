import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/home_location_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/locatin_services_home.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/location_state.dart';

class MockLocationService extends Mock implements LocationHomeDeliveryService {}

void main() {
  late HomeDeliveryLocationCubit cubit;
  late MockLocationService mockLocationService;

  setUp(() {
    mockLocationService = MockLocationService();
    cubit = HomeDeliveryLocationCubit(mockLocationService);
  });

  tearDown(() {
    cubit.close();
  });

  test('emits [loading, success] when location fetched successfully', () async {
    // arrange
    const expectedAddress = 'مصر، الدقهلية، المنصورة، شارع الجمهورية';

    when(
      () => mockLocationService.getReadableLocation(),
    ).thenAnswer((_) async => expectedAddress);

    // assert later
    expectLater(
      cubit.stream,
      emitsInOrder([
        const LocationState.loading(),
        const LocationState.success('مصر، الدقهلية، المنصورة، شارع الجمهورية'),
      ]),
    );

    // act
    await cubit.fetchLocation();
  });

  test('emits [loading, error] when location fetch fails', () async {
    // arrange
    when(
      () => mockLocationService.getReadableLocation(),
    ).thenThrow(Exception('فشل في الحصول على الموقع'));

    // assert later
    expectLater(
      cubit.stream,
      emitsInOrder([
        const LocationState.loading(),
        const LocationState.error('تعذر جلب العنوان'),
      ]),
    );

    // act
    await cubit.fetchLocation();
  });
}

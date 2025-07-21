import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/utils/app_styles.dart';
import 'package:x_go/client/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'package:x_go/client/features/my_bookings/data/models/booking_model.dart';

class CarDetailsComponent extends StatelessWidget {
  final CarEntity? car;
  final BookingModel? bookinModel;
  final MyBookingModel? myBookingModel;

  const CarDetailsComponent({
    super.key,
    this.car,
    this.bookinModel,
    this.myBookingModel,
  });

  @override
  Widget build(BuildContext context) {
    // إعطاء أولوية لـ MyBookingModel عند توفره
    final image = myBookingModel?.carImage ?? car?.image ?? '';
    final brand = myBookingModel?.brandName ?? car?.brandName ?? '';
    final model = myBookingModel?.modelName ?? car?.modelName ?? '';
    final startDate =
        myBookingModel?.startDate ??
        bookinModel?.data?.booking?.startDate ??
        '';
    final endDate =
        myBookingModel?.endDate ?? bookinModel?.data?.booking?.endDate ?? '';

    // تحسين معالجة additional driver
    final additionalDriver =
        myBookingModel?.additionalDriver ??
        bookinModel?.data?.booking?.additionalDriver ??
        0;

    // تحسين معالجة location
    final location = myBookingModel != null
        ? (myBookingModel!.additionalDriver == 1
              ? 'With additional driver'
              : 'Without additional driver')
        : (bookinModel?.data?.booking?.location?.location ??
              'Location not specified');

    final finalPrice =
        myBookingModel?.finalPrice ??
        bookinModel?.data?.booking?.finalPrice?.toString() ??
        '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              image.startsWith("http")
                  ? image
                  : 'https://yellowgreen-ferret-878816.hostingersite.com/$image',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.car_rental, size: 50, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            brand,
            style: AppStyles.ts13BlackW500.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(model, style: AppStyles.ts13BlackW500),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Trip Dates',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('$startDate -- $endDate'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          'Driver Details',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(location),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$$finalPrice',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

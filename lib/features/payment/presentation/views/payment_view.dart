import 'package:flutter/material.dart';
import 'package:x_go/core/common/widgets/logo.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/features/payment/presentation/component/car_details_component.dart';
import 'package:x_go/features/payment/presentation/component/payment_component.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class PaymentView extends StatelessWidget {
  final CarEntity? car;
  final BookingModel? bookingModel;
  final MyBookingModel? myBookingModel;

  const PaymentView({
    super.key,
    this.car,
    this.bookingModel,
    this.myBookingModel,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد مصدر البيانات تلقائياً
    final isFromMyBookings = myBookingModel != null;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: LogoWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CarDetailsComponent يتعامل مع جميع الحالات تلقائياً
                CarDetailsComponent(
                  car: car,
                  bookinModel: bookingModel,
                  myBookingModel: myBookingModel,
                ),
                const SizedBox(height: 32),
                PaymentComponent(
                  finalPrice: _getFinalPrice(),
                  modelId: _getModelId(),
                  bookingId: _getBookingId(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods لاستخراج البيانات من المصدر الصحيح
  String _getFinalPrice() {
    if (myBookingModel != null) {
      return myBookingModel!.finalPrice;
    } else if (bookingModel != null) {
      return bookingModel!.data!.booking!.finalPrice.toString();
    }
    return '0';
  }

  String _getModelId() {
    if (myBookingModel != null) {
      return myBookingModel!.carModelId.toString();
    } else if (bookingModel != null) {
      return bookingModel!.data!.booking!.carmodelId!.toString();
    }
    return '0';
  }

  String _getBookingId() {
    if (myBookingModel != null) {
      return myBookingModel!.id.toString();
    } else if (bookingModel != null) {
      return bookingModel!.data!.booking!.id!.toString();
    }
    return '0';
  }
}

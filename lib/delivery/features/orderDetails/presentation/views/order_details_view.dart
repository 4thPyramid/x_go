import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/delivery/features/orderDetails/domain/entities/booking_entity.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/logic/booking_cubit.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/widgets/location.dart';

class OrderDetailsView extends StatefulWidget {
  final int bookingId;

  const OrderDetailsView({super.key, required this.bookingId});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  void initState() {
    super.initState();
    // استدعاء البيانات عند تحميل الصفحة
    context.read<BookingDetailsCubit>().fetchBookingDetails(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<BookingDetailsCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BookingDetailsCubit>().fetchBookingDetails(
                        widget.bookingId,
                      );
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (state is BookingLoaded) {
            return _buildBookingDetails(state.booking);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBookingDetails(BookingEntity booking) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // عرض الخريطة مع الموقع الفعلي
          LocationWidget(location: booking.location),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // قسم العنوان
                _buildAddressSection(booking),
                const SizedBox(height: 20),

                // قسم الطلب
                _buildOrderSection(booking),
                const SizedBox(height: 20),

                // قسم تفاصيل الحجز
                _buildBookingDetailsSection(booking),
                const SizedBox(height: 20),

                // قسم السعر
                _buildPriceSection(booking),
                const SizedBox(height: 20),

                // قسم معلومات المستخدم
                _buildUserSection(booking),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'قبول',
                        onPressed: () {
                          context.push(RouterNames.deliveryLocation);
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomButton(text: 'رفض', onPressed: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(BookingEntity booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'العنوان',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Card(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 10),
                    Text(
                      'موقع الاستلام',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  booking.location?.address ?? 'لا يوجد عنوان محدد',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSection(BookingEntity booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الطلب',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // صورة السيارة
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: booking.car.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            booking.car.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/map.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        )
                      : Image.asset('assets/images/map.png', fit: BoxFit.cover),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.carModel.relationship.brand.brandName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        booking.carModel.relationship.modelName.modelName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'لوحة: ${booking.car.plateNumber}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          booking.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingDetailsSection(BookingEntity booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'تفاصيل الحجز',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildDetailRow('تاريخ البداية', booking.startDate),
                const Divider(),
                _buildDetailRow('تاريخ النهاية', booking.endDate),
                const Divider(),
                _buildDetailRow('طريقة الدفع', booking.paymentMethod),
                if (booking.paymentStatus != null) ...[
                  const Divider(),
                  _buildDetailRow('حالة الدفع', booking.paymentStatus!),
                ],
                if (booking.transactionId != null) ...[
                  const Divider(),
                  _buildDetailRow('رقم المعاملة', booking.transactionId!),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection(BookingEntity booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'السعر',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  'السعر الإجمالي',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Text(
                  '${booking.finalPrice} ج.م',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserSection(BookingEntity booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'معلومات العميل',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildDetailRow(
                  'الاسم',
                  '${booking.user.name} ${booking.user.lastName}',
                ),
                const Divider(),
                _buildDetailRow('البريد الإلكتروني', booking.user.email),
                const Divider(),
                _buildDetailRow('رقم الهاتف', booking.user.phone),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'مؤكد':
        return Colors.green;
      case 'pending':
      case 'في الانتظار':
        return Colors.orange;
      case 'cancelled':
      case 'ملغي':
        return Colors.red;
      case 'completed':
      case 'مكتمل':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

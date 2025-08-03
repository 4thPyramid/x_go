import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/delivery/features/orderDetails/domain/entities/booking_entity.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/logic/booking_cubit.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/components/location.dart';

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
    context.read<BookingDetailsCubit>().fetchBookingDetails(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: BlocBuilder<BookingDetailsCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookingError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red.shade400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'حدث خطأ: ${state.message}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<BookingDetailsCubit>().fetchBookingDetails(
                          widget.bookingId,
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LocationWidget(location: booking.location),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildAddressSection(booking),
                      SizedBox(height: 20.h),
                      _buildOrderSection(booking),
                      SizedBox(height: 20.h),
                      _buildBookingDetailsSection(booking),
                      SizedBox(height: 20.h),
                      _buildPriceSection(booking),
                      SizedBox(height: 20.h),
                      _buildUserSection(booking),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Show action buttons only when status is 'assigned'
        if (booking.status.toLowerCase() == 'driver_assigned')
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'قبول',
                      onPressed: () {
                        // context.read<BookingDetailsCubit>().changebookingStatus(
                        //   booking.id,
                        //   'driver_accepted',
                        // );
                        // التنقل إن أردت بعد التغيير
                        context.push(
                          RouterNames.deliveryLocation,
                          extra: booking,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'رفض',
                      onPressed: () {
                        context.read<BookingDetailsCubit>().changebookingStatus(
                          booking.id,
                          'canceled',
                        );
                        // يمكنك عرض Snackbar أو الرجوع مثلاً
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم رفض الطلب')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddressSection(BookingEntity booking) {
    return _buildSection(
      title: 'العنوان',
      icon: Icons.location_on,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.blue.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'موقع الاستلام',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              booking.location?.address ?? 'لا يوجد عنوان محدد',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSection(BookingEntity booking) {
    return _buildSection(
      title: 'الطلب',
      icon: Icons.directions_car,
      child: Row(
        children: [
          Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: booking.car.image != null
                  ? Image.network(
                      booking.car.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/map.png',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset('assets/images/map.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.carModel.relationship.brand.brandName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.carModel.relationship.modelName.modelName,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking.car.plateNumber,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    booking.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsSection(BookingEntity booking) {
    return _buildSection(
      title: 'تفاصيل الحجز',
      icon: Icons.event_note,
      child: Column(
        children: [
          _buildDetailRow('تاريخ البداية', booking.startDate),
          const SizedBox(height: 12),
          _buildDetailRow('تاريخ النهاية', booking.endDate),
          const SizedBox(height: 12),
          _buildDetailRow('طريقة الدفع', booking.paymentMethod ?? 'غير محددة'),
          if (booking.paymentStatus != null) ...[
            const SizedBox(height: 12),
            _buildDetailRow('حالة الدفع', booking.paymentStatus!),
          ],
          if (booking.transactionId != null) ...[
            const SizedBox(height: 12),
            _buildDetailRow('رقم المعاملة', booking.transactionId!),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceSection(BookingEntity booking) {
    return _buildSection(
      title: 'السعر',
      icon: Icons.payments,
      child: Row(
        children: [
          const Text(
            'السعر الإجمالي',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Text(
              '${booking.finalPrice} ج.م',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.green.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserSection(BookingEntity booking) {
    return _buildSection(
      title: 'معلومات العميل',
      icon: Icons.person,
      child: Column(
        children: [
          _buildDetailRow(
            'الاسم',
            '${booking.user.name} ${booking.user.lastName}',
          ),
          const SizedBox(height: 12),
          _buildDetailRow('البريد الإلكتروني', booking.user.email),
          const SizedBox(height: 12),
          _buildDetailRow('رقم الهاتف', booking.user.phone),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, size: 20, color: Colors.blue.shade600),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade100,
          ),
          Padding(padding: const EdgeInsets.all(16.0), child: child),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
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
        return Colors.green.shade600;
      case 'pending':
      case 'في الانتظار':
        return Colors.orange.shade600;
      case 'cancelled':
      case 'ملغي':
        return Colors.red.shade600;
      case 'completed':
      case 'مكتمل':
        return Colors.blue.shade600;
      case 'assigned':
        return Colors.deepPurple.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}

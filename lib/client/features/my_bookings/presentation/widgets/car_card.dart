import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
<<<<<<< HEAD:lib/client/features/my_bookings/presentation/widgets/car_card.dart
import 'package:x_go/client/features/my_bookings/data/models/booking_model.dart';
=======
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/presentation/logic/cubit/payment_cubit.dart';
import 'package:x_go/features/payment/presentation/widgets/confirmation_dailog.dart';
>>>>>>> 1f289b7ffc4b18ed4f1a0f182ce278bd53634cb8:lib/features/my_bookings/presentation/widgets/car_card.dart

class BookingCard extends StatefulWidget {
  final String imageUrl;
  final String brand;
  final String model;
  final String modelYear;
  final String fromDate;
  final String toDate;
  final String price;
  final String status;
  final MyBookingModel? myBookingModel;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.modelYear,
    required this.fromDate,
    required this.toDate,
    required this.price,
    required this.status,
    this.myBookingModel,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool _isAwaitingPaymentTapped = false;

  Color getStatusColor(String status) {
    switch (status) {
      case 'initiated':
        return Colors.blue;
      case 'awaiting_payment':
        return Colors.amber;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  void handleAwaitingPayment(BuildContext context) {
    if (widget.myBookingModel == null) return;

    final paymentCubit = context.read<PaymentCubit>();

    paymentCubit.pay(
      PaymentMethod.visa,
      context,
      widget.myBookingModel!.finalPrice,
      widget.myBookingModel!.carModelId.toString(),
      widget.myBookingModel!.id.toString(),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConfirmationDialog(),
    );
  }

  void navigateBasedOnStatus(BuildContext context) {
    switch (widget.status) {
      case 'initiated':
        context.push(
          RouterNames.payment,
          extra: {'myBookingModel': widget.myBookingModel},
        );
        break;

      case 'awaiting_payment':
        if (!_isAwaitingPaymentTapped) {
          setState(() {
            _isAwaitingPaymentTapped = true;
          });
          handleAwaitingPayment(context);
        }
        break;

      default:
        context.push(
          RouterNames.myBooking,
          extra: {'myBookingModel': widget.myBookingModel},
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              'https://xgo.ibrahimbashaa.com/${widget.imageUrl}',
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${widget.brand} ${widget.model} (${widget.modelYear})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text('From: ${widget.fromDate}', style: const TextStyle(color: Colors.grey)),
          Text('To:   ${widget.toDate}', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
<<<<<<< HEAD:lib/client/features/my_bookings/presentation/widgets/car_card.dart
              InkWell(
                onTap: () {
                  // تمرير MyBookingModel فقط عند القدوم من MyBookings
                  context.push(
                    RouterNames.payment,
                    extra: {'myBookingModel': myBookingModel},
                  );
                },
                child: Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: getStatusColor(status),
                ),
              ),
=======
              widget.status == 'awaiting_payment' && _isAwaitingPaymentTapped
                  ? BlocConsumer<PaymentCubit, PaymentState>(
                      listener: (context, state) {
                        if (state is PaymentError) {
                          showToast(message: state.message, state: ToastStates.ERROR);
                          setState(() {
                            _isAwaitingPaymentTapped = false;
                          });
                        } else if (state is PaymentSuccess) {
                          showToast(message: 'Payment processing...', state: ToastStates.WARNING);
                          _showConfirmationDialog(context);
                        }
                      },
                      builder: (context, state) {
                        return state is PaymentLoading
                            ? const CircularProgressIndicator()
                            : Chip(
                                label: Text(
                                  widget.status,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: getStatusColor(widget.status),
                              );
                      },
                    )
                  : InkWell(
                      onTap: () => navigateBasedOnStatus(context),
                      child: Chip(
                        label: Text(
                          widget.status,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: getStatusColor(widget.status),
                      ),
                    ),
>>>>>>> 1f289b7ffc4b18ed4f1a0f182ce278bd53634cb8:lib/features/my_bookings/presentation/widgets/car_card.dart
            ],
          ),
        ],
      ),
    );
  }
}

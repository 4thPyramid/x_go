import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD:lib/client/features/my_bookings/presentation/views/my_booking_view.dart
import 'package:x_go/client/features/my_bookings/presentation/logic/cubit/my_booking_cubit.dart';
import 'package:x_go/client/features/my_bookings/presentation/widgets/car_card.dart';
=======
import 'package:x_go/features/my_bookings/presentation/logic/cubit/my_booking_cubit.dart';
import 'package:x_go/features/my_bookings/presentation/widgets/car_card.dart';
import 'package:x_go/features/payment/presentation/logic/cubit/payment_cubit.dart';
>>>>>>> 1f289b7ffc4b18ed4f1a0f182ce278bd53634cb8:lib/features/my_bookings/presentation/views/my_booking_view.dart

class MyBookingView extends StatelessWidget {
  const MyBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaymentCubit()),
        // MyBookingCubit should already be provided from parent
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF5EF),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          centerTitle: true,
          title: const Text(
            'My Bookings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<MyBookingCubit, MyBookingState>(
          builder: (context, state) {
            if (state is MyBookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyBookingLoaded) {
              final bookings = state.bookings;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return BookingCard(
                    imageUrl: booking.carImage ?? '',
                    model: booking.modelName ?? "",
                    modelYear: booking.carYear ?? "",
                    brand: booking.brandName ?? "",
                    fromDate: booking.startDate,
                    toDate: booking.endDate,
                    price: booking.finalPrice,
                    status: booking.status,
                    myBookingModel: booking, // تمرير MyBookingModel
                  );
                },
              );
            } else if (state is MyBookingError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

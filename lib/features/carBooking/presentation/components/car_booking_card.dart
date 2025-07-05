import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/carBooking/presentation/components/select_location_component.dart';
import 'package:x_go/features/carBooking/presentation/logic/cubit/car_booking_cubit.dart';
import 'package:x_go/features/carBooking/presentation/widgets/boooking_data_time_section.dart';
import 'package:x_go/features/carBooking/presentation/widgets/driver_check_box.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class BookingCardComponent extends StatefulWidget {
  const BookingCardComponent({super.key, required this.car});

  final CarEntity car;

  @override
  State<BookingCardComponent> createState() => _BookingCardComponentState();
}

class _BookingCardComponentState extends State<BookingCardComponent> {
  DateTime? pickupDate;
  TimeOfDay? pickupTime;

  DateTime? returnDate;
  TimeOfDay? returnTime;
  bool isAdditionalDriverChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFAF7F2),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            isAdditionalDriverChecked ? SelectLocationComponent() : Container(),

            Text(
              'Pickup',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
            const SizedBox(height: 15),
            BookingDateTimeSection(
              label1: 'From Date',
              label2: 'Time',
              onDateSelected: (date) => pickupDate = date,
              onTimeSelected: (time) => pickupTime = time,
            ),
            const SizedBox(height: 20),
            Text(
              'Return',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
            const SizedBox(height: 15),
            BookingDateTimeSection(
              label1: 'To Date',
              label2: 'Time',
              onDateSelected: (date) => returnDate = date,
              onTimeSelected: (time) => returnTime = time,
            ),
            SizedBox(height: 35.h),
            AdditionalDriverCheckbox(
              value: isAdditionalDriverChecked,
              onChanged: (value) {
                setState(() {
                  isAdditionalDriverChecked = value!;
                });
              },
            ),
            Center(
              child: BlocConsumer<CarBookingCubit, CarBookingState>(
                listener: (context, state) {
                  print('llllllllllllllllllllllllllllllllll');
                  print(state);
                  state is CarBookingSuccess
                      ? context.push(
                          RouterNames.payment,
                          extra: {
                            'car': widget.car,
                            'pickupDate':
                                '${pickupDate!.year}-${pickupDate!.month}-${pickupDate!.day} ${pickupTime!.hour}:${pickupTime!.minute}',
                            'returnDate':
                                '${returnDate!.year}-${returnDate!.month}-${returnDate!.day} ${returnTime!.hour}:${returnTime!.minute}',
                          },
                        )
                      : state is CarBookingError
                      ? showToast(
                          message: state.message,
                          state: ToastStates.ERROR,
                        )
                      : null;
                },
                builder: (context, state) {
                  return state is CarBookingLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onPressed: () {
                            if (pickupDate == null ||
                                pickupTime == null ||
                                returnDate == null ||
                                returnTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select all date & time',
                                  ),
                                ),
                              );
                            }

                            print(
                              '${pickupDate!.day}-${pickupDate!.month}-${pickupDate!.year} ${pickupTime!.hour}:${pickupTime!.minute}',
                            );
                            print(
                              '${returnDate!.day}-${returnDate!.month}-${returnDate!.year} ${returnTime!.hour}:${returnTime!.minute}',
                            );
                            context.read<CarBookingCubit>().bookCar(
                              widget.car.id,
                              '${pickupDate!.year}-${pickupDate!.month}-${pickupDate!.day} ${pickupTime!.hour}:${pickupTime!.minute}',
                              '${returnDate!.year}-${returnDate!.month}-${returnDate!.day} ${returnTime!.hour}:${returnTime!.minute}',
                              isAdditionalDriverChecked ? '1' : '0',
                              lat: '0',
                              long: '0',
                              location: '0',
                            );
                          },
                          text: 'Confirm',
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

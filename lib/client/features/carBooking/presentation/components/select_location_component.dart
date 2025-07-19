import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/location_button.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/client/features/carBooking/presentation/logic/cubit/car_booking_cubit.dart';

class SelectLocationComponent extends StatefulWidget {
  final Function(String name, LatLng latLng, String locationId)
  onLocationSelected;

  const SelectLocationComponent({super.key, required this.onLocationSelected});

  @override
  State<SelectLocationComponent> createState() =>
      _SelectLocationComponentState();
}

class _SelectLocationComponentState extends State<SelectLocationComponent> {
  String? locationName;
  LatLng? latLng;
  String? locationId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Select Location',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
        ),
        const SizedBox(height: 16),
        LocationButton(
          label: locationName ?? 'Add Return Location',
          onTap: () async {
            showModalBottomSheet(
              enableDrag: true,
              showDragHandle: true,

              context: context,
              builder: (context) => BlocProvider(
                create: (context) => CarBookingCubit()..getAllLocations(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  height: 400.h,
                  child: BlocBuilder<CarBookingCubit, CarBookingState>(
                    builder: (context, state) {
                      if (state is GetLocationLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GetLocationSuccess) {
                        return Column(
                          children: [
                            Expanded(
                              child: state.locations.data!.isEmpty
                                  ? const Center(
                                      child: Text('لا يوجد عناوين متاحه'),
                                    )
                                  : ListView.builder(
                                      itemCount: state.locations.data!.length,
                                      itemBuilder: (context, index) {
                                        final location =
                                            state.locations.data![index];
                                        return ListTile(
                                          textColor:
                                              state
                                                      .locations
                                                      .data![index]
                                                      .isActive ==
                                                  1
                                              ? Colors.green
                                              : Colors.black,
                                          iconColor:
                                              state
                                                      .locations
                                                      .data![index]
                                                      .isActive ==
                                                  1
                                              ? Colors.green
                                              : Colors.black,
                                          title: Text(location.location ?? ''),

                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                          leading: const Icon(
                                            Icons.location_on,
                                          ),
                                          subtitle: Text(
                                            location.latitude ?? '',
                                          ),
                                          onTap: () {
                                            setState(() {
                                              locationName = location.location;
                                              latLng = LatLng(
                                                double.parse(
                                                  location.latitude ?? '',
                                                ),
                                                double.parse(
                                                  location.longitude ?? '',
                                                ),
                                              );
                                              locationId = location.id
                                                  .toString();
                                              widget.onLocationSelected(
                                                locationName!,
                                                latLng!,
                                                locationId!,
                                              );
                                            });

                                            context.pop();
                                          },
                                        );
                                      },
                                    ),
                            ),
                            CustomButton(
                              text: 'Add New Location',
                              onPressed: () {
                                context.push(RouterNames.location);
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      } else if (state is GetLocationError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: Text('Bottom Sheet'));
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}

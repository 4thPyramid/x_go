import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/client/features/location/presentation/widgets/google_map_widget.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/delivery/features/delivery_location/presentation/logic/cubit/delivery_location_cubit.dart';
import 'package:x_go/delivery/features/delivery_location/presentation/widgets/info_tile.dart';

class DeliveryLocationView extends StatelessWidget {
  const DeliveryLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DeliveryLocationCubit, DeliveryLocationState>(
        builder: (context, state) {
          if (state is CurrentLocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrentLocationError ||
              state is DeliveryLocationError) {
            return Center(
              child: Text(
                (state as dynamic).errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (state is CurrentLocationSuccess) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMapWidget(
                  initialLocation: state.currentPosition,
                  onTap: (_) {},
                  markers: state.markers,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      color: Colors.blue,
                      width: 5,
                      points: state.polylines,
                    ),
                  },
                  onMapCreated: (controller) {
                    controller.animateCamera(
                      CameraUpdate.newLatLng(state.currentPosition),
                    );
                  },
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 50.w,
                        height: 5.h,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            child: const Icon(
                              Icons.person_2_outlined,
                              color: Colors.black,
                            ),
                          ),
                          title: const Text(
                            'waleed seafan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('مندوب التوصيل'),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          InfoTile(
                            title: 'وقت التوصيل',
                            subtitle: '${state.duration} ',
                            icon: Icons.timer_sharp,
                          ),
                          InfoTile(
                            title: 'المسافة',
                            subtitle: '${state.distance} ',
                            icon: Icons.directions_outlined,
                          ),
                          InfoTile(
                            title: 'مكان التوصيل',
                            subtitle: 'القاهرة',
                            icon: Icons.location_on_outlined,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              height: 45.h,
                              onPressed: () =>
                                  reportDeliveryBottomSheet(context),
                              text: 'الإبلاغ عن مشكلة',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              height: 45.h,
                              onPressed: () =>
                                  successDeliveryBottomSheet(context),
                              text: 'تأكيد التوصيل',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is SuccessArrived) {
            return Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 100),
                const SizedBox(height: 30),
                const Text(
                  'تم التوصيل بنجاح',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CustomButton(height: 40.h, onPressed: () {}, text: 'تأكيد'),
              ],
            );
          }

          return const Center(child: FlutterLogo());
        },
      ),
    );
  }
}

void successDeliveryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 30),
          const Text(
            'تم التوصيل بنجاح',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CustomButton(height: 40.h, onPressed: () {}, text: 'تأكيد'),
        ],
      ),
    ),
  );
}

void reportDeliveryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber, color: Colors.red, size: 100),
          const SizedBox(height: 30),
          const Text(
            'تم الابلاغ عن مشكلة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          CustomTextFormField(
            maxLines: 4,
            hintText: 'اكتب المشكلة التي تواجهك ',
          ),
          const SizedBox(height: 20),
          CustomButton(height: 40.h, onPressed: () {}, text: 'تأكيد'),
        ],
      ),
    ),
  );
}

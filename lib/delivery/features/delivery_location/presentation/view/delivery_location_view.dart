import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/client/features/location/presentation/widgets/google_map_widget.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/delivery/features/delivery_location/presentation/logic/cubit/delivery_location_cubit.dart';

class DeliveryLocationView extends StatelessWidget {
  const DeliveryLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DeliveryLocationCubit, DeliveryLocationState>(
        builder: (context, state) {
          if (state is CurrentLocationSuccess) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMapWidget(
                  initialLocation: state.currentPosition,
                  onTap: (value) {},
                  markers: state.markers,
                  onMapCreated: (controller) {
                    controller.animateCamera(
                      CameraUpdate.newLatLng(state.currentPosition),
                    );
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.person_2_outlined,
                                color: Colors.black,
                              ),
                            ),
                            title: Text('waleed seafan'),
                            subtitle: Text('مندوب التوصيل'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.timer_sharp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  title: Text('وقت التوصيل'),
                                  subtitle: Text('12:00 مساءً'),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.pin_drop_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  title: Text('مكان التوصيل'),
                                  subtitle: Text('القاهرة'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                height: 40.h,
                                onPressed: () {
                                  reportDeliveryBottomSheet(context);
                                },
                                text: 'الابلاغ عن مشكلة',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                height: 40.h,
                                onPressed: () {
                                  successDeliveryBottomSheet(context);
                                },
                                text: 'تأكيد التوصيل',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CurrentLocationError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
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

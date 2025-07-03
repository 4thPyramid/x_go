import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/location_button.dart';
import 'package:x_go/core/routes/router_names.dart';

class SelectLocationComponent extends StatelessWidget {
  const SelectLocationComponent({super.key});

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
        LocationButton(label: 'Add pickup Location', onTap: () {}),
        const SizedBox(height: 16),
        LocationButton(
          label: 'Add Return Location',
          onTap: () {
            context.push(RouterNames.location);
          },
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}

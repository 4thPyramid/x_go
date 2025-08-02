import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';

void reportDeliveryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
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
    ),
  );
}

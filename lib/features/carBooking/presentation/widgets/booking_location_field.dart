import 'package:flutter/material.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';

class BookingLocationFields extends StatelessWidget {
  const BookingLocationFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          prefixIcon: Icon(Icons.pin_drop),
          labelText: 'Add Pickup Location',
        ),
        SizedBox(height: 8),
        CustomTextFormField(
          prefixIcon: Icon(Icons.pin_drop),
          labelText: 'Add Return Location',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/features/profile/presentation/widgets/gender_fields.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_text_field.dart';

class ProfileFormFields extends StatefulWidget {
  const ProfileFormFields({super.key});

  @override
  State<ProfileFormFields> createState() => _ProfileFormFieldsState();
}

class _ProfileFormFieldsState extends State<ProfileFormFields> {
    final _formKey = GlobalKey<FormState>();

   final _firstNameController = TextEditingController(text: "ahmed");
  final _lastNameController = TextEditingController(text: "mohamed");
  final _emailController = TextEditingController(text: "ahemedmohamed@gmail.com");
  final _phoneController = TextEditingController(text: "(+20) 1553456789");
  
 
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
   return Form(
     key: _formKey,
     child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.person_outlined),
                  labelText: "First Name",
                                    fillColor: Colors.white,

                  controller: _firstNameController,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: CustomTextFormField(
                  labelText: "Last Name",
                                    fillColor: Colors.white,

                  prefixIcon: Icon(Icons.person_outlined,),
                  controller: _lastNameController,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          
          // Email field
         CustomTextFormField(
            labelText: "Email",
            prefixIcon: Icon(Icons.email_outlined),
            controller: _emailController,
                              fillColor: Colors.white,

            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 30.h),
          
          // Gender and Phone in same row
          Row(
            children: [
              Expanded(
                child:GenderFields(),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.phone_outlined),
                  labelText: "Phone",
                  fillColor: Colors.white,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ],
      ),
   );
  }
} 
    

 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';


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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('First Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      
                                        fillColor: Colors.white,
                    
                      controller: _firstNameController,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text('Last Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                    CustomTextFormField(
                      
                                        fillColor: Colors.white,
                    
                     
                      controller: _lastNameController,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          
          // Email field
         Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

           children: [
             const Text('Email', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
             SizedBox(height: 8.h),
             CustomTextFormField(
                   
                controller: _emailController,
                                  fillColor: Colors.white,
             
                keyboardType: TextInputType.emailAddress,
              ),
           ],
         ),
          SizedBox(height: 30.h),
          
         
          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text('Phone', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
              SizedBox(height: 8.h),
              CustomTextFormField(
               
                fillColor: Colors.white,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ],
      ),
   );
  }
} 
    

 
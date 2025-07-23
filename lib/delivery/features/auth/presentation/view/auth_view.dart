import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/logo.dart';
import 'package:x_go/delivery/features/auth/presentation/widgets/tab_bar_widget.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';

class DeliveryAuthView extends StatelessWidget {
  const DeliveryAuthView({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 24.h),
              child: DefaultTabController(
                length: 2,
                initialIndex: index,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    LogoWidget(),
                    SizedBox(height: 10.h),
                    TabBarWidget(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

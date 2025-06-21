 import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'app_styles.dart';

AppBar customAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      actions: [
        IconButton(
          icon:
              const Icon(Icons.arrow_forward_ios, color: AppColors.greyText),
          onPressed: () => context.pop(context),
        ),
      ],
      title: Text(title, style: AppStyles.s22),
    );
  }

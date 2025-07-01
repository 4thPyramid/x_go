import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                       IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                        },
                      ),
                      const Spacer(),
                      Text(
                        'Profile',
                        style: TextStyle(color: Colors.white , fontSize: 20.sp, fontWeight: FontWeight.w500),
                        
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          context.push(RouterNames.profileDetails);
                        },
                      ),
                    ],
                  ),
                );
  }
}
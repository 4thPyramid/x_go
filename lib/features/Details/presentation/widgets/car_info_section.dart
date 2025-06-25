import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarInfoSection extends StatelessWidget {
  const CarInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: InfoCard(
            title: 'Max Speed',
            value: '310km/h',
            icon: Icons.speed,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: InfoCard(
            title: 'Engine',
            value: 'V12',
            icon: Icons.settings,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: InfoCard(
            title: 'Ability',
            value: '2 Seats',
            icon: Icons.event_seat,
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: Card(
        
       
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28,),
              const SizedBox(height: 8),
                            Text(title, style:  TextStyle(fontSize: 10.sp, color: Colors.grey,fontWeight: FontWeight.w400)),

              const SizedBox(height: 17),
                            Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),

            ],
          ),
        ),
      ),
    );
  }
}

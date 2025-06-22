import 'package:flutter/material.dart';

class ProfileItemTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSwitch;

  const ProfileItemTile({
    super.key,
    required this.title,
    this.icon,
    this.isSwitch = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: Colors.grey[700]) : null,
      title: Text(title),
      trailing: isSwitch
          ? Switch(value: true, onChanged: (v) {})
          : const Icon(Icons.edit, size: 20),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileItemTile extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final IconData? icon;
  final bool isSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool showTrailing;
  final Color? color;
  final void Function()? onTap;

  const ProfileItemTile({
    super.key,
    required this.title,
    this.icon,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.showTrailing = true,
    this.titleStyle,
    this.color,
    this.onTap,
    // ← القيمة الافتراضية: يظهر Edit
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, color: color ?? Colors.grey[700])
          : null,

      title: Text(title, style: titleStyle),
      onTap: onTap,
      trailing: !showTrailing
          ? null
          : isSwitch
          ? Switch(value: switchValue, onChanged: onSwitchChanged)
          : const Icon(Icons.edit, size: 20, color: Colors.grey),
    );
  }
}

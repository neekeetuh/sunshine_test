import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const UserInfoRow({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 15),
        Text(
          value,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    );
  }
}

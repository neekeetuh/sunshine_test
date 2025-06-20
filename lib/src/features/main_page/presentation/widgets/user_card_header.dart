import 'package:flutter/material.dart';
import 'package:sunshine_test/src/features/main_page/domain/models/user.dart';
import 'package:sunshine_test/src/features/main_page/presentation/widgets/user_info_row.dart';

class UserCardHeader extends StatelessWidget {
  const UserCardHeader({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white,
          child: Text(
            user.name[0],
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 51, 80, 110),
            ),
          ),
        ),
        const SizedBox(height: 35),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        UserInfoRow(
          icon: Icons.work,
          value: user.companyName,
        ),
      ],
    );
  }
}

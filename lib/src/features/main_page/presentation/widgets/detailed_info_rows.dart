import 'package:flutter/material.dart';
import 'package:sunshine_test/src/features/main_page/domain/models/user.dart';
import 'package:sunshine_test/src/features/main_page/presentation/widgets/user_info_row.dart';

class DetailedInfoRows extends StatelessWidget {
  const DetailedInfoRows({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UserInfoRow(
          icon: Icons.email_outlined,
          value: user.email,
        ),
        const SizedBox(height: 20),
        UserInfoRow(
          icon: Icons.phone_outlined,
          value: user.phone,
        ),
        const SizedBox(height: 20),
        UserInfoRow(
          icon: Icons.location_city_outlined,
          value: user.city,
        ),
      ],
    );
  }
}

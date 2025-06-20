import 'package:sunshine_test/src/features/main_page/data/dtos/user_dto.dart';

//модель, используемая в domain слое и на ui
class User {
  final String name;
  final String email;
  final String phone;
  final String companyName;
  final String city;

  const User({
    required this.name,
    required this.email,
    required this.phone,
    required this.companyName,
    required this.city,
  });

  factory User.fromDto(UserDto dto) {
    return User(
      name: dto.name,
      email: dto.email,
      phone: dto.phone,
      companyName: dto.companyName,
      city: dto.city,
    );
  }
}

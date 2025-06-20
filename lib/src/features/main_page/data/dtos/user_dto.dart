//класс, использующийся для получения сырых данных из какого-то источника данных
//в идеале dto должен максимально соответствовать по структуре ответу, но в данном задании я решил не усложнять и использовать
//только необходимые данные (иначе нужно было создавать дополнительные dto для компании, адреса и геолокации)
class UserDto {
  final String name;
  final String email;
  final String phone;
  final String companyName;
  final String city;

  const UserDto({
    required this.name,
    required this.email,
    required this.phone,
    required this.companyName,
    required this.city,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      companyName: json['company']?['name'] ?? 'N/A',
      city: json['address']?['city'] ?? 'N/A',
    );
  }
}

import 'package:dio/dio.dart';
import 'package:sunshine_test/src/features/main_page/data/api_config.dart';
import 'package:sunshine_test/src/features/main_page/data/dtos/user_dto.dart';

//интерфейс для источника данных, позволяет репозиторию не зависеть от конкретной реализации, что позволит легко подменять
//источник данных при необходимости (или при определенных условиях)
abstract interface class IUsersDataSource {
  Future<UserDto> fetchUser({required int userId});
}

//источник данных, используемый для получения данных из сети
class UsersNetworkDataSource implements IUsersDataSource {
  final Dio _dio;

  const UsersNetworkDataSource({required Dio dio}) : _dio = dio;
  @override
  Future<UserDto> fetchUser({required int userId}) async {
    //обработки ошибок здесь нет, т.к. она происходит на ui, и, если необходимо выводить на экран только факт ошибки,
    //надобности в классификации типов ошибок нет
    final response = await _dio
        .get('${ApiConfig.baseUrl}/${ApiConfig.usersEndpoint}/$userId');
    final jsonData = response.data as Map<String, dynamic>;
    return UserDto.fromJson(jsonData);
  }
}

import 'package:sunshine_test/src/features/main_page/data/data_sources/users_data_source.dart';
import 'package:sunshine_test/src/features/main_page/domain/models/user.dart';

//для репозитория, в отличие от дата сорса не создан отдельный интерфейс, т.к. шанс необходимости подмены реализации репозитория
//в рамках такой задачи минимален
class UsersRepository {
  final IUsersDataSource _dataSource;

  const UsersRepository({required IUsersDataSource dataSource})
      : _dataSource = dataSource;

  Future<User> fetchUser({required int userId}) async {
    final userDto = await _dataSource.fetchUser(userId: userId);
    return User.fromDto(userDto);
  }
}

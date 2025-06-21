import 'dart:convert';

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
    final response = await _dio.get(
      '${ApiConfig.baseUrl}/${ApiConfig.usersEndpoint}/$userId',
      //дополнительные параметры запроса добавляются для того, чтобы обойти защиту cloudflare, т.к. jsonplaceholder api использует
      //ее для защиты от ботов
      //без задания этих параметров запросы с мобильных устройств(как реальных, так и эмуляторов) работали нестабильно
      //т.к. могла быть замечена подозрительная активность, из-за чего cloudflare добавлял дополнительную проверку,
      //показывая "Attention Required!" страницу, на которой пользователь должен подтвердить, что он не бот (например, пройти капчу)
      //т.к. в процессе запроса из нашего приложения этого сделать невозможно, проверка была провалена, и был возвращен ответ с 403
      //кодом ошибки

      //ключевым параметром, позволяющим обойти защиту cloudflare является хедер 'Accept', в который передается значение, наиболее
      //похожее на то, что используют веб-браузеры при запросах (т.к. в запросах от браузера обычно перечисляются несколько различных
      //типов поддерживаемого контента)

      //однако, это не гарантирует 100% успешную работу запросов, поэтому при возникновении ошибок, можно попробовать запустить
      //приложение через браузер

      //если загрузка происходит слишком длительное количество времени (5+ секунд), скорее всего cloudflare заметил подозрительную
      //активность и запросил пройти проверку на бота, что нельзя сделать из самого приложения
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Mobile Safari/537.36',
          'Accept': 'application/json, text/plain, */*',
          'Connection': 'keep-alive',
          'Referer': 'https://www.google.com/',
          'Accept-Language': 'en-US,en;q=0.9',
          'DNT': '1',
          'Sec-Fetch-Site': 'none',
          'Sec-Fetch-Mode': 'no-cors',
          'Sec-Fetch-Dest': 'empty',
          'Cache-Control': 'max-age=0',
          'Pragma': 'no-cache',
          'Upgrade-Insecure-Requests': '1',
        },
      ),
    );
    final jsonData = jsonDecode(response.data) as Map<String, dynamic>;
    return UserDto.fromJson(jsonData);
  }
}

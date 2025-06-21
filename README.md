# sunshine_test

Flutter 3.22.1

Dart 3.4.1

## Инструкция по запуску
- Клонировать репозиторий и перейти в папку проекта:
```bash
git clone https://github.com/neekeetuh/sunshine_test.git
cd sunshine_test
```

- Установить зависимости:

```bash
flutter pub get
```

- Выбрать устройство для запуска (реальное, либо эмулятор), после чего запустить приложение либо в редакторе кода, либо через терминал:

```bash
flutter run
```

## Важные замечения

В процессе выполнения задания столкнулся с интересным кейсом:

jsonplaceholder api использует cloudflare для отслеживания подозрительной активности и блокировки ботов, из-за чего при попытке получить данные с api из мобильного приложения возникали (и могут возникать до сих пор) ошибки.

Если в мобильном приложении возникают ошибки при получении данных, можно запустить приложение через веб-браузер

P.S. Подробнее расписал в комментариях в файле lib\src\features\main_page\data\data_sources\users_data_source.dart

## Скриншоты

![Screenshot_1750498329](https://github.com/user-attachments/assets/10ace1de-f36e-4164-8b9e-dce311c73e3a)

![Screenshot_1750498452](https://github.com/user-attachments/assets/12938532-6e43-4977-bb96-7bc10c45f275)

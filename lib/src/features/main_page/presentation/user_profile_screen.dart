import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sunshine_test/src/common/string_consts.dart';
import 'package:sunshine_test/src/features/main_page/data/data_sources/users_data_source.dart';
import 'package:sunshine_test/src/features/main_page/domain/models/user.dart';
import 'package:sunshine_test/src/features/main_page/domain/repositories/users_repository.dart';
import 'package:sunshine_test/src/features/main_page/presentation/widgets/error_display.dart';
import 'package:sunshine_test/src/features/main_page/presentation/widgets/user_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = true;
  User? _user;
  String? _errorMessage;

  late UsersRepository _repository;

  @override
  void initState() {
    //по идее от репозитория должен зависить компонент бизнес-логики (bloc, change notifier etc.), но раз необходимо использовать
    //stateful widget, он инициализируется в самом стейте, и инъекция зависимостей для него происходит здесь же
    _repository = UsersRepository(
      dataSource: UsersNetworkDataSource(
        dio: Dio(),
      ),
    );
    _fetchUser();
    super.initState();
  }

  Future<void> _fetchUser() async {
    _isLoading = true;
    _errorMessage = null;
    try {
      //при изменении userId будут загружаться данные разных пользователей (всего в api их 10)
      _user = await _repository.fetchUser(userId: 1);
    } catch (_) {
      _errorMessage = StringConsts.fetchUserUiErrorMessage;
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 34, 59, 87),
                Color.fromARGB(255, 46, 134, 192)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  StringConsts.userProfileHeaderString,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _buildContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    } else if (_errorMessage != null) {
      return ErrorDisplay(
        errorMessage: _errorMessage!,
        onRetry: _fetchUser,
      );
    } else if (_user != null) {
      return UserCard(user: _user!);
    }
    return const SizedBox.shrink();
  }
}

import 'package:dio/dio.dart';
import 'package:final_project_clean/app/presentation/widgets/pop_up_message.dart';
import 'package:final_project_clean/domain/entitites/error_response.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './login_page.dart';
import './login_presenter.dart';
import '../../../../domain/entitites/user.dart';
import '../Register/register_page.dart';
import '../Tabs/tabs_page.dart';

class LoginController extends Controller {
  final LoginPresenter _presenter;

  LoginController(this._presenter);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  // = User(name: "test", address: "test",email: "test",id: 0,phoneNumber: "08", token: "test", userName: "test", imageUrl: "test");
  User? get user => _user;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  ErrorResponse? errorResponse;

  @override
  void initListeners() {
    _initObserver();
  }

  void _getUser(String username, String password) {
    _showLoading();
    _presenter.getUser(username, password);
  }

  Future<void> loginNow(String username, String password) async {
    _getUser(username, password);
    do {
      await Future.delayed(const Duration(milliseconds: 1));
    } while (_isLoading);
    if (user?.success == true) {
      _navigateToTabs();
    } else {
      final context = getContext();
      showDialog(
          context: context,
          builder: (context) => PopUpMessage(
              text: "Login Failed",
              buttonText: "OK",
              message: errorResponse!.message));
    }
  }

  void _initObserver() {
    _presenter.onErrorLogin = (e) {
      if (e is DioError) {
        errorResponse = ErrorResponse(
            success: e.response!.data['success'],
            message: e.response!.data['message']);
      }

      _hideLoading();
    };
    _presenter.onFinishLogin = () {
      _hideLoading();
    };
    _presenter.onSuccessLogin = (User? data) {
      _user = data;
    };
  }

  void navigateToRegister() {
    final context = getContext();
    Navigator.pushReplacementNamed(context, RegisterPage.routeName);
  }

  void _navigateToTabs() async {
    final context = getContext();
    Navigator.pushReplacementNamed(context, TabsPage.routeName);
  }

  void _showLoading() {
    _isLoading = true;
    refreshUI();
  }

  void _hideLoading() {
    _isLoading = false;
    refreshUI();
  }

  @override
  void onDisposed() {
    super.onDisposed();
    _usernameController.dispose();
    _passwordController.dispose();
    _presenter.dispose();
  }
}

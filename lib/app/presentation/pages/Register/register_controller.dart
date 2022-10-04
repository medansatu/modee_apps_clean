import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './register_presenter.dart';
import '../../../../domain/entitites/register.dart';
import '../login/login_page.dart';

class RegisterController extends Controller {
  final RegisterPresenter _presenter;

  RegisterController(this._presenter);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Register? _register = Register(id: 0);
  Register? get register => _register;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController get confirmPasswordController => _confirmPasswordController;

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;

  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  @override
  void initListeners() {
    _initObserver();
  }

  void _registerUser(String name, String username, String email, String phoneNumber, String address, String password) {
    _showLoading();
    _presenter.registerUser(name, username, email, phoneNumber, address, password);
  }


  Future<void> registerNow(String name, String username, String email, String phoneNumber, String address, String password) async {
    _registerUser(name, username, email, phoneNumber, address, password);
    do {
      await Future.delayed(const Duration(milliseconds: 100));
    } while (_isLoading);
    if (register?.id != 0) {
      navigateToLogin();
    }
  }

  void _initObserver() {
    _presenter.onErrorRegister = (e) {
      _hideLoading();
    };
    _presenter.onFinishRegister = () {
      _hideLoading();
    };
    _presenter.onSuccessRegister = (Register? data) {
      _register = data;
    };
  }

  void navigateToLogin() {
    final context = getContext();
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
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
    _addressController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _presenter.dispose();
  }
}

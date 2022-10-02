import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './login_controller.dart';
import '../../../../domain/entitites/user.dart';
import '../../widgets/text_input.dart';
import '../../widgets/password_input.dart';
import '../../widgets/login_register_text.dart';
import '../../widgets/login_register_button.dart';

class LoginPage extends View {
  LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() {
    final loginController = Injector.appInstance.get<LoginController>();
    return _LoginViewState(loginController);
  }
}

class _LoginViewState extends ViewState<LoginPage, LoginController> {
  _LoginViewState(super.controller);

  @override
  Widget get view => Scaffold(
        key: globalKey,
        // body: SingleChildScrollView(
        body: ControlledWidgetBuilder<LoginController>(
          builder: (BuildContext context, LoginController controller) => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: SvgPicture.asset(
                      'lib/app/presentation/assets/images/logowithtagline.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextInput(
                    controller: controller.usernameController,
                    type: TextInputType.emailAddress,
                    text: "Username",
                  ),
                  PasswordInput(
                    controller: controller.passwordController,
                    text: "Password",
                  ),
                  LoginRegisterText(
                    text1: "Don't Have Any Account?",
                    text2: "Register Here!",
                    route: () => controller.navigateToRegister(),
                  ),
                  LoginRegisterButton(
                    text: "Login",
                    action: () => controller.loginNow(controller.usernameController.text, controller.passwordController.text),
                    // route: () => controller.navigateToTabs(),
                  ),
                ],
              ),
              controller.isLoading
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor,
                        ),
                      ))
                  : SizedBox(),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
}

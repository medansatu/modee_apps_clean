import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './register_controller.dart';
import '../../../../domain/entitites/register.dart';
import '../../widgets/text_input.dart';
import '../../widgets/password_input.dart';
import '../../widgets/login_register_text.dart';
import '../../widgets/login_register_button.dart';

class RegisterPage extends View {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    final registerController = Injector.appInstance.get<RegisterController>();
    return _RegisterViewState(registerController);
  }
}

class _RegisterViewState extends ViewState<RegisterPage, RegisterController> {
  _RegisterViewState(super.controller);

  @override
  Widget get view => Scaffold(
        key: globalKey,
        // body: SingleChildScrollView(
        body: ControlledWidgetBuilder<RegisterController>(
          builder: (BuildContext context, RegisterController controller) =>
              Stack(
                children: [
                  SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: Column(
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
                      controller: controller.nameController,
                      type: TextInputType.name,
                      text: "Name",
                    ),
                    TextInput(
                      controller: controller.usernameController,
                      type: TextInputType.name,
                      text: "Username",
                    ),
                    TextInput(
                      controller: controller.emailController,
                      type: TextInputType.emailAddress,
                      text: "Email",
                    ),
                    TextInput(
                      controller: controller.phoneNumberController,
                      type: TextInputType.number,
                      text: "Phone Number",
                    ),
                    PasswordInput(
                      controller: controller.passwordController,
                      text: "Password",
                    ),
                    PasswordInput(
                      controller: controller.confirmPasswordController,
                      text: "Confirm Password",
                    ),
                    TextInput(
                      controller: controller.addressController,
                      type: TextInputType.name,
                      text: "Address",
                    ),
                    LoginRegisterText(
                      text1: "Already Have an Account?",
                      text2: "Login Here!",
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.065,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(controller.passwordController.text == controller.confirmPasswordController.text){
                            controller.registerNow(
                            controller.nameController.text,
                            controller.usernameController.text,
                            controller.emailController.text,
                            controller.phoneNumberController.text,
                            controller.addressController.text,
                            controller.passwordController.text,
                          );
                          }
                          print("ERROR");                      
                          // Navigator.of(context).pushReplacementNamed(routeName);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color.fromRGBO(255, 130, 201, 1),
                        ),
                      ),
                    ),
                  ],
            ),
          ),
          controller.isLoading ? Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                child: Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor,),)
              ) : SizedBox(),
                ],
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
}

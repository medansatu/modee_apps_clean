import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injector/injector.dart';

import '../../widgets/login_register_button.dart';
import './profile_controller.dart';

class ProfilePage extends View {

  ProfilePage({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    final profileController = Injector.appInstance.get<ProfileController>();
    return _ProfileViewState(profileController);
  }
}

class _ProfileViewState extends ViewState<ProfilePage, ProfileController> {
  _ProfileViewState(super.controller);

  Widget _buildTextContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      // height: 30,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [              
              Text(text, style: TextStyle(fontSize: 15,color: Colors.grey),),
              Spacer(),
            ],
          ),
        );
  }
  
  @override
  Widget get view => Scaffold(
    body: ControlledWidgetBuilder<ProfileController>(builder: (BuildContext _context, ProfileController controller) => 
    controller.isLoading
    ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    ),
                  ) : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: (controller.profile!.imageUrl != null) ? Container (
            height: MediaQuery.of(context).size.height *0.15,
            width: MediaQuery.of(context).size.height *0.15,
            decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(
                controller.profile!.imageUrl.toString()))),
            child:  SizedBox(),            
          ) : CircleAvatar(radius: 50, backgroundColor: Theme.of(context).accentColor, child: const Icon(Icons.person, size: 50, color: Colors.black,),),
        ),
        SizedBox(
          height: 20,
        ),
        _buildSectionTitle("Name"),
        _buildTextContainer(controller.profile!.name.toString()),
        _buildSectionTitle("Username"),
        _buildTextContainer(controller.profile!.userName.toString()),
        _buildSectionTitle("Phone Number"),
        _buildTextContainer(controller.profile!.phoneNumber.toString()),
        _buildSectionTitle("Email"),
        _buildTextContainer(controller.profile!.email.toString()),
        _buildSectionTitle("Address"),
        _buildTextContainer(controller.profile!.address.toString()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Spacer(),
              InkWell(
                child: Text("Change Password"),
                onTap: () {},
              )
            ],
          ),
        ),
        LoginRegisterButton(text: "Log Out", action: (){}),
        Container(
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: SvgPicture.asset('lib/app/presentation/assets/images/logowithtagline.svg', fit: BoxFit.cover,),
            ),
      ],
    ),),
  );
}
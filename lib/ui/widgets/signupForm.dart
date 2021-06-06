import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/authentication/authentication_event.dart';
import 'package:shoppesta_store/bloc/authentication/bloc.dart';
import 'package:shoppesta_store/bloc/signup/bloc.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';

class SignupForm extends StatefulWidget {
  final StoreRepository _storeRepository;
  SignupForm({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _storeRepository = storeRepository;

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _num = TextEditingController();
  File photo;
  GeoPoint location;
  SignUpBloc _signUpBloc;
  bool seePassword = false;

  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;


  bool password(){
    seePassword = ! seePassword;
    return seePassword;
  }

  bool get isFilled =>

      _name.text.isNotEmpty &&
          _email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _num.text.isNotEmpty &&
          photo != null ;


  _getLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        location= new GeoPoint(position.latitude,position.longitude);
      });

      _getAddressFromLatLng();

    }).catchError((e) {
      print(e);
    });
  }


  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
    } catch (e) {
      print(e);
    }
  }


  bool isButtonEnabled(SignUpState state) {
    return !state.isSubmitting;
  }


  _onSubmitted() async {
    await _getLocation();

    _signUpBloc.add(
      SignUpWithCredentialsPressed(
          email: _email.text, password: _password.text),
    );


   await _signUpBloc.add(

      Submitted(
          email: _email.text,
          password: _password.text,
          name: _name.text,
          location: location,
          num: _num.text,
          photo: photo),
    );

  }

  @override
  void initState() {
    _getLocation();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return BlocListener<SignUpBloc,SignUpState>(
        listener: (BuildContext context, SignUpState state){

          if (state.isFailure)
            return Text('failed');
          else if (state.isSubmitting)
            return CircularProgressIndicator();
          else if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            Navigator.of(context).pop();
          }
        },
      child: BlocBuilder<SignUpBloc,SignUpState>(
        builder: (context, state){
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [

                  Container(
                    width: size.width,
                    child: CircleAvatar(
                      radius: size.width * 0.3,
                      backgroundColor: Colors.transparent,
                      child: photo == null
                          ? GestureDetector(
                        onTap: () async {
                          File getPic = await FilePicker.getFile(
                              type: FileType.image);
                          if (getPic != null) {
                            setState(() {
                              photo = getPic;
                            });
                          }
                        },
                        child: Image.asset('assets/profilephoto.png'),
                      )
                          : GestureDetector(
                        onTap: () async {
                          File getPic = await FilePicker.getFile(
                              type: FileType.image);
                          if (getPic != null) {
                            setState(() {
                              photo = getPic;
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: size.width * 0.3,
                          backgroundImage: FileImage(photo),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height*0.03,
                  ),

                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      border: InputBorder.none,
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.red),
                  ),
                  ),

                  Stack(
                    children: [
                      TextFormField(
                        controller: _password,
                        obscureText: password(),
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          border: InputBorder.none,
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.red),

                        ),


                      ),
                      Positioned(
                        child: IconButton(
                          icon: Icon(password()?Icons.visibility_off:Icons.visibility,
                            size: 22,),
                          onPressed: (){
                            setState(() {
                              password();
                            });
                          },
                        ),
                        right: 1,
                        top:10,
                      )
                    ],
                  ),

                  Stack(
                    children: [
                      TextFormField(
                        controller:_confirmPassword,
                        obscureText: password(),
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          border: InputBorder.none,
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.red),

                        ),


                      ),
                      Positioned(
                        child: IconButton(
                          icon: Icon(password()?Icons.visibility_off:Icons.visibility,
                            size: 22,),
                          onPressed: (){
                            setState(() {
                              password();
                            });
                          },
                        ),
                        right: 1,
                        top:10,
                      )
                    ],
                  ),


                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      border: InputBorder.none,
                      labelText: 'Brand name',
                      labelStyle: TextStyle(color: Colors.red),
                    ),
                  ),


                  TextFormField(
                    controller: _num,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      border: InputBorder.none,
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.red),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        if (isButtonEnabled(state)) {

                          print(location);
                          print(_currentPosition);
                         _onSubmitted();

                        } else {}
                      },
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                          BorderRadius.circular(size.height * 0.05),
                        ),
                        child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: size.height * 0.025,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                  ),

                ],
              ),
            ),


          );
        },
      ),
    );

  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/signup/bloc.dart';
import 'package:shoppesta_store/constants.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'package:shoppesta_store/ui/widgets/signupForm.dart';





class SignUp extends StatelessWidget {

  StoreRepository _storeRepository;
  SignUp({@required StoreRepository storeRepository}):assert(storeRepository != null) ,
        _storeRepository = storeRepository;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
      ),


      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(storeRepository: _storeRepository) ,
        child: SignupForm(
          storeRepository: _storeRepository,
        )
      ),
    );
  }
}

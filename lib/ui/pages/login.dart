import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/login/login_bloc.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'package:shoppesta_store/ui/widgets/LoginForm.dart';

import '../../constants.dart';


class Login extends StatelessWidget {
  final StoreRepository _storeRepository;

  Login({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _storeRepository = storeRepository;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome",
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          storeRepository: _storeRepository,
        ),
        child: LoginForm(
          storeRepository: _storeRepository,
        ),
      ),
    );
  }
}
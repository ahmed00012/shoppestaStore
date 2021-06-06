import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import '/ui/pages/home.dart';


import 'bloc/authentication/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final StoreRepository _storeRepository = StoreRepository();



  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(storeRepository: _storeRepository)
        ..add(AppStarted()),
      child: Home()));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/authentication/bloc.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'package:shoppesta_store/ui/pages/Dashboard.dart';
import 'package:shoppesta_store/ui/pages/splash.dart';


import 'login.dart';

class Home extends StatelessWidget {
  final StoreRepository _storeRepository = StoreRepository() ;

  // Home({@required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Splash();
          }
          if (state is Authenticated) {


            return Dashboard(
              storeId: state.userId,
            );
          }
          if (state is AuthenticatedButNotSet) {
            return Login(storeRepository: _storeRepository);
          }
          if (state is Unauthenticated) {
            return Login(
              storeRepository: _storeRepository,
            );
          } else
            return Container();
        },
      ),
    );
  }
}
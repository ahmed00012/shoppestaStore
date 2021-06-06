export 'login_bloc.dart';
export 'login_event.dart';
export 'login_state.dart';


import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'login_state.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  StoreRepository _storeRepository;

  LoginBloc({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _storeRepository = storeRepository;

  @override
  LoginState get initialState => LoginState.empty();


  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
     if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);

    }
  }


  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();

    try {
      await _storeRepository.signInWithEmailAndPassword(email, password);

      yield LoginState.success();
    } catch (_) {
      LoginState.failure();
    }


  }
}
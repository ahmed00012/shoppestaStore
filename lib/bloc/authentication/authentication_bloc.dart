import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final StoreRepository _userRepository;

  AuthenticationBloc({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _userRepository = storeRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted)
      yield* _mapAppStartedToState();
    else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }


  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final uid = await _userRepository.getUser();
        final isFirstTime = await _userRepository.isFirstTime(uid);

        if (!isFirstTime) {
          yield Authenticated(uid);
        } else {
          yield Authenticated(uid);
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }
  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final isFirstTime =
    await _userRepository.isFirstTime(await _userRepository.getUser());

    if (!isFirstTime) {
      print('AuthenticatedButNotSet');
      yield AuthenticatedButNotSet(await _userRepository.getUser());

    } else {
      print('Authenticated');
      yield Authenticated(await _userRepository.getUser());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}

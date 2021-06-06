import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shoppesta_store/bloc/signup/bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  StoreRepository _storeRepository;

  SignUpBloc({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _storeRepository = storeRepository;

  @override
  SignUpState get initialState => SignUpState.empty();


  @override
  Stream<SignUpState> mapEventToState(
      SignUpEvent event,
      ) async* {
     if (event is SignUpWithCredentialsPressed) {
      yield* _mapSignUpWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }

     else if (event is Submitted) {
       final uid = await _storeRepository.getUser();
       yield* _mapSubmittedToState(
           photo: event.photo,
           name: event.name,
           userId: uid,
           location: event.location,
           num: event.num);
     }
  }


  Stream<SignUpState> _mapSubmittedToState(
      {
        File photo,
        String name,
        String userId,
        GeoPoint location,
        String num
      }) async* {
    yield SignUpState.loading();
    try {
      await _storeRepository.profileSetup(photo,userId,name,location,num);

      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
    }
  }


  Stream<SignUpState> _mapSignUpWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield SignUpState.loading();

    try {
      await _storeRepository.signUpWithEmailAndPassword(email, password);

      yield SignUpState.success();
    } catch (_) {
      SignUpState.failure();
    }
  }
}
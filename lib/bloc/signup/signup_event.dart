import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}


class Submitted extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String num;
  final File photo;
  final GeoPoint location;

  Submitted({this.email, this.password,this.name,this.num,this.photo,this.location});

  @override
  List<Object> get props => [email, password];
}

class SignUpWithCredentialsPressed extends SignUpEvent {

  final String email;
  final String password;

  SignUpWithCredentialsPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
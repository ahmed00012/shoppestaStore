

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel{
  String name;
  String num;
  String uid;
  GeoPoint location;
  String photo;




  StoreModel({this.name, this.uid,this.num,
    this.location,this.photo});
}
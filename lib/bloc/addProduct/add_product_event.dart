import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class CreateId extends AddProductEvent{
  final String storeId;
  final String id;
  CreateId({this.storeId,this.id});


}
class SubmitProduct extends AddProductEvent {
  final String storeId;
  final String name;
  final String category;
  final String gender;
  final double price;
  final List<File> photos;
  final List<String> sizes;

  SubmitProduct({this.storeId,this.gender, this.category,this.name,this.price,this.photos,this.sizes});

  @override
  List<Object> get props => [name, price];
}


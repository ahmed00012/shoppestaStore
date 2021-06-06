import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsListState extends Equatable {
  const ProductsListState();
  @override
  List<Object> get props => [];
}

class ProductsListInitialState extends ProductsListState {}

class ProductsLoadingState extends ProductsListState {}

class ProductsLoadedState extends ProductsListState {
  final Stream<QuerySnapshot> productStream;

  ProductsLoadedState({this.productStream});

  @override
  List<Object> get props => [productStream];
}
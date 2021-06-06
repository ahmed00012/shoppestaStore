import 'package:equatable/equatable.dart';

abstract class ProductsListEvent extends Equatable {
  const ProductsListEvent();

  @override
  List<Object> get props => [];
}

class ProductStreamEvent extends ProductsListEvent {
  final String currentStoreId;

  ProductStreamEvent({this.currentStoreId});

  @override
  List<Object> get props => [currentStoreId];
}
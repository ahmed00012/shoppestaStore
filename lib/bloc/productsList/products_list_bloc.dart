import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';
import 'products_list_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';


class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductRepository _productRepository;

  ProductsListBloc({@required ProductRepository productRepository})
      : assert(productRepository != null),
        _productRepository = productRepository;

  @override
  ProductsListState get initialState => ProductsListInitialState();

  @override
  Stream<ProductsListState> mapEventToState(
      ProductsListEvent event,
      ) async* {
    if (event is ProductStreamEvent) {
      yield* _mapStreamToState(currentStoreId: event.currentStoreId);
    }
  }

  Stream<ProductsListState> _mapStreamToState({String currentStoreId}) async* {
    yield ProductsLoadingState();


    Stream<QuerySnapshot> productStream =
    _productRepository.getProducts(storeId: currentStoreId);
    yield ProductsLoadedState(productStream: productStream);
  }
}
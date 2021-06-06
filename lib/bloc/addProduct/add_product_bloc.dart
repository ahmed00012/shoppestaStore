import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoppesta_store/bloc/addProduct/bloc.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'add_product_state.dart';
import 'add_product_event.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  ProductRepository _productRepository;

  AddProductBloc({@required ProductRepository productRepository})
      : assert(productRepository != null),
        _productRepository = productRepository;

  @override
  AddProductState get initialState => AddProductState.empty();


  @override
  Stream<AddProductState> mapEventToState(
      AddProductEvent event,
      ) async* {
   if (event is SubmitProduct) {

      yield* _mapSubmitProductToState(
          name: event.name,
          price: event.price,
        category: event.category,
        gender: event.gender,
        images: event.photos,
        sizes: event.sizes,
        storeId: event.storeId
      );
    }

  }


  Stream<AddProductState> _mapSubmitProductToState(
      {
        String storeId,
        List<File> images,
        String name,
        String id,
        String category,
        String gender,
        double price,
        List <String> sizes
      }) async* {

    yield AddProductState.loading();
    try {

     await _productRepository.productSetup(images,id,name,gender,category,price,sizes);

      yield AddProductState.success();
    } catch (_) {
      yield AddProductState.failure();
    }
  }



}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/addProduct/add_product_bloc.dart';
import 'package:shoppesta_store/models/product.dart';
import 'package:shoppesta_store/models/store_model.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'package:shoppesta_store/ui/widgets/addProductForm.dart';

class AddProduct extends StatelessWidget {
  final String storeId;
  const AddProduct({this.storeId});


  @override
  Widget build(BuildContext context) {
    final ProductRepository _productRepository = ProductRepository();


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(fontSize: 25.0,
          color: Colors.red
          ),

        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocProvider<AddProductBloc>(
        create: (context) => AddProductBloc(
          productRepository: _productRepository,
        ),
        child: AddProductForm(
          productRepository: _productRepository,
          storeId: storeId,
        ),
      ),
    );
  }
}

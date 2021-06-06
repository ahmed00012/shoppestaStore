import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/productsList/bloc.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';
import 'package:shoppesta_store/ui/widgets/productsWidget.dart';

class ProductsList extends StatefulWidget {
  final String storeId;
  ProductsList({this.storeId});

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  ProductRepository _productRepository = ProductRepository();
  ProductsListBloc _productsListBloc;

  @override
  void initState() {
    _productsListBloc = ProductsListBloc(productRepository: _productRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor:Colors.white12,
        title: Text('Products',style: TextStyle(color: Colors.red),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: BlocBuilder<ProductsListBloc, ProductsListState>(
        bloc: _productsListBloc,
        builder: (BuildContext context, ProductsListState state) {
          if (state is ProductsListInitialState) {
            _productsListBloc
                .add(ProductStreamEvent(currentStoreId: widget.storeId));
          }

          if (state is ProductsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductsLoadedState) {
            Stream<QuerySnapshot> productStream = state.productStream;


            return StreamBuilder(
              stream: productStream,
              builder: (context, snapshot) {
                if(snapshot.data == null) return Center(child: CircularProgressIndicator());
                if (snapshot.data.documents.isNotEmpty) {
                  if (snapshot.connectionState == ConnectionState.waiting) {

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    print(snapshot.data.documents.length);
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                      padding: EdgeInsets.all(5),
                      itemBuilder: (BuildContext context, int index) {

                        return Card(
                          elevation: 4,
                          child: Products(
                            storeId: widget.storeId,
                            itemId: snapshot.data.documents[index].documentID,
                          ),
                        );
                      },
                    );
                  }
                }
                else
                  return Text(
                    " You don't have any Items",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  );
              },
            );
          }
        },
      ),
    );
  }
}

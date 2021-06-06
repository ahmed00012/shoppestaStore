import 'package:flutter/material.dart';
import 'package:shoppesta_store/models/product.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';

class Products extends StatefulWidget {
  final String storeId, itemId;
  Products({this.storeId, this.itemId});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductRepository productRepository = ProductRepository();
  Product product = Product();
  getProductDetail() async {
    product = await productRepository.getProductDetail(
        storeId: widget.storeId, productId: widget.itemId);
    print(product.name);
    return Product(
        name: product.name,
        category: product.category,
        gender: product.gender,
        price: product.price,
        sizes: product.sizes,
        mainImage: product.mainImage);
  }

  deleteItem() async {
    await productRepository.deleteItem(
        currentStoreId: widget.storeId, selectedProductId: widget.itemId);
  }

  Widget photo(String photoLink) {
    return Image.network(
      photoLink,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getProductDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getProductDetail(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            Product product = snapshot.data;

            return GestureDetector(
                onTap: () {},
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            content: Wrap(
                              children: <Widget>[
                                Text(
                                  "Do you want to delete this Item",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "This action is irreversible.",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  await deleteItem();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ));
                },
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height * 0.02),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: size.height * 0.3,
                                width: size.width * 0.33,
                                child: photo(
                                  product.mainImage,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Gender : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Text(product.gender),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Category : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Text(product.category),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Sizes : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        for (int i = 0;
                                            i < product.sizes.length;
                                            i++)
                                          Padding(
                                            padding: EdgeInsets.all(2.1),
                                            child: Text(product.sizes[i]),
                                          )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Price: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 25),
                                        ),
                                        Text(
                                          product.price.toString(),
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )));
          }
        });
  }
}

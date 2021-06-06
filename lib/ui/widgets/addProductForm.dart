import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/addProduct/add_product_bloc.dart';
import 'package:shoppesta_store/bloc/addProduct/add_product_bloc.dart';
import 'package:shoppesta_store/bloc/addProduct/bloc.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';

class AddProductForm extends StatefulWidget {
  ProductRepository _productRepository;
  String storeId;
  AddProductForm({@required ProductRepository productRepository, this.storeId})
      : assert(productRepository != null),
        _productRepository = productRepository;

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  AddProductBloc _addProductBloc;
  String gender = '';
  String category = 'Shirt';
  List<String> sizes = <String>[];
  File photo1;
  File photo2;
  File photo3;

  _onSubmitted() async {

    await _addProductBloc.add(
      SubmitProduct(
          name: _name.text,
          photos: [photo1, photo2, photo3],
          price: double.parse(_price.text),
          gender: gender,
          category: category,
          sizes: sizes,
          storeId: widget.storeId),
    );
  }


  @override
  void initState() {
    _addProductBloc = BlocProvider.of<AddProductBloc>(context);


    super.initState();
  }

  Widget padding(size) {
    return Padding(padding: EdgeInsets.all(size));
  }

  void changeSelectedSize(String size) {
    if (sizes.contains(size)) {
      setState(() {
        sizes.remove(size);
      });
    } else {
      setState(() {
        sizes.insert(0, size);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state.isFailure)
          return Text('failed');
        else if (state.isSubmitting)
          return CircularProgressIndicator();
        else if (state.isSuccess) print('success');
      },
      child: BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              width: size.width,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      padding(10.0),
                      Container(
                        width: size.width * 0.25,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: photo1 == null
                            ? GestureDetector(
                                onTap: () async {
                                  File getPic = await FilePicker.getFile(
                                      type: FileType.image);
                                  if (getPic != null) {
                                    setState(() {
                                      photo1 = getPic;
                                    });
                                  }
                                },
                                child: Icon(Icons.add),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  File getPic = await FilePicker.getFile(
                                      type: FileType.image);
                                  if (getPic != null) {
                                    setState(() {
                                      photo1 = getPic;
                                    });
                                  }
                                },
                                child: Container(
                                  child: Image.file(photo1),
                                ),
                              ),
                      ),
                      padding(10.0),
                      Container(
                        width: size.width * 0.25,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: photo2 == null
                            ? GestureDetector(
                                onTap: () async {
                                  File getPic = await FilePicker.getFile(
                                      type: FileType.image);
                                  if (getPic != null) {
                                    setState(() {
                                      photo2 = getPic;
                                    });
                                  }
                                },
                                child: Icon(Icons.add),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  File getPic = await FilePicker.getFile(
                                      type: FileType.image);
                                  if (getPic != null) {
                                    setState(() {
                                      photo2 = getPic;
                                    });
                                  }
                                },
                                child: Container(
                                  child: Image.file(photo2),
                                ),
                              ),
                      ),
                      padding(10.0),
                      Container(
                        width: size.width * 0.25,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: photo3 == null
                            ? GestureDetector(
                                onTap: () async {
                                  File getPic = await FilePicker.getFile(
                                      type: FileType.image);
                                  if (getPic != null) {
                                    setState(() {
                                      photo3 = getPic;
                                    });
                                  }
                                },
                                child: Icon(Icons.add),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  File getPic = await FilePicker.getFile(
                                      type: FileType.image);
                                  if (getPic != null) {
                                    setState(() {
                                      photo3 = getPic;
                                    });
                                  }
                                },
                                child: Image.file(
                                  photo3,
                                ),
                              ),
                      ),
                      padding(10.0),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  padding(10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Gender : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: ListTile(
                          title: Icon(Icons.male),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red),
                            value: 'Men',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                                category = 'Shirt';
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: ListTile(
                          title: Icon(Icons.female),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red),
                            value: 'Women',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                                category = 'Shirt';
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: ListTile(
                          title: Icon(Icons.child_care_rounded),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red),
                            value: 'Children',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                                category = 'Shirt';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  padding(15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      padding(10.0),
                      Text(
                        'Category : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      padding(20.0),
                      DropdownButton<String>(
                        value: category,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red,
                        ),
                        iconSize: 35,
                        elevation: 16,
                        style: const TextStyle(color: Colors.red),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            category = newValue;
                          });
                        },
                        items: gender == 'Men'
                            ? <String>[
                                'Shirt',
                                'Pants',
                                'Shorts',
                                'T-shirt',
                                'Jeans',
                                'Sweatshirt',
                                'Sportswear',
                                'Jackets',
                                'Formal Suits',
                                'Swimwear',
                                'Accessories',
                                'Shoes',
                                'Underwear'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList()
                            : <String>[
                                'Shirt',
                                'Tunics',
                                'Blouses',
                                'T-shirt',
                                'Jeans',
                                'Sweatshirt',
                                'Sportswear',
                                'Jackets',
                                'Dresses',
                                'Skirts',
                                'Leggings',
                                'Swimwear',
                                'Accessories',
                                'Shoes',
                                'Underwear'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
                        child: Text(
                          'Available Sizes :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('XS'),
                              onChanged: (value) => changeSelectedSize('XS')),
                          Text('XS'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('S'),
                              onChanged: (value) => changeSelectedSize('S')),
                          Text('S'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('M'),
                              onChanged: (value) => changeSelectedSize('M')),
                          Text('M'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('L'),
                              onChanged: (value) => changeSelectedSize('L')),
                          Text('L'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('XL'),
                              onChanged: (value) => changeSelectedSize('XL')),
                          Text('XL'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('XXL'),
                              onChanged: (value) => changeSelectedSize('XXL')),
                          Text('XXL'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('XXXL'),
                              onChanged: (value) => changeSelectedSize('XXXL')),
                          Text('XXXL'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('XXXXL'),
                              onChanged: (value) => changeSelectedSize('XXXXL')),
                          Text('XXXXL'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('28'),
                              onChanged: (value) => changeSelectedSize('28')),
                          Text('28'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('30'),
                              onChanged: (value) => changeSelectedSize('30')),
                          Text('30'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('32'),
                              onChanged: (value) => changeSelectedSize('32')),
                          Text('32'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('34'),
                              onChanged: (value) => changeSelectedSize('34')),
                          Text('34'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('36'),
                              onChanged: (value) => changeSelectedSize('36')),
                          Text('36'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('38'),
                              onChanged: (value) => changeSelectedSize('38')),
                          Text('38'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('40'),
                              onChanged: (value) => changeSelectedSize('40')),
                          Text('40'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('42'),
                              onChanged: (value) => changeSelectedSize('42')),
                          Text('42'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('44'),
                              onChanged: (value) => changeSelectedSize('44')),
                          Text('44'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('46'),
                              onChanged: (value) => changeSelectedSize('46')),
                          Text('46'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('48'),
                              onChanged: (value) => changeSelectedSize('48')),
                          Text('48'),
                          Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              value: sizes.contains('50'),
                              onChanged: (value) => changeSelectedSize('50')),
                          Text('50'),
                        ],
                      ),
                    ],
                  ),
                  padding(10.0),
                  GestureDetector(
                    onTap: () {


                      _onSubmitted();
                    },
                    child: Container(
                      width: size.width * 0.5,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(size.height * 0.05),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  padding(20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

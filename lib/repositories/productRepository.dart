import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoppesta_store/models/product.dart';


class ProductRepository {
  final String storeId;
  final Firestore _firestore;
  ProductRepository({Firestore firestore, this.storeId})
      : _firestore = firestore ?? Firestore.instance;

  Future<int> productsLength() async {
    final QuerySnapshot qSnap = await Firestore.instance
        .collection('users')
        .document(storeId)
        .collection('products')
        .getDocuments();
    final int documents = qSnap.documents.length;
    return documents;
  }


  Stream<QuerySnapshot> getProducts({storeId}) {
    return _firestore
        .collection('users')
        .document(storeId)
        .collection('products')
        .snapshots();
  }

  Future<Product> getProductDetail({storeId,productId}) async {
    Product _product = Product();
    List sizes ;
    List images;

    await _firestore.collection('users').document(storeId).collection('products').document(productId).get().then((product) {

      _product.id = product.documentID;
      _product.name = product['name'];
      images =product['photoUrl'];
      _product.mainImage=images[0];
      print(_product.mainImage);
      _product.gender = product['gender'];
      sizes = product['sizes'];
      _product.sizes=sizes.cast<String>().toList();
      _product.category = product['category'];
      _product.price= product['price'];
    });
    return _product;
  }

  Future deleteItem({currentStoreId, selectedProductId}) async {
    await _firestore
        .collection('users')
        .document(currentStoreId)
        .collection('products')
        .document(selectedProductId)
        .delete();
  }


  Future<void> productSetup(List<File> photos, String id, String name,
      String gender, String category, double price, List<String> sizes) async {
    DocumentReference reference = await _firestore
        .collection('users')
        .document(storeId)
        .collection('products')
        .document(id);
    id = reference.documentID;
    print(id);
    List<String> imagesUrls = [];
    StorageUploadTask storageUploadTask;
    String path = '';

    for (int i = 0; i < 3; i++) {
      path = i.toString();
      photos.forEach((element) async {
        storageUploadTask = FirebaseStorage.instance
            .ref()
            .child('userPhotos')
            .child(storeId)
            .child(id)
            .child(path)
            .putFile(element);
        await storageUploadTask.onComplete;
        imagesUrls.add(await FirebaseStorage.instance
            .ref()
            .child('userPhotos')
            .child(storeId)
            .child(id)
            .child(path)
            .getDownloadURL());
      });
    }

    return await storageUploadTask.onComplete.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        await _firestore
            .collection('users')
            .document(storeId)
            .collection('products')
            .document(id)
            .setData({
          'photoUrl': imagesUrls,
          'name': name,
          'gender': gender,
          'category': category,
          'price': price,
          'sizes': sizes
        });
      });
    });
  }
}

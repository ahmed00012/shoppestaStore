import 'package:flutter/material.dart';
import 'package:shoppesta_store/repositories/productRepository.dart';
import 'package:shoppesta_store/ui/pages/addProduct.dart';
import 'package:shoppesta_store/ui/pages/productsList.dart';




class Dashboard extends StatefulWidget{

final String storeId;
Dashboard({this.storeId});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProductRepository productRepository;
  String productsLength = '';
  Widget padding (double size){
    return Padding(padding: EdgeInsets.all(size));
  }

  Future<int> length()async{
  return await productRepository.productsLength();
  }

  setLength(){
    length().then((val) => setState(() {
      productsLength = val.toString();
    }));
  }
  @override
  void initState() {
    productRepository= ProductRepository(storeId: widget.storeId);
    setLength();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: TextStyle(color: Colors.red),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.02,
      ),
      body: Column(
        children: [
          padding(10),
          ListTile(
            subtitle: FlatButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.attach_money,
                size: 30.0,
                color: Colors.green,
              ),
              label: Text('12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.green)),
            ),
            title: Text(
              'Revenue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
          ),
          padding(10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductsList(storeId: widget.storeId,)) ),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                             onPressed: null,
                              icon: Icon(Icons.track_changes,color: Colors.red,),
                              label: Text("Products",style: TextStyle(color: Colors.red))),
                          subtitle: Text(
                            productsLength,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 60.0,color: Colors.black),
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: (){

                            },
                            icon: Icon(Icons.shopping_cart,color: Colors.red),
                            label: Text("Orders",style: TextStyle(color: Colors.red),)),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0),
                        )),
                  ),
                ),
              ),

            ],
          ),
          padding(5),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.tag_faces,color: Colors.red),
                            label: Text("Sold",style: TextStyle(color: Colors.red))),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.bar_chart,color: Colors.red),
                            label: Text("Income",style: TextStyle(color: Colors.red))),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0),
                        )),
                  ),
                ),
              ),

            ],
          ),
          padding(5),
          GestureDetector(
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AddProduct( storeId: widget.storeId,)) ),
            child: Container(
              width: size.width*0.5,
              height: size.height*0.22 ,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(

                  child: Column(
                    children: [
                      padding(5),
                      Text('Add Product',style: TextStyle(color: Colors.red)),
                      Icon(Icons.add,size: 120,color: Colors.black,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

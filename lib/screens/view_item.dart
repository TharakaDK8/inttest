

import 'package:flutter/material.dart';
import 'package:inttest/screens/shopping_card_page.dart';
import 'package:provider/provider.dart';

import '../model/items.dart';
import '../model/item_add_model.dart';
import 'package:share_plus/share_plus.dart';


class ViewItemPage extends StatefulWidget {
  const ViewItemPage({Key? key, required this.items}) : super(key: key);

   final Result items;

  @override
  _ViewItemPageState createState() => _ViewItemPageState();
}

class _ViewItemPageState extends State<ViewItemPage> {


  final TextEditingController textController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  //late Future<Items> futureAlbum;
  bool pressAttention = false;

  @override
  void initState() {
    super.initState();
    // futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ItemsAddModel>(builder: (context, textmodel, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: widget.items.category!.toLowerCase() == "guitar" ? Colors.purple.shade100 :Colors.blueAccent.shade100,
        appBar: AppBar(
          //backgroundColor: Colors.orange,
          backgroundColor: Colors.transparent,//Color(0x44000000),
          elevation: 0,
          //title: Center(child: Text('ShopCart and Todolist')),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {

                      Share.share(widget.items.image.toString());
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color:  pressAttention ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() => pressAttention = !pressAttention);
                    },
                  ),
                  Stack(
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ShoppingCardPage()));
                        },
                      ),
                      Visibility(
                        visible: textmodel.countadd==0 ? false:true,
                        child: Positioned(
                          top: 2,
                            right: 2,
                            child: Container(
                              width: 15,
                              height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  //border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),

                                ),

                                child: Center(child: Text(textmodel.countadd.toString(),style: const TextStyle(color: Colors.white,fontSize: 10),)))),
                      )
                    ],
                  ),
                  //Text(textmodel.countadd.toString())
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child:
                  Image.network(widget.items.image.toString(),fit: BoxFit.fitWidth,),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  //border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),

                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const  EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        children: [
                          Text(widget.items.model.toString(),style: const TextStyle(color: Colors.black54,fontSize: 26,fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Brand",style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w600),),
                          Text(widget.items.brand.toString(),style: const TextStyle(color: Colors.black54,fontSize: 18,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Price",style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w600),),
                          Text(widget.items.price.toString(),style: const TextStyle(color: Colors.black54,fontSize: 18,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Color",style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w600),),
                          Text(widget.items.colour.toString(),style: const TextStyle(color: Colors.black54,fontSize: 18,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Weight",style: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w600),),
                          Text(widget.items.weight.toString(),style: const TextStyle(color: Colors.black54,fontSize: 18,)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal.shade400,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text(
                            "Add to Cart",
                            style:
                            TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Roboto')),
                        onPressed: () {
                          textmodel.add(widget.items);
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => ViewPage()),
                          // );

                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

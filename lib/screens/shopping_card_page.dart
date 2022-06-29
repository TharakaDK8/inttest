import 'package:flutter/material.dart';
import 'package:inttest/screens/view.dart';
import 'package:provider/provider.dart';
import '../model/item_add_model.dart';

class ShoppingCardPage extends StatefulWidget {
  const ShoppingCardPage({Key? key}) : super(key: key);

  @override
  _ShoppingCardPageState createState() => _ShoppingCardPageState();
}

class _ShoppingCardPageState extends State<ShoppingCardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsAddModel>(
      builder: (context, itemsModel, child) {
        return Scaffold(
          backgroundColor: Colors.teal.shade50,
          // appBar: AppBar(
          //   backgroundColor: Colors.orange,
          //   title: Text("Shopping List"),
          // ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Text("Bless",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: Colors.teal),),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: itemsModel.shoppingCard.isEmpty
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart_outlined,color: Colors.teal.shade400,size: 160,),
                          const Text("Your cart is currently",style: TextStyle(fontSize: 30,color: Colors.grey),),
                          const Text("empty !",style: TextStyle(fontSize: 30,color: Colors.grey),),
                          SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                          SizedBox(
                            width:MediaQuery.of(context).size.width*0.8,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.teal.shade400,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                  "Brows Items",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 22,fontFamily: 'Roboto')),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ViewPage()),
                                );

                              },
                            ),
                          )

                        ],
                      ),
                    ),
                  )
                      : ListView.builder(
                          itemCount: itemsModel.shoppingCard.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                  elevation: 20,
                                  //color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                color: itemsModel.shoppingCard[index].category!.toLowerCase() == "guitar" ? Colors.purple.shade100 :Colors.blueAccent.shade100,
                                //Colors.deepPurpleAccent.shade100,
                                child: SizedBox(
                                  height: 140,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top:2,
                                        right: 2,
                                        child: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          itemsModel
                                              .delete(itemsModel.shoppingCard[index]);
                                        },
                                      ),),
                                      Column(children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                                              child: SizedBox(
                                                //width:100,
                                                  height: 100,

                                                  child: Image.network(itemsModel.shoppingCard[index].image.toString(),fit: BoxFit.fitHeight,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 18, 60, 18),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      itemsModel.shoppingCard[index].model.toString(),style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),),
                                                  const SizedBox(height: 10,),
                                                  Text("Rs ${itemsModel
                                                      .shoppingCard[index].price}",style: const TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w600),),
                                                ],
                                              ),
                                            ),




                                          ],
                                        ),



                                      ],),
                                    ],
                                  ),
                                )
                                // ListTile(
                                //   title: Text(
                                //       textmodel.shoppingCard[index].name.toString()),
                                //   subtitle: Text(textmodel
                                //       .shoppingCard[index].price
                                //       .toString()),
                                //   trailing: IconButton(
                                //     icon: Icon(Icons.delete),
                                //     onPressed: () {
                                //       textmodel
                                //           .delete(textmodel.shoppingCard[index]);
                                //     },
                                //   ),
                                // ),
                              ),
                            );
                          }),
                ),
                Visibility(
                  visible: itemsModel.shoppingCard.isNotEmpty ? true:false,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Divider(color: Colors.teal,height: 1,thickness: 3,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Visibility(
                    visible: itemsModel.shoppingCard.isNotEmpty ? true:false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30,color: Colors.black54),),
                          Text('Rs. ${itemsModel.total}',style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 30,color: Colors.black54),),
                        ],
                      ),
                    ),
                  ),
                ),
            Visibility(
              visible: itemsModel.shoppingCard.isNotEmpty ? true:false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width:MediaQuery.of(context).size.width*0.8,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                      "Check out",
                      style:
                      TextStyle(color: Colors.white, fontSize: 22,fontFamily: 'Roboto')),
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ViewPage()),
                    // );

                  },
                ),),
            ),
            )
                // Card(
                //   child: Visibility(
                //     visible: textmodel.shoppingCard.length != 0 ? true:false,
                //     child: ListTile(
                //       title: Text('TOTAL PRICE => ${textmodel.total} ₺'),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}

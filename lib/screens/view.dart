import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inttest/screens/view_item.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/items.dart';
import '../model/item_add_model.dart';
import 'package:search_page/search_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  Future<Items> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/919a0d45-c054-4452-8175-65538e554272'));
    if (response.statusCode == 200) {
      return Items.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  final TextEditingController textController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late Future<Items> futureAlbum;
  List<Result> items = [];
  List<Result> itemsSearch = [];

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ItemsAddModel>(builder: (context, textmodel, child) {
      return Scaffold(
        backgroundColor: Colors.teal.shade50,
        // appBar: AppBar(
        //   backgroundColor: Colors.orange,
        //   title: Center(child: Text('ShopCart and Todolist')),
        //   actions: [
        //     Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Row(
        //         children: <Widget>[
        //           IconButton(
        //             icon: Icon(
        //               Icons.shopping_cart,
        //               color: Colors.white,
        //             ),
        //             onPressed: () {
        //               Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => ShoppingCardPage()));
        //             },
        //           ),
        //           Text(textmodel.countadd.toString())
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        body: SafeArea(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // FloatingActionButton(
              //   child: Icon(Icons.search),
              //   tooltip: 'Search people',
              //   onPressed: () => showSearch(
              //     context: context,
              //     delegate: SearchPage<Result>(
              //       items: items,
              //       searchLabel: 'Search people',
              //       suggestion: Center(
              //         child: Text('Filter people by name, surname or age'),
              //       ),
              //       failure: Center(
              //         child: Text('No person found :('),
              //       ),
              //       filter: (items) => [
              //         items.name,
              //       ],
              //       builder: (items) => GestureDetector(
              //         onTap: (){
              //           print(items.name.toString());
              //         },
              //         child: ListTile(
              //           title: Text(items.name.toString()),
              //           // subtitle: Text(person.surname),
              //           // trailing: Text('${person.age} yo'),
              //         ),
              //       ),
              //
              //     ),
              //   ),
              // ),

              Expanded(
                child: FutureBuilder<Items>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Column(

                        children: [
                          //Text("sdfsdfsfsdf"),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("BLISS",style: TextStyle(fontSize: 30,color: Colors.teal.shade400,fontWeight: FontWeight.w600),),
                                const CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                  NetworkImage('https://via.placeholder.com/150'),
                                  backgroundColor: Colors.transparent,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                            child: Row(
                              children: const [
                                Text("Hello,",style: TextStyle(color: Colors.grey,fontSize: 14),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                            child: Row(
                              children: const [
                                Text("Sudesh Sharma",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 20),),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: (){
                                showSearch(
                                  context: context,
                                  delegate: SearchPage<Result>(
                                    items: items,
                                    searchLabel: 'Search Items',

                                    suggestion: const Center(
                                      child: Text('Search item by name'),
                                    ),
                                    failure: const Center(
                                      child: Text('No item found :('),
                                    ),
                                    filter: (items) => [
                                      items.name,
                                    ],

                                    builder: (items) => GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ViewItemPage(items: itemsSearch.isNotEmpty
                                                ?items :items)));
                                        //print(items);

                                      },
                                      child: ListTile(
                                        title: Text(items.name.toString()),
                                      ),
                                    ),

                                  ),
                                );
                              },
                              child: Container(

                                width: MediaQuery.of(context).size.width*0.85,
                                height:40,
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),

                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color:Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14.0)),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Search Your Model',style: TextStyle(color: Colors.grey),),
                                      Container(
                                          width:25,
                                          height:30,
                                          decoration: const BoxDecoration(
                                            //border: Border.all(color: Colors.grey),
                                            color:Colors.teal,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),

                                          ),
                                          child: const Icon(Icons.search,color: Colors.white,))
                                    ],
                                  ),
                                ),
                              )
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                            child: Row(
                              children: const [
                                Text("By Category",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 20),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height:50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                //your widget items here
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            itemsSearch = items
                                                .where((element) => element.category!
                                                .toLowerCase()
                                                .contains("guitar"))
                                                .toList();
                                          });
                                        },
                                        child: Container(
                                            height:50,
                                            width:100,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.grey),
                                              color:Colors.pinkAccent.shade100,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(14.0)),


                                            ),
                                            child:Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: const [
                                                  FaIcon(FontAwesomeIcons.guitar,color: Colors.white,),
                                                  //Icon(Icons.music_note),
                                                  Text("Guitar",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                ],
                                              ),
                                            )
                                        ))
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            itemsSearch = items
                                                .where((element) => element.category!
                                                .toLowerCase()
                                                .contains("piano"))//drums
                                                .toList();
                                          });
                                        },
                                        child: Container(
                                            height:50,
                                            width:100,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.grey),
                                              color:Colors.amber.shade200,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(14.0)),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: const [
                                                  //FaIcon(FontAwesomeIcons.music),
                                                  Icon(Icons.piano,color: Colors.white,),
                                                  Text("Piano",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                ],
                                              ),
                                            )
                                        ))
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            itemsSearch = items
                                                .where((element) => element.category!
                                                .toLowerCase()
                                                .contains("drums"))//drums
                                                .toList();
                                          });
                                        },
                                        child: Container(
                                          height:50,
                                            width:100,
                                            decoration: BoxDecoration(
                                             // border: Border.all(color: Colors.grey),
                                              color:Colors.greenAccent.shade200,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(14.0)),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: const [
                                                  FaIcon(FontAwesomeIcons.drum,color: Colors.white,),
                                                  //Icon(Icons.music_note),
                                                  Text("Drums",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                ],
                                              ),
                                            )
                                        ))
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            itemsSearch = items
                                                .toList();
                                          });
                                        },
                                        child: Container(
                                            height:50,
                                            width:100,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.grey),
                                              color:Colors.teal.shade200,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(14.0)),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: const [
                                                  FaIcon(FontAwesomeIcons.music,color: Colors.white,),
                                                  //Icon(Icons.music_note),
                                                  Text("All",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                ],
                                              ),
                                            )
                                        ))
                                ),
                                // Padding(
                                //     padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                //     child: GestureDetector(
                                //         onTap:(){
                                //           setState(() {
                                //             itemsSearch = items
                                //                 .toList();
                                //           });
                                //         },
                                //         child: Text("all"))
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                            child: Row(
                              children: const [
                                Text("Most Popular",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 20),),
                              ],
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          //   child: TextField(
                          //     textAlign: TextAlign.left,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         itemsSearch = items
                          //             .where((element) => element.category!
                          //             .toLowerCase()
                          //             .contains("piano"))
                          //             .toList();
                          //       });
                          //     },
                          //     //controller: _textEditingController,
                          //     decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         errorBorder: InputBorder.none,
                          //         enabledBorder: InputBorder.none,
                          //         contentPadding: EdgeInsets.all(0),
                          //         hintText: 'Search'),
                          //   ),
                          // ),
                          const SizedBox(height: 10,),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.28,
                              child: ListView.builder(
                                  itemCount: itemsSearch.isNotEmpty
                                      ? itemsSearch.length:snapshot.data!.result!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    items=snapshot.data!.result!;
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          //print("sdfdfsd");
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ViewItemPage(items: itemsSearch.isNotEmpty
                                                  ? itemsSearch[index]:snapshot.data!.result![index],)));
                                        },
                                        child: Container(
                                            height:50,
                                            width:150,
                                            decoration: BoxDecoration(
                                              //border: Border.all(color: Colors.grey),
                                              color: itemsSearch.isNotEmpty
                                                  ? (itemsSearch[index].category!.toLowerCase() == "guitar" ? Colors.purpleAccent.withOpacity(0.3):
                                              itemsSearch[index].category!.toLowerCase() == "drums" ? Colors.blueAccent.shade100:
                                              itemsSearch[index].category!.toLowerCase() == "piano"  ? Colors.blueAccent.shade100:
                                              Colors.purple)
                                                  :(snapshot.data!.result![index].category!.toLowerCase() == "guitar" ? Colors.purpleAccent.withOpacity(0.3):
                                              snapshot.data!.result![index].category!.toLowerCase() == "drums" ? Colors.blueAccent.shade100:
                                              snapshot.data!.result![index].category!.toLowerCase() == "piano"  ? Colors.blueAccent.shade100:
                                              Colors.purple),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(40.0)),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      //Icon(Icons.music_note),
                                                      Text(itemsSearch.isNotEmpty
                                                          ? itemsSearch[index].model.toString():snapshot.data!.result![index].model.toString(),style: const TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w600),),
                                                      //Text("drums",style: TextStyle(color: Colors.white),),
                                                      const Icon(Icons.favorite,color: Colors.white,),
                                                      //FaIcon(FontAwesomeIcons.heart,color: Colors.grey,),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Center(
                                                      child: SizedBox(
                                                        width: 120,
                                                        height: 120,
                                                        child: Image.network(itemsSearch.isNotEmpty
                                                            ? itemsSearch[index].image.toString():snapshot.data!.result![index].image.toString(),fit: BoxFit.fill,),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                    );
                                    //   Card(
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(itemsSearch.isNotEmpty
                                    //           ? itemsSearch[index].brand.toString():snapshot.data!.result![index].brand.toString()),
                                    //       // Text(products.allProducts[index].productName.toString()),
                                    //       // Text(
                                    //       //     '${products.allProducts[index].price.toString()}₺'),
                                    //       Row(
                                    //         children: [
                                    //           IconButton(
                                    //             icon: Icon(Icons.shopping_cart),
                                    //             onPressed: () {
                                    //               textmodel.add(snapshot.data!.result![index]);
                                    //             },
                                    //           ),
                                    //           IconButton(
                                    //             icon: Icon(Icons.favorite),
                                    //             onPressed: () {
                                    //               products.deleteProduct(
                                    //                   snapshot.data!.result![index]);
                                    //             },
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // );
                                  }),
                            ),
                          ),
                        ],
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }

                  }
                ),
              ),
              // Form(
              //   key: _formKey,
              //   child: Container(
              //     child: Column(
              //       children: [
              //         TextFormField(
              //           controller: textController,
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return " boş olamaz.";
              //             } else {
              //               return null;
              //             }
              //           },
              //           decoration: InputDecoration(
              //               hintText: "Product or Todo name",
              //               suffixIcon: IconButton(
              //                 icon: Icon(Icons.clear),
              //                 onPressed: () {
              //                   textController.clear();
              //                 },
              //               )),
              //         ),
              //         TextFormField(
              //           controller: priceController,
              //           keyboardType: TextInputType.number,
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return " not be empty.";
              //             } else {
              //               return null;
              //             }
              //           },
              //           decoration: InputDecoration(
              //               hintText: "Price",
              //               suffixIcon: IconButton(
              //                 icon: Icon(Icons.clear),
              //                 onPressed: () {
              //                   priceController.clear();
              //                 },
              //               )),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //               ElevatedButton(
              //                 onPressed: () {
              //                   products.addProduct(
              //                     Product(
              //                         price: int.parse(priceController.text),
              //                         productName: textController.text),
              //                   );
              //                 },
              //                 child: Text('Add'),
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}

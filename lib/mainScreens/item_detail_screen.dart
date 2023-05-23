import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:foodpanda_users_app/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../assistantMethods/assistant_methods.dart';
class ItemDetailScreen extends StatefulWidget {
final Items? model;
ItemDetailScreen({this.model});
  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  TextEditingController counterTextEditingController =TextEditingController();


  @override

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: MyAppBar(sellerUID:widget.model!.sellerUID),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.thumbnailUrl.toString()),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: NumberInputPrefabbed.directionalButtons
                (
                controller:counterTextEditingController ,
                incDecBgColor: Colors.amber,
                min:1,
                max:9,
                initialValue:1 ,
                buttonArrangement:ButtonArrangement.incRightDecLeft,
                ),
              
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(widget.model!.title.toString(),
            style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold
            ),),
             ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.normal
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text( widget.model!.price.toString()+' €' ,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.normal
                ),),
            ),
             SizedBox(height: 20,),
             Center(
               child: InkWell(
                onTap: ()
                {
                  int itemCounter=int.parse(counterTextEditingController.text);
                  List<String> separateItemIDList=separateItemIDs();
// 1-check if item exist already in cart
separateItemIDList.contains(widget.model!.itemID)
                  ? Fluttertoast.showToast(msg: 'Item is already in cart')
:
// 2-add to cart
addItemToCart(widget.model!.itemID,context,itemCounter);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.amber,
                        ],
                        begin:  FractionalOffset(0.0, 0.0),
                        end:  FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      )
                  ),
                  width: MediaQuery.of(context).size.width-40,
                  height: 50,
                  child: const Center(
                  child: Text(''
                      'Add to Cart',style:
                    TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),),
                  ),

                ),
            ),
             )

          ],
        ),
      ),
    );
  }
}

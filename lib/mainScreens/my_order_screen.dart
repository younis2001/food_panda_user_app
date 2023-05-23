import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/assistant_methods.dart';
import 'package:foodpanda_users_app/globel/globel.dart';
import 'package:foodpanda_users_app/widgets/order_card.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          flexibleSpace: Container(

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
          ),
          title: const Text('My Orders',style: TextStyle(fontSize: 45,fontFamily: 'Signatra'),),
          centerTitle: true,

        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPreferences!.getString('uid'))
          .collection('orders')
          .where('status',isEqualTo: 'normal')
          .orderBy('orderTime',descending: true)
          .snapshots(),
          builder: (c,snapshot)
          {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (c,index)
            {
              return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('items')
                      .where('itemID',whereIn: separateOrdersItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                      .where('orderBy', whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                      .orderBy('publishedDate',descending: true)
                      .get(),
                builder: (c,snap)
                {
return snap.hasData
    ?OrderCard(
  itemCount: snap.data!.docs.length,
  data: snap.data!.docs,
  orderID: snapshot.data!.docs[index].id,
  seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
)
    : Center(child: circularProgress(),);

                },
              );
            }
            )
                :Center(child: circularProgress(),);
          },
        ),
      ),
    );

  }
}

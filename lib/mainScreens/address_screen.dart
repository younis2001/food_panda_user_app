import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';
import 'package:foodpanda_users_app/mainScreens/save_address_screen.dart';
import 'package:foodpanda_users_app/models/address.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

import '../globel/globel.dart';
import '../widgets/address_design.dart';
class AddressScreen extends StatefulWidget {
  final String? sellerUID;
  final double? totalAmount;
  AddressScreen({this.sellerUID,this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
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
        leading:IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back) ),
        title: Text(
          'iFood' ,
          style: const TextStyle(fontSize: 45, fontFamily: "Signatra",letterSpacing: 3),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,

      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (c)=>SaveAddressScreen()));
        },
          label: Text('Add New Address'),
      backgroundColor: Colors.cyan,
      icon: Icon(Icons.add_location),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Select Address:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),
          ),
          Consumer<AddressChanger>(
              builder: (context,address,c)
                  {
                    return Flexible(
                        child: StreamBuilder<QuerySnapshot>(
                          stream:FirebaseFirestore.instance.collection("users")
                              .doc(sharedPreferences!.getString("uid"))
                              .collection("userAddress")
                              .snapshots(),
                          builder: (context,snapshot)
                          {
                            return !snapshot.hasData
                                ? Center(child: circularProgress(),)
                                :snapshot.data!.docs.length==0
                                ?Container()
                                :ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context,index)
                              {
                                return AddressDesign(
                                  currentIndex: address.count,
                                  value: index,
                                  addressID: snapshot.data!.docs[index].id,
                                  totalAmount: widget.totalAmount,
                                  sellerUID: widget.sellerUID,
                                  model: Address.fromJson(
                                    snapshot.data!.docs[index].data() as Map<String,dynamic>
                                  ),
                                );
                              },
                            );
                          },
                        )
                    );
                  }

          )
        ],
      ),

    );
  }
}

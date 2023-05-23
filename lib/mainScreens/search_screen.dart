import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/sellers.dart';
import 'package:foodpanda_users_app/widgets/sellers_design.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? restaurantDocumentsList;
  String sellerNameText='';

  initSearchingRestaurant(String textEntered)async
  { restaurantDocumentsList=
    FirebaseFirestore.instance
        .collection('sellers')
        .where('sellerName',isGreaterThanOrEqualTo:textEntered )
        .get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: TextField(
          onChanged: (textEntered)
          {
           setState(() {
             sellerNameText= textEntered;
           });
initSearchingRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: "search Restaurant here...",hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: Icon(Icons.search),
            color: Colors.white,
              onPressed: (){
initSearchingRestaurant(sellerNameText);
              },
            ),

          ),
          style: TextStyle(
            color: Colors.white,fontSize: 16
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantDocumentsList,
          builder: (context,snapshot)
              {
return snapshot.hasData
    ? ListView.builder(
    itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index)
                {
                  Sellers model =Sellers.fromjson(
                    snapshot.data!.docs[index].data()!  as Map<String,dynamic>
                  );
                  return SellersDesignWidget(
                      model:model ,
                      context: context,
                  );
                },

)
    : Center(child: Text('No Record Found'),);
              }
      ),
    );
  }
}

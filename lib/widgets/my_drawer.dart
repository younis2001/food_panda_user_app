import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/authentication/auth_screen.dart';
import 'package:foodpanda_users_app/globel/globel.dart';
import 'package:foodpanda_users_app/mainScreens/address_screen.dart';
import 'package:foodpanda_users_app/mainScreens/history_screen.dart';
import 'package:foodpanda_users_app/mainScreens/search_screen.dart';

import '../mainScreens/my_order_screen.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25,bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height:160 ,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(sharedPreferences!.getString('photoUrl')!),

                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(sharedPreferences!.getString('name')!,style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Train'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                Divider(
                 height: 10,
                 color: Colors.grey,
                 thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.black,),
                  title: Text('home',
                  style: TextStyle(color: Colors.black),),
                  onTap: (){

                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.reorder,color: Colors.black,),
                  title: Text('My Orders',
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (c)=>MyOrderScreen()));
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.access_time,color: Colors.black,),
                  title: Text('Hisroey',
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>HistoryScreen()));

                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.search,color: Colors.black,),
                  title: Text('search',
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>SearchScreen()));

                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.add_location,color: Colors.black,),
                  title: Text('Add New Addres',
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>AddressScreen()));

                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app,color: Colors.black,),
                  title: Text('Sign Out',
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
firebaseAuth.signOut().then((value) 
{
  Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
});
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

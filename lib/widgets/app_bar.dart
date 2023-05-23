import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_Item_counter.dart';
import 'package:provider/provider.dart';

import '../mainScreens/cart_screen.dart';
class MyAppBar extends StatefulWidget  with PreferredSizeWidget{
final PreferredSizeWidget? bottom;
MyAppBar({this.bottom,this.sellerUID});
final String? sellerUID;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => bottom==null ?Size(56,AppBar().preferredSize.height):
  Size(56,80+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
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
    style: const TextStyle(fontSize: 30, fontFamily: "Signatra"),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    actions: [
    Stack(
    children: [
    IconButton(
    icon: const Icon(Icons.shopping_cart, color: Colors.cyan,),
    onPressed: ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (c)=>CartScreen(sellerUID: widget.sellerUID,)));
    },
    ),
    Positioned(
    child: Stack(
    children: [
    const Icon(
    Icons.brightness_1,
    size:20.0 ,
    color: Colors.green,
    ),
    Positioned(
    top: 3,
    right: 4,
    child: Center(child: Consumer<CartItemCounter>(
      builder: (context,counter,c)
      {
        return Text(counter.count.toString(),
          style:TextStyle(color: Colors.white,fontSize: 12)
        );
      },
    )
    ),
    )
    ],
    )),
    ],
    )
    ],
    );
  }
}

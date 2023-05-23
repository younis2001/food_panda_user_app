import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_Item_counter.dart';
import 'package:foodpanda_users_app/globel/globel.dart';
import 'package:provider/provider.dart';
separateItemIDs()
{
  List<String>separateItemIDsList=[],defaultItemList=[];
  int i= 0;
  defaultItemList=sharedPreferences!.getStringList('userCart')!;

  for(i;i<defaultItemList.length;i++)
    {
      String item= defaultItemList[i].toString();
      var pos=item.lastIndexOf(":");
      String getItemId= (pos !=-1) ? item.substring(0,pos) : item;

      print('\n this is itemsID now =' + getItemId);
      separateItemIDsList.add(getItemId);
    }
  print('\n this is Items List now = ');
  print(separateItemIDsList);

  return separateItemIDsList;
}
separateOrdersItemIDs(orderIDs)
{
  List<String>separateItemIDsList=[],defaultItemList=[];
  int i= 0;
  defaultItemList=List<String>.from(orderIDs);

  for(i;i<defaultItemList.length;i++)
  {
    String item= defaultItemList[i].toString();
    var pos=item.lastIndexOf(":");
    String getItemId= (pos !=-1) ? item.substring(0,pos) : item;

    print('\n this is itemsID now =' + getItemId);
    separateItemIDsList.add(getItemId);
  }
  print('\n this is Items List now = ');
  print(separateItemIDsList);

  return separateItemIDsList;
}

addItemToCart(String? foodItemId,BuildContext context,int itemCounter)

{
List<String>? tempList=sharedPreferences!.getStringList('userCart');
tempList!.add(foodItemId! + ":$itemCounter");

FirebaseFirestore.instance.collection('users')
.doc(firebaseAuth.currentUser!.uid).update({
  'userCart':tempList,
}).then((value)
{
  Fluttertoast.showToast(msg: 'Item Added Successfully');
  sharedPreferences!.setStringList('userCart', tempList);
//update the badge
Provider.of<CartItemCounter>(context,listen: false).displayCartListItemNumber();
}
);
}

separateItemQuantities()
{
  List<int>separateItemQuantityList=[];
  List<String>defaultItemList=[];
  int i= 1;
  defaultItemList=sharedPreferences!.getStringList('userCart')!;

  for(i;i<defaultItemList.length;i++)
  {
    String item= defaultItemList[i].toString();

    List<String> listItemsCharacters=item.split(':').toList();
var quanNumber=int.parse(listItemsCharacters[1].toString());
    print('\n this is Quantities Niumber =' + quanNumber.toString());
    separateItemQuantityList.add(quanNumber);
  }
  print('\n this is Items List now = ');
  print(separateItemQuantityList);

  return separateItemQuantityList;
}

separateOrderItemQuantities(orderIDs)
{
  List<String>separateItemQuantityList=[];
  List<String>defaultItemList=[];
  int i= 1;
  defaultItemList=List<String>.from(orderIDs);

  for(i;i<defaultItemList.length;i++)
  {
    String item= defaultItemList[i].toString();

    List<String> listItemsCharacters=item.split(':').toList();
    var quanNumber=int.parse(listItemsCharacters[1].toString());
    print('\n this is Quantities Niumber =' + quanNumber.toString());
    separateItemQuantityList.add(quanNumber.toString());
  }
  print('\n this is Items List now = ');
  print(separateItemQuantityList);

  return separateItemQuantityList;
}

clearCartNow(context)
{
  sharedPreferences!.setStringList('userCart', ['garbageValue']);
  List<String>? emptyList=sharedPreferences!.getStringList('userCart');
  FirebaseFirestore.instance
  .collection('users')
  .doc(firebaseAuth.currentUser!.uid)
  .update({'userCart':emptyList}).then((value)
  {
    sharedPreferences!.setStringList('userCart', emptyList!);
    Provider.of<CartItemCounter>(context,listen: false).displayCartListItemNumber();
  }
  );


}
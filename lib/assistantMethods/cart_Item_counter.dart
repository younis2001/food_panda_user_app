import 'package:flutter/cupertino.dart';
import 'package:foodpanda_users_app/globel/globel.dart';

class CartItemCounter extends ChangeNotifier
{
  int cartListItemCounter=sharedPreferences!.getStringList('userCart')!.length-1;
  int get count =>cartListItemCounter;
  Future<void> displayCartListItemNumber()async{

    cartListItemCounter=sharedPreferences!.getStringList('userCart')!.length-1;

  await Future.delayed(Duration(milliseconds: 100),()
  {
    notifyListeners();
  }

  );

  }
}
import 'package:flutter/cupertino.dart';
class TotalAmount extends ChangeNotifier
{
  double _totalAmount=0;
  double get tAmount =>_totalAmount;
  displayTotalAmount(double n)async
  {
    _totalAmount=n;
    await Future.delayed(Duration(milliseconds: 100),(){
notifyListeners();
    });
  }
}
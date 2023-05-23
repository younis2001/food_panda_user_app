import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/items.dart';
class CartItemDesign extends StatefulWidget {
final Items? model;
BuildContext? context;
final int? quanNumber;

  CartItemDesign({
    this.model,
    this.quanNumber,
  this.context
  });

  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(widget.model!.thumbnailUrl!,width: 140,height: 120,),
              const SizedBox(height: 6,),
              Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model!.title!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Kiwi'
                    ),
                  ),
                  const SizedBox(height: 1,),
                  Row(
                    children: [
                      Text(
                        'x',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Acme',

                      ),
                      ),
                      Text(
                        widget.quanNumber.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Acme',

                        ),
                      ),

                    ],
                  ),
                  Row(children: [
                    Text(
                      'price',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      '€',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                      ),
                    ),
                    Text(
                      widget.model!.price.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue
                      ),
                    ),
                  ],)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';
import 'package:foodpanda_users_app/mainScreens/placed_order_screen.dart';
import 'package:foodpanda_users_app/maps/maps.dart';
import 'package:foodpanda_users_app/models/address.dart';
import 'package:provider/provider.dart';
class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final double? totalAmount;
final String? sellerUID;
final String? addressID;
  AddressDesign({
    this.model,
    this.currentIndex,this.value
    ,this.totalAmount,this.sellerUID
    ,this.addressID
});
  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
Provider.of<AddressChanger>(context,listen: false).displayResult(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                    value: widget.value,
                    groupValue: widget.currentIndex,
                    onChanged: (val)
                {
                  Provider.of<AddressChanger>(context,listen: false).displayResult(val);

                  print(val);
                }
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                        child: Table(
                          children: [
                            TableRow(
                              children:[
                                Text('Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                Text(widget.model!.name.toString()),
                              ]
                            ),
                            TableRow(
                                children:[
                                  Text('phone Number',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  Text(widget.model!.phoneNumber.toString()),
                                ]
                            ),
                            TableRow(
                                children:[
                                  Text('Flat Number',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  Text(widget.model!.flatNumber.toString()),
                                ]
                            ),
                            TableRow(
                                children:[
                                  Text('City',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  Text(widget.model!.city.toString()),
                                ]
                            ),
                            TableRow(
                                children:[
                                  Text('State',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  Text(widget.model!.state.toString()),
                                ]
                            ),
                            TableRow(
                                children:[
                                  Text('Full Address',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  Text(widget.model!.fullAddress.toString()),
                                ]
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  MapsUtils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);
                  // MapsUtils.openMapWithAddress(widget.model!.fullAddress!);
                },
                child: Text('Check on Map'),
            style: ElevatedButton.styleFrom(
              primary: Colors.black54
            ),),
            widget.value == Provider.of<AddressChanger>(context).count
            ? ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>PlacedOrderScreen(
                addressID:widget.addressID,
                totalAmount:widget.totalAmount,
                sellerUID:widget.sellerUID,
              )));
            },
                child: Text('proceed',),style: ElevatedButton.styleFrom(primary: Colors.green),)
                :Container()
          ],
        ),
      ),
    );
  }
}

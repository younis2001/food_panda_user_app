import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/globel/globel.dart';
import 'package:foodpanda_users_app/models/address.dart';
import 'package:foodpanda_users_app/widgets/text_field.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SaveAddressScreen extends StatelessWidget {

final _name= TextEditingController();
final _phoneController= TextEditingController();
final _flatNumber= TextEditingController();
final _city= TextEditingController();
final _state= TextEditingController();
final _completeAddress= TextEditingController();
final _locationController= TextEditingController();
final formKey = GlobalKey<FormState>();
List<Placemark>? placemarks;
Position? position;
getUserLocationAddress()async
{
  Position newPosition =await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );
  position=newPosition;
  placemarks=await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude);
  Placemark pMark=placemarks![0];
  String fullAddress= '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode},${pMark.country}';
_flatNumber.text='${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
_city.text='${pMark.subAdministrativeArea} ${pMark.administrativeArea}';
_state.text='${pMark.country}';
_completeAddress.text=fullAddress;
  _locationController.text=fullAddress;

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        if(formKey.currentState!.validate())
          {
            final model =Address(
              name: _name.text.trim(),
              state: _state.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              phoneNumber: _phoneController.text.trim(),
              flatNumber: _flatNumber.text.trim(),
              city: _city.text.trim(),
              lat:position!.latitude,
              lng: position!.longitude
            ).toJson();
            FirebaseFirestore.instance
            .collection('users')
            .doc(sharedPreferences!.getString('uid'))
            .collection('userAddress')
            .doc(DateTime.now().millisecondsSinceEpoch.toString())
            .set(model).then((value) {

              Fluttertoast.showToast(msg: 'New Address has been saved.');
              formKey.currentState!.reset();
            });
          }
      },
          label:Text('Save Now'),
      icon:Icon(Icons.save) ,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text('Save Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,fontWeight: FontWeight.bold,

                ),),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_pin_circle,
              color: Colors.black,
              size: 35,)
              ,title: Container(
              width: 250,
             child: TextField(
               style: TextStyle(
                 color: Colors.black,
               ),
               controller: _locationController,
               decoration: InputDecoration(
                 hintText: "What's your address",
                 hintStyle: TextStyle(
                   color: Colors.black
                 ),

               ),
             ),
            ),
            ),
            SizedBox(height: 6,),
            ElevatedButton.icon(
                onPressed: (){
                  getUserLocationAddress();
                },
                icon: Icon(Icons.location_on,color: Colors.white,),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.cyan),
                  ))
                ),
                label: Text('Get my Location',style: TextStyle(color: Colors.white),)),
            Form(
                key: formKey,
                child: Column(
              children: [
                MyTextField(
                  hint: "name",
                  controller: _name,
                ),
                MyTextField(
                  hint: "Phone Number",
                  controller: _phoneController,
                ),
                MyTextField(
                  hint: "city",
                  controller: _city,
                ),
                MyTextField(
                  hint: "State / Country",
                  controller: _state,
                ),
                MyTextField(
                  hint: "Address Line",
                  controller: _flatNumber,
                ),
                MyTextField(
                  hint: "Complete Address",
                  controller: _completeAddress,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

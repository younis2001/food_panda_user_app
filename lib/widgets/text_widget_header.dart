import 'package:flutter/material.dart';
class TextWidgetHeader extends SliverPersistentHeaderDelegate {
  String? title;
  TextWidgetHeader({this.title});
  @override
  Widget build(BuildContext context,double shrinkOffset, bool overlapsContent)
  {


    return InkWell(
      child:
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:[
                  Colors.cyan,
                  Colors.amber,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
            )
        ),
        height: 80,
        width: MediaQuery.of(context).size.width,
        child:InkWell(
          child:  Center(
            child: Text(
              title!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Signatra',
                  fontSize: 30,
                  letterSpacing: 2,color: Colors.white),),
          ),
        ) ,
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate)=>true;
}

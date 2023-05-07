import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:variable/components/colours.dart';
import 'package:variable/components/popup_toAdd.dart';

final s='Variable';
class HomeScreen2 extends StatefulWidget {
  final DataSnapshot querySnapshot;

  HomeScreen2({Key key, @required this.querySnapshot}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {



  final FirebaseDatabase database = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    final sheight= MediaQuery.of(context).size.height;
    final swidth= MediaQuery.of(context).size.width;
    final ref= database.reference();
    bool thatThingHappened = true;
     final DataSnapshot x= widget.querySnapshot;
    // double w=widget.querySnapshot.value['CurrentVal'].toDouble();
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body:Center(
          child: Stack(
              children: <Widget>[
                  Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg.png'),
                          fit: BoxFit.cover)
                  ),
                ),

                    Container(
                    margin: const EdgeInsets.only(

                    left: 40,
                    right: 40
                ),
   child:

      Column(

        children: <Widget>[
          Flexible(

    child: FirebaseAnimatedList(
    query: ref.child('variableApp'),
    itemBuilder: (BuildContext context,DataSnapshot z,
    Animation<double> animation, int index) {
    // z=x;
      if(z.value['ProductKey']==x.value['ProductKey']){
        checkagain:
    double w=(z.value['CurrentVal'] is String)?double.parse(z.value['CurrentVal']):z.value['CurrentVal'];
    double w2=(z.value['threshold'] is String)?double.parse(z.value['threshold']):z.value['threshold'];
    double maxCap=(z.value['MaxCap'] is String)?double.parse(z.value['MaxCap']):z.value['MaxCap'];
    // if(thatThingHappened){
    //   thatThingHappened = false;
    return new
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset('assets/images/VA.png', height: sheight/6,width: swidth/6),

    Stack(
    children: <Widget>[
    Image.asset('assets/images/boxi.png', height: sheight/1.65,width: swidth/1.65),
    Positioned.fill(
    child: Align(
    alignment: Alignment.bottomCenter,
    child:Padding(
    padding: const EdgeInsets.only(left: 0,bottom: 42.0),
    child: AnimatedContainer(
    duration:Duration(milliseconds:400),
    height: ((sheight/2.75)*w/maxCap)>=0?((sheight/2.75)*w/maxCap):4, //300 is full and container cap is 10kg
    width: swidth/1.15,
    child: DecoratedBox(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(26),bottomLeft: Radius.circular(26)),
    color:
        w<w2? Colours.red:Colours.notSoBlack,
    ),
    ),
    ),
    ),
    ),
    ),
    ]
    ),
      Text(z.value['Product'],
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
      )),
    Text(w>=0?((w is String)?w.toString():w.toStringAsFixed(3))+" Kg":"0 Kg",
      style: TextStyle(fontSize: 20,
      )
    ),

    ],

    );
    }
      else{
        z=x;
        double w=(z.value['CurrentVal'] is String)?double.parse(z.value['CurrentVal']):z.value['CurrentVal'];
        double w2=(z.value['threshold'] is String)?double.parse(z.value['threshold']):z.value['threshold'];
        double maxCap=(z.value['MaxCap'] is String)?double.parse(z.value['MaxCap']):z.value['MaxCap'];
        // if(thatThingHappened){
        //   thatThingHappened = false;
        return new
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/VA.png', height: sheight/6,width: swidth/6),

            Stack(
                children: <Widget>[
                  Image.asset('assets/images/box.png', height: sheight/1.65,width: swidth/1.65),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child:Padding(
                        padding: const EdgeInsets.only(left: 7,bottom: 67.0),
                        child: AnimatedContainer(
                          duration:Duration(milliseconds:400),
                          height: ((sheight/2.75)*w/maxCap)>=0?((sheight/2.75)*w/maxCap):4, //300 is full and container cap is 10kg
                          width: swidth/2.27,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6)),
                              color:
                              w<w2? Colours.red:Colours.notSoBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            Text(z.value['Product'],
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
                )),
            Text(w>=0?((w is String)?w.toString():w.toStringAsFixed(3))+" Kg":"0 Kg",
                style: TextStyle(fontSize: 20,
                )
            ),

          ],

        );
        // continue checkagain;
      }
    //
     }
    )
    ),
          Padding(
            padding: EdgeInsets.only(top: 0.0,bottom: 10.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  color: Colours.totallyTransparent,
                  child: InkWell(
                    // onTap: () => homePage,

                    child: Column(

                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => buildPopupDialog(context),
                            );
                          },
                          elevation: 2.0,
                          fillColor: Color(0xff105656),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 34.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        )

                      ],
                    ),

                  ),
                )
            ),
          ),
        ]
      )
        ),
              ],
          )
        ),
      // bottomNavigationBar:

    );
  }
}




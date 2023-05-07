import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:variable/components/colours.dart';
import 'package:variable/components/popup_toAdd.dart';
import 'product_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class listofContainers extends StatefulWidget {
  final String username;
  listofContainers({Key key, @required this.username}) : super(key: key);
  @override
  _listofContainersState createState() => _listofContainersState();
}

class _listofContainersState extends State<listofContainers> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/logo');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Some container is getting empty"),
          content: Text("Your $payload is about to end"),
        );
      },
    );
  }
  final FirebaseDatabase database = FirebaseDatabase.instance;


  @override
  Widget build(BuildContext context) {

    final ref= database.reference();
    return Scaffold(
      resizeToAvoidBottomInset: true,
    resizeToAvoidBottomPadding: false,
    body:Center(

    child:
    Stack(
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
    top: 35.0,
      left: 40,
      right: 40
    ),
    child:Column(

    children: <Widget>[
      Image.asset('assets/images/VA.png', height: 60,width: 60),
      SizedBox(
          height: 10.0,
          width: 20.45),

        Flexible(
          child: FirebaseAnimatedList(query: ref.child('variableApp'),
    itemBuilder: (BuildContext context, DataSnapshot snapshot,
    Animation<double> animation, int index) {
      Future _showNotification() async {
        var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.high,
            priority: Priority.high);
        var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
        var platformChannelSpecifics = new NotificationDetails(
            android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Alert',
          'Your '+snapshot.value['Product']+' is about to end',
          platformChannelSpecifics,
          payload: snapshot.value['Product'],
        );
      }
      double w=(snapshot.value['CurrentVal'] is String)?double.parse(snapshot.value['CurrentVal']):snapshot.value['CurrentVal'];
      double w2=(snapshot.value['threshold'] is String)?double.parse(snapshot.value['threshold']):snapshot.value['threshold'];
      if(w<w2){
    Future.delayed(const Duration(minutes: 3), () {
    if(w<w2) {
      _showNotification();
    }
    });
      }
    return  Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: new Container(
          padding: new EdgeInsets.only(top: 30,),
          margin: new EdgeInsets.only(bottom: 20,),
          height: 160,
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/line.png"),
        fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(14)),
                boxShadow: [new BoxShadow(
                  color: Colours.notSoBlack,
                  blurRadius: 9.0,
                ),]
            ),


   child: ListTile(

          title: Text(snapshot.value['Product'],
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,

                // color: Colors.white
            ),
          ),
        trailing:
        Image.asset('assets/images/rice.png', height: 120,width: 120),

          subtitle: Container(
              padding: new EdgeInsets.only(top: 30,),
      child: Text(((snapshot.value['CurrentVal'] is String)?snapshot.value['CurrentVal']:snapshot.value['CurrentVal'].toStringAsFixed(3))+"Kg /"+snapshot.value['MaxCap']+"Kg"),
          ),
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(

              builder: (context) => HomeScreen2( querySnapshot: snapshot),
            ),
          );
        },
      ),



      ),

      secondaryActions: <Widget>[

        IconSlideAction(

          color: Colours.red,
          icon: Icons.delete,
          onTap: () =>ref.child('variableApp').child(snapshot.key).remove(),
        ),
      ],

    );
    }
        ),
      // child:Text(
      //   "Welcome "+widget.username
      // ),

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
                  fillColor: Colours.darkBlue,
                  child: Icon(
                    Icons.add,
                    color: Colours.pureWhite,
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


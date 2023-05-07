import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:variable/all_containers.dart';
import 'package:variable/login_page.dart';

bool isExpanded = false;
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'variable',
    routes: routes,
    home: SplashScreen(),
  ));
}
class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    final User firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser.reload();
    _user = await _auth.currentUser;
    // get User authentication status here
  }

  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null) {
      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    listofContainers(username: _auth.currentUser.displayName)),
                (Route<dynamic> route) => false),
      );
    } else {
      Timer(Duration(seconds: 4),
              () => Navigator.pushReplacementNamed(context, "/auth"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final sheight= MediaQuery.of(context).size.height;
    final swidth= MediaQuery.of(context).size.width;
    Future.delayed(const Duration(milliseconds: 3000), () {

      setState(() {
        isExpanded = !isExpanded;
      });

    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  Center(
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
        Align(
                        alignment: Alignment.bottomCenter,
                       child:Padding(
                          padding: const EdgeInsets.only(right: 5,bottom: 430.0),
             // child: AnimatedContainer(
                child: Image.asset('assets/images/VA.png', height: sheight/3,width: swidth/3),
         //        duration:Duration(milliseconds:2000),
         //        curve: Curves.linear,
         //        height: isExpanded ? sheight/3 : sheight/6.10, //300 is full and container cap is 10kg
         //        width: isExpanded?swidth/3:swidth/6.10,
         // )
                       ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child:
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Stack(
//                   children: <Widget>[
//
//                     Image.asset('assets/images/box.png', height:h/3,width: w/2.5),
//                     Positioned.fill(
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child:Padding(
//                           padding: const EdgeInsets.only(right: 5,bottom: 30.0),
//                           child: AnimatedContainer(
//                             duration:Duration(milliseconds:2000),
//                             curve: Curves.bounceOut,
//                             height: isExpanded ? 300 : 30, //300 is full and container cap is 10kg
//                             width: 153.5,
//                             child: DecoratedBox(
//
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(bottomRight:  Radius.circular(6),bottomLeft:  Radius.circular(6)),
//                                   color: isExpanded ? Colors.redAccent:Colors.black54
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]
//               ),
//
//               Text("variable",
//                   style: TextStyle(fontSize: 36)),
//
//             ],
//           ),
//         ),
//         ),
//       );
//   }
// }
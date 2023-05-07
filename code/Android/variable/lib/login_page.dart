import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:variable/all_containers.dart';
import 'package:variable/components/colours.dart';


String name;
String email;
String imageUrl;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {


  bool isVisible = false;
  Future<User> _signIn() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    User user = (await auth.signInWithCredential(credential)).user;
    if (user != null) {
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
      var swidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
             Container(
               margin: const EdgeInsets.only(
                 top: 160.0,
               ),
               child: Align(
                 alignment: Alignment.topCenter,
               child:Column(

                   children: <Widget>[

               Image.asset('assets/images/boxes.png', height: 220,width: 220),
                     SizedBox(
                         height: 30.0,
                         width: 20.45),
                     Text("An app that helps",
                       style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)
                     ),
                     Text("you store smart",
                         style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)
                     ),
                     SizedBox(
                         height: 20.0,
                         width: 20.45),
                     Text("Variable helps you display the weight of",
                         style:TextStyle(fontSize: 16,color: Colours.notSoBlack)
                     ),
                     Text("the material stored in a container",
                         style:TextStyle(fontSize: 16,color: Colours.notSoBlack)
                     ),
              ]
               ),
               ),
             ),

             Container(
                padding: const EdgeInsets.only(
                  bottom: 80.0,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 54.0,
                    width: swidth / 1.45,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          this.isVisible = true;
                        });
                        _signIn().whenComplete(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => listofContainers(username: name)),
                                  (Route<dynamic> route) => false);
                        }).catchError((onError) {
                          Navigator.pushReplacementNamed(context, "/auth");
                        });
                      },
                      child: Row(
                      children:<Widget>[
                      Image.asset('assets/images/goo.png', height: 38,width: 38),
                      SizedBox(
                        height: 30.0,
                        width: 20.45),
                      Text(
                        ' Continue with google',
                        style: TextStyle(fontSize: 16,
                          color: Colours.pureWhite
                        ),
                      ),
                      ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                      ),
                      elevation: 5,
                      color: Colours.darkBlue,
                    ),
                  ),
                ),
              ),

            ],
          ),


      ),

    );
  }
}
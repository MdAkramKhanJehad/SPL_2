import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shared/shared_objects.dart';
import 'shared/shared_functions.dart';
final SharedFunctions sharedFunctionsGlobal = new SharedFunctions();
final SharedObjects sharedObjectsGlobal = new SharedObjects();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          sharedFunctionsGlobal.getMobileHeightWeight(constraints);
          return MaterialApp(
            title: 'Agri Pro',
            theme: ThemeData(
              fontFamily: 'Mina',
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          );
        }
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          sharedFunctionsGlobal.getMainPageBackgroundImage(),
          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>AnotherClass()));
              },
              child: Container(
                child: Text("Hello"),
              ),
            ),
          ),
        ],
      )
    );
  }
}

class AnotherClass extends StatefulWidget {
  const AnotherClass({Key? key}) : super(key: key);

  @override
  _AnotherClassState createState() => _AnotherClassState();
}

class _AnotherClassState extends State<AnotherClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Another Class"),
      ),
      body: Center(
        child: Container(
          child: Text("Another Class"),
        ),
      ),
    );
  }
}


class SizeConfig{
  void init(BoxConstraints constraints ){
    print(constraints.maxHeight);
    print(constraints.maxWidth);
    print("------------------------------");

  }
}

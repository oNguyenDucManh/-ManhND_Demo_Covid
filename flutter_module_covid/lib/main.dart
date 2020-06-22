import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'HomePage.dart';
import 'detailPage.dart';

const CHANNEL = "com.manhnd.covid";
const PlatformChannel = const MethodChannel(CHANNEL);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        if (settings.name == "/DetailPage") {
          String name = "";
          if (settings.arguments != null) {
            name = settings.arguments;
          }
          return MaterialPageRoute(builder: (context) {
            return DetailPage(
              title: name,
            );
          });
        } else {
          return MaterialPageRoute(
            builder: (context) {
              return RootPage();
            },
          );
        }
      },
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RootState();
  }
}

class RootState extends State<RootPage> {
  Widget currentPage = MyHomePage();

  @override
  void initState() {
    super.initState();
    PlatformChannel.setMethodCallHandler(_handleFromNative);
  }

  @override
  Widget build(BuildContext context) {
    return currentPage;
  }

  Future<dynamic> _handleFromNative(MethodCall call) async {
    if (call.method == "gotoPage") {
      if (call.arguments != null) {
        switch (call.arguments) {
          case "DetailPage":
            String country = await _getCountryFromNative();
            print("country: " + country);
            setState(() {
              currentPage = DetailPage(title: country);
            });
            break;
          default:
            setState(() {
              currentPage = MyHomePage();
            });
            break;
        }
      } else {
        setState(() {
          currentPage = MyHomePage();
        });
      }
    } else {
      print("No method call");
    }
  }

  Future<String> _getCountryFromNative() async {
    String param;
    try {
      final String result =
          await PlatformChannel.invokeMethod('getParamCountry');
      param = result;
      print(param);
      return param;
    } on PlatformException catch (e) {
      param = "Failed to get param: '${e.message}'";
      print(param);
      throw e;
    }
  }
}

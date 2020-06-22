import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterappcovid/detailPage.dart';
import 'package:flutterappcovid/model/CountriesResponse.dart';
import 'package:flutterappcovid/network/Config.dart';
import 'package:http/http.dart' as http;

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Country> _list = List();
  List<Country> _listBackup = List();
  TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchListCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _filterController,
              onChanged: (value) {
                _search();
              },
              decoration: InputDecoration(hintText: "Search"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
//                  return Text(_list[index].name);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  title: _list[index].name,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      _list[index].name ?? "",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _list[index].iso2 ?? "",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              itemCount: _list.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchListCountries() async {
    final response = await http.get(COUNTRIES);
    print(response.body);
    if (response.statusCode == 200) {
      CountriesResponse countriesResponse =
          CountriesResponse.fromJson(json.decode(response.body));
      if (countriesResponse.countries.isNotEmpty) {
        setState(() {
          _list = countriesResponse.countries;
          _listBackup = countriesResponse.countries;
        });
      }
    } else {
      print("Error Fetch List Countries");
    }
  }

  _search() {
    print(_filterController.text);
    List<Country> _listTemp = List();
    if (_listBackup.isNotEmpty) {
      for (int i = 0; i < _listBackup.length; i++) {
        if (_listBackup[i]
            .name
            .toLowerCase()
            .contains(_filterController.text.toLowerCase())) {
          _listTemp.add(_listBackup[i]);
        }
      }
      setState(() {
        _list = _listTemp;
      });
    }
  }
}

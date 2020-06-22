import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcovid/model/DetailResponse.dart';
import 'package:flutterappcovid/network/Config.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String title;

  const DetailPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {
  DetailResponse _detailResponse;
  String name;

  @override
  void initState() {
    super.initState();
    name = widget.title;
    _detailResponse = DetailResponse();
    _fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              child: ListTile(
                title: Text("Số ca nhiễm"),
                subtitle: Text(
                    "${_detailResponse.confirmed == null ? "" : _detailResponse.confirmed.value ?? ""}"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              elevation: 8,
              child: ListTile(
                title: Text("Số ca khỏi"),
                subtitle: Text("${_detailResponse.recovered == null ? "" : _detailResponse.confirmed.value ?? ""}"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              elevation: 8,
              child: ListTile(
                title: Text("Số ca tử vong"),
                subtitle: Text("${_detailResponse.deaths == null ? "" : _detailResponse.confirmed.value ?? ""}"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
    );
  }

  _fetchDetail() async {
    final response = await http.get(DETAIL_COUNTRY(name));
    if (response.statusCode == 200) {
      setState(() {
        _detailResponse = DetailResponse.fromJson(json.decode(response.body));
      });
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodulecovid/main.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'model/DetailResponse.dart';
import 'network/Config.dart';

class DetailPage extends StatefulWidget {
  final String title;

  const DetailPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {
  String name;
  ProgressDialog _progressDialog;
  int confirmed;
  int recovered;
  int deaths;

  @override
  void initState() {
    super.initState();
    name = widget.title ?? "";
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 8,
                child: ListTile(
                  title: Text("Số ca nhiễm"),
                  subtitle: Text("${confirmed ?? ""}"),
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
                  subtitle: Text("${recovered ?? ""}"),
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
                  subtitle: Text("${deaths ?? ""}"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              FlatButton(
                child: Text("Send To Native"),
                color: Colors.blue,
                onPressed: () {
                  PlatformChannel.invokeMethod(
                      "GotoSecondPageNative", <String, dynamic>{
                    'confirmed': confirmed,
                    'recovered': recovered,
                    'deaths': deaths,
                  });
                },
              ),
              FlatButton(
                child: Text("Exit"),
                color: Colors.blue,
                onPressed: () {
                  PlatformChannel.invokeMethod("exitFlutter");
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _fetchDetail() async {
    await _progressDialog.show();
    final response = await http.get(DETAIL_COUNTRY(name));
    print(response.body);
    _progressDialog.hide();
    if (response.statusCode == 200) {
      var _detailResponse = DetailResponse.fromJson(json.decode(response.body));
      setState(() {
        confirmed = _detailResponse.confirmed.value;
        recovered = _detailResponse.recovered.value;
        deaths = _detailResponse.deaths.value;
      });
    }
  }
}

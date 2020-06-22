class DetailResponse {
  String lastUpdate;
  Detail confirmed = Detail();
  Detail deaths = Detail();
  Detail recovered = Detail();

  DetailResponse({this.lastUpdate, this.confirmed, this.deaths, this.recovered});

  DetailResponse.fromJson(Map<String, dynamic> json) {    
    this.lastUpdate = json['lastUpdate'];
    this.confirmed = json['confirmed'] != null ? Detail.fromJson(json['confirmed']) : Detail();
    this.deaths = json['deaths'] != null ? Detail.fromJson(json['deaths']) : Detail();
    this.recovered = json['recovered'] != null ? Detail.fromJson(json['recovered']) : Detail();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdate'] = this.lastUpdate;
    if (this.confirmed != null) {
      data['confirmed'] = this.confirmed.toJson();
    }
    if (this.deaths != null) {
      data['deaths'] = this.deaths.toJson();
    }
    if (this.recovered != null) {
      data['recovered'] = this.recovered.toJson();
    }
    return data;
  }

}

class Detail {
  String detail = "";
  int value = 0;

  Detail({this.detail, this.value});

  Detail.fromJson(Map<String, dynamic> json) {
    this.detail = json['detail'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['value'] = this.value;
    return data;
  }
}
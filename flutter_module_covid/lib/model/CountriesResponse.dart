class CountriesResponse {
  List<Country> countries;

  CountriesResponse({this.countries});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    this.countries = (json['countries'] as List) != null
        ? (json['countries'] as List).map((i) => Country.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countries'] = this.countries != null
        ? this.countries.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class Country {
  String name;
  String iso2;
  String iso3;

  Country({this.name, this.iso2, this.iso3});

  Country.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.iso2 = json['iso2'];
    this.iso3 = json['iso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    return data;
  }
}

const END_POINT = "https://covid19.mathdro.id/api/";

const COUNTRIES = "${END_POINT}countries";

String DETAIL_COUNTRY(var countryName) {
  return "$COUNTRIES/$countryName";
}

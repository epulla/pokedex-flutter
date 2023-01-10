import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

UrlData parseToUrlData(Map<String, dynamic> json) {
  return UrlData(
    name: json["name"] ?? "",
    url: json["url"],
  );
}

List<UrlData> parseToUrlDataList(List<dynamic> json, {String subkey = ""}) {
  List<UrlData> urlDataList = [];
  for (var obj in json) {
    var extractedObj = subkey == "" ? obj : obj[subkey];
    urlDataList.add(parseToUrlData(extractedObj as Map<String, dynamic>));
  }
  return urlDataList;
}

import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

UrlData parseToUrlData(Map<String, dynamic> json) {
  return UrlData(
    name: json['name'],
    url: json['url'],
  );
}

List<UrlData> parseToUrlDataList(List<dynamic> json) {
  List<UrlData> urlDataList = [];
  for (var obj in json) {
    urlDataList.add(parseToUrlData(obj as Map<String, dynamic>));
  }
  return urlDataList;
}

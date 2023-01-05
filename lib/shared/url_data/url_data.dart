class UrlData {
  final String name;
  final String url;

  const UrlData({
    required this.name,
    required this.url,
  });

  @override
  String toString() {
    return "UrlData(name=$name,url=$url)";
  }
}

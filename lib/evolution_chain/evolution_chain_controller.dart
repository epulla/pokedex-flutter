import 'package:fulltimeforce_test/shared/url_data/url_data.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

List<UrlData> getAllEvolutionChain(Map<String, dynamic> json) {
  return _getAllEvolutionChainRecursive(json['chain']);
}

List<UrlData> _getAllEvolutionChainRecursive(Map<String, dynamic> json) {
  if (json['evolves_to'].length == 0) {
    return [];
  }
  return [parseToUrlData(json['species'])] +
      _getAllEvolutionChainRecursive(json['evolves_to'][0]);
}

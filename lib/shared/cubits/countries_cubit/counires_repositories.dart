import 'package:mimic/models/global_models/countries_model/country_model.dart';

class CountriesRepository {
  CountriesRepository({
    required this.status,
    required this.countries,
  });
  late final bool status;
  late final List<Country> countries;

  CountriesRepository.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    countries =
        List.from(json['countries']).map((e) => Country.fromJson(e)).toList();
  }
}

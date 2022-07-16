import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/global_models/countries_model/city_model.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/helpers/error_handling/error_handler.dart';
import 'package:mimic/shared/helpers/error_handling/failure_model.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

import 'counires_repositories.dart';

part 'countries_cubit_state.dart';

class CountriesCubit extends Cubit<CountriesCubitState> {
  CountriesCubit() : super(CountriesCubitInitial());
  static CountriesCubit get(context) => BlocProvider.of(context);
  late CountriesRepository countriesRepository;
  final ErrorHandler _errorHandler = ErrorHandler();
  Map<int, List<City>> cities = {};
  String? selectedCity = CacheHelper.getDate(key: ValuesManager.cityKey);
  String? selctedCountry = CacheHelper.getDate(key: ValuesManager.countryKey);
  Future<void> getAllCountries() async {
    emit(CountriesCubitLoading());
    try {
      if (await checkInternetConnecation()) {
        final response =
            await HandlingApis.getData(url: ConstantHelper.countriesUrl);
        log(response.data.toString());
        if (response.data['status']) {
          countriesRepository = CountriesRepository.fromJson(response.data);
          if (selctedCountry != null) {
            getCities(selctedCountry!);
          } else {
            emit(CountriesCubitSuccess());
          }
        } else {
          emit(CountriesCubitError(Failure(
                  code: response.statusCode ?? 404,
                  message: response.statusMessage ?? '')
              .message));
        }
      } else {
        emit(CountriesCubitError(AppStrings.checkInternet));
      }
    } catch (e) {
      emit(CountriesCubitError(_errorHandler.getErrorHappen(e).message));
      throw e;
    }
  }

  // Future<void> getCounterOnly() async {
  //   emit(GetCounterLoading());
  //   try {
  //     final responseCounter = await HomeServices.getCounterValue();
  //     counter = responseCounter.data['counter'] ?? 0;
  //     emit(GetCounterSuccess());
  //   } catch (e) {
  //     emit(GetCounterError());
  //     throw e;
  //   }
  // }

  int? selectedCityId;
  int? selectedCountryId;
  Map<int, List<City>> getCities(String country) {
    selctedCountry = country;
    cities = {};
    for (int index = 0; index < countriesRepository.countries.length; index++) {
      if (countriesRepository.countries[index].name == country) {
        selectedCountryId = countriesRepository.countries[index].id;
        cities.addAll({
          countriesRepository.countries[index].id:
              countriesRepository.countries[index].cities
        });
        break;
      }
    }
    emit(CountriesCubitSuccess());
    return cities;
  }

  String getCountryCode(String country) {
    for (int index = 0; index < countriesRepository.countries.length; index++) {
      if (countriesRepository.countries[index].name == country) {
        log(countriesRepository.countries[index].key);
        return countriesRepository.countries[index].key.toUpperCase();
      }
    }
    return "-1";
  }

  void getCountryDetails(String city) {
    selectedCity = city;
  }

  int getCityId() {
    log(selectedCity.toString());
    for (var item in countriesRepository.countries
        .where((element) => element.id == selectedCountryId)
        .single
        .cities) {
      if (item.name == selectedCity) return item.id;
    }
    return -1;
  }
}

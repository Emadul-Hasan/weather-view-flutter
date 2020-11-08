import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '9401a336f76817297961bc8eb948f1a0';
const openWeatherMapBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getcurrentlocationweather() async {
    GetLocation getLocation = GetLocation();
    await getLocation.getcurrentlocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapBaseUrl?lat=${getLocation.latitube}&lon=${getLocation.longitude}&appid=$apikey');

    var weather = await networkHelper.getdatafromurl();
    return weather;
  }

  Future<dynamic> getcityweather(String city) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$openWeatherMapBaseUrl?q=$city&appid=$apikey');
    var weather = await networkHelper.getdatafromurl();
    return weather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

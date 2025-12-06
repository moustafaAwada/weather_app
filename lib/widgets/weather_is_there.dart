import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherIsThere extends StatelessWidget {
  WeatherIsThere({super.key});
  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel =
        BlocProvider.of<GetweatherCubit>(context).weatherModel!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getGradientByCondition(weatherModel.weahterCondition),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weatherModel.cityName,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'updated at ${weatherModel.date.hour} :${weatherModel.date.minute}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage('assets/images/cloudy.png')),
                  Text(
                    weatherModel.temp.round().toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Text('maxtemp:${weatherModel.maxTemp.round()}'),
                      Text('mintemp:${weatherModel.minTemp.round()}'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Text(
              weatherModel.weahterCondition,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

LinearGradient getGradientByCondition(String condition) {
  switch (condition) {
    case 'Sunny':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.orange.shade300, Colors.amber.shade600],
      );
    case 'Partly cloudy':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blueGrey.shade300, Colors.white70],
      );
    case 'Cloudy':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade600, Colors.grey.shade300],
      );
    case 'Overcast':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade700, Colors.grey.shade500],
      );
    case 'Mist':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blueGrey.shade100, Colors.white70],
      );
    case 'Patchy rain possible':
    case 'Patchy light rain':
    case 'Light rain':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue.shade300, Colors.blue.shade100],
      );
    case 'Moderate rain at times':
    case 'Moderate rain':
    case 'Heavy rain at times':
    case 'Heavy rain':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.indigo.shade400, Colors.blue.shade900],
      );
    case 'Patchy snow possible':
    case 'Light snow':
    case 'Moderate snow':
    case 'Heavy snow':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.lightBlue.shade100, Colors.cyan.shade200],
      );
    case 'Blizzard':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blueGrey.shade400, Colors.white],
      );
    case 'Thundery outbreaks possible':
    case 'Moderate or heavy rain with thunder':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.deepPurple.shade400, Colors.blueGrey.shade800],
      );
    case 'Fog':
    case 'Freezing fog':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade400, Colors.white],
      );
    case 'Light drizzle':
    case 'Patchy light drizzle':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.lightBlueAccent.shade100, Colors.blueGrey.shade200],
      );
    case 'Patchy sleet possible':
    case 'Light sleet':
    case 'Moderate or heavy sleet':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.teal.shade200, Colors.blueGrey.shade400],
      );
    case 'Patchy freezing drizzle possible':
    case 'Freezing drizzle':
    case 'Heavy freezing drizzle':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.indigo.shade300, Colors.blueGrey.shade500],
      );
    case 'Patchy light snow with thunder':
    case 'Moderate or heavy snow with thunder':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple.shade200, Colors.cyan.shade200],
      );
    default:
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade300, Colors.grey.shade500], // fallback
      );
  }
}

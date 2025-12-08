import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml if needed for formatting dates
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import '../cubits/auth_cubit/auth_cubit.dart'; 
import '../cubits/auth_cubit/auth_states.dart'; 
class WeatherIsThere extends StatelessWidget {
  const WeatherIsThere({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel =
        BlocProvider.of<GetweatherCubit>(context).weatherModel!;

    // Note: Removed Scaffold here because HomePage already has one.
    // We just return the scrollable content.
    return Container(
      decoration: BoxDecoration(
        gradient: getGradientByCondition(weatherModel.weahterCondition),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. Main Header Section ---
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      weatherModel.cityName,
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'Updated: ${DateFormat('h:mm a').format(weatherModel.date)}',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    // Weather Icon (Load from network URL)
                    if (weatherModel.image != null)
                      Image.network("https:${weatherModel.image!}", width: 100, height: 100),
                    Text(
                      '${weatherModel.temp.round()}°',
                      style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      weatherModel.weahterCondition,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('H: ${weatherModel.maxTemp.round()}°', style: TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 15),
                        Text('L: ${weatherModel.minTemp.round()}°', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 40),

              // --- 2. Hourly Forecast Section ---
              Text("Today's Forecast", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Container(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherModel.hourlyForecast.length,
                  itemBuilder: (context, index) {
                    final hour = weatherModel.hourlyForecast[index];
                    return Container(
                      width: 90,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), // Glass effect
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('j').format(hour.time), // e.g., 5 PM
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Image.network("https:${hour.icon}", width: 40, height: 40),
                          SizedBox(height: 8),
                          Text(
                            "${hour.temp.round()}°",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 30),

              // --- 3. 5-Day Forecast Section ---
              Text("5-Day Forecast", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // Glass container
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: weatherModel.dailyForecast.map((day) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Day Name (e.g., "Mon")
                          Expanded(
                            flex: 2,
                            child: Text(
                              DateFormat('EEEE').format(day.date),
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Icon
                          Expanded(
                            flex: 1,
                            child: Image.network("https:${day.icon}", width: 35, height: 35),
                          ),
                          // Min/Max
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${day.maxTemp.round()}°",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${day.minTemp.round()}°",
                                  style: TextStyle(color: Colors.white70, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherIsThereByUserCity extends StatelessWidget {
  final WeatherModel weather;

  const WeatherIsThereByUserCity({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<AuthCubit>().state;
    final userCity = (userState is AuthAuthenticated) ? userState.user.city : null;

    return Container(
      decoration: BoxDecoration(
        gradient: getGradientByCondition(weather.weahterCondition),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      userCity ?? weather.cityName,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'Updated: ${DateFormat('h:mm a').format(weather.date)}',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    if (weather.image != null)
                      Image.network("https:${weather.image!}", width: 100, height: 100),
                    Text(
                      '${weather.temp.round()}°',
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      weather.weahterCondition,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('H: ${weather.maxTemp.round()}°',
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 15),
                        Text('L: ${weather.minTemp.round()}°',
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              // Hourly Forecast
              Text("Today's Forecast",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Container(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weather.hourlyForecast.length,
                  itemBuilder: (context, index) {
                    final hour = weather.hourlyForecast[index];
                    return Container(
                      width: 90,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('j').format(hour.time),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Image.network("https:${hour.icon}", width: 40, height: 40),
                          SizedBox(height: 8),
                          Text(
                            "${hour.temp.round()}°",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 30),

              // 5-Day Forecast
              Text("5-Day Forecast",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: weather.dailyForecast.map((day) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              DateFormat('EEEE').format(day.date),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.network(
                              "https:${day.icon}",
                              width: 35,
                              height: 35,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${day.maxTemp.round()}°",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${day.minTemp.round()}°",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



// class WeatherIsThereByUserCity extends StatelessWidget {
//   final WeatherModel weather;

//   const WeatherIsThereByUserCity({super.key, required this.weather});

//   @override
//   Widget build(BuildContext context) {
//     // هنا استخدم weather مباشرة
//     final user = (context.watch<AuthCubit>().state as AuthAuthenticated).user;

//     return Container(
//       decoration: BoxDecoration(
//         gradient: getGradientByCondition(weather.weahterCondition),
//       ),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       user.city ?? weather.cityName,
//                       style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     Text(
//                       'Updated: ${DateFormat('h:mm a').format(weather.date)}',
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                     // باقي محتوى الطقس...
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// Keep your existing Gradient Logic
LinearGradient getGradientByCondition(String condition) {
  // ... (Paste your existing Switch Case logic here exactly as it was) ...
  // For brevity, I am using a simple default, but YOU should keep your long switch case list.
  
   switch (condition) {
    case 'Sunny':
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.orange.shade300, Colors.amber.shade600],
      );
    // ... ADD ALL YOUR OTHER CASES HERE ...
    default:
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue.shade800, Colors.blue.shade300], 
      );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search a City')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            onSubmitted: (cityName) async {
              var getweahtercubit = BlocProvider.of<GetweatherCubit>(context);
              getweahtercubit.getWeather(cityName: cityName);
              Navigator.of(context).pop();
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 25,
              ),
              suffixIcon: Icon(Icons.search),
              labelText: 'Search',
              hintText: 'Enter City Name',
              border: OutlineInputBorder(borderSide: BorderSide()),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

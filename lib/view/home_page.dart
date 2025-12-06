import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/view/search_view.dart';
import 'package:weather_app/widgets/weather_empty.dart';
import 'package:weather_app/widgets/weather_is_there.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('WTHEAR APP', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(flex: 1),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchView();
                    },
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      body: BlocBuilder<GetweatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is InitialState) {
            return WeatherEmpty();
          } else if (state is WeatherLoadedState) {
            return WeatherIsThere();
          } else {
            return Text('oops there was an error , please try later');
          }
        },
      ),
    );
  }
}

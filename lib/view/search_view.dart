import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/services/weather_service.dart'; // Import your service

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textController = TextEditingController();
  
  Timer? _debounce;
  
  List<dynamic> _suggestions = [];
  bool _isLoading = false;

  // inside lib/view/search_view.dart

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      
      if (query.isNotEmpty) { 
        setState(() {
          _isLoading = true;
        });

        try {
          var results = await WeatherService(Dio()).getCitySuggestions(query);
          setState(() {
            _suggestions = results;
            _isLoading = false;
          });
        } catch (e) {
           setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _suggestions = [];
          _isLoading = false;
        });
      }
    });
  }

  void _submitSearch(String cityName) {
    var getweahtercubit = BlocProvider.of<GetweatherCubit>(context);
    getweahtercubit.getWeather(cityName: cityName);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Search City', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade300],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Search Icon Graphic
              Icon(Icons.location_city, size: 80, color: Colors.white70),
              SizedBox(height: 20),
              Text(
                "Find Your Weather",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 30),

              Container(
                constraints: BoxConstraints(maxHeight: 400), // Limit max height
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 100),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Shrink to fit content
                  children: [
                    // Input Field
                    TextField(
                      controller: _textController,
                      onChanged: _onSearchChanged, // Listen to typing
                      onSubmitted: _submitSearch,  // Listen to Enter key
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        suffixIcon: Container(
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _isLoading 
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Icon(Icons.search, color: Colors.white),
                        ),
                        labelText: 'City Name',
                        hintText: 'e.g. London, New York',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                    
                    // The Dropdown List
                    if (_suggestions.isNotEmpty) ...[
                      SizedBox(height: 10),
                      Divider(),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _suggestions.length,
                          itemBuilder: (context, index) {
                            final location = _suggestions[index];
                            final name = location['name'];
                            final region = location['region'];
                            final country = location['country'];

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.place, color: Colors.orange),
                              title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("$region, $country"),
                              onTap: () {
                                _textController.text = name; // Fill text
                                _submitSearch(name); // Search immediately
                              },
                            );
                          },
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
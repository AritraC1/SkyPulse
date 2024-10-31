import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/colours.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = "New Delhi";
  Map<String, dynamic> weatherData = {};
  final TextEditingController _searchController = TextEditingController();

  Future<void> fetchWeather() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/weather?location=$location'));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching weather: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Color _getBackgroundColor() {
    String description = weatherData['description']?.toLowerCase() ??
        ""; // Access description from weatherData

    if (description.contains("sunny")) {
      return Colours.sunnyBgColor;
    } else if (description.contains("cloud") || description.contains("haze")) {
      return Colours.cloudyBgColor;
    } else if (description.contains("snow")) {
      return Colours.snowyBgColor;
    } else if (description.contains("rain")) {
      return Colours.rainyBgColor;
    }

    return Colours.sunnyBgColor; // Default color
  }

  LottieBuilder _getAnimation() {
    String description = weatherData['description']?.toLowerCase() ??
        ""; // Access description from weatherData

    if (description.contains("sunny")) {
      return Lottie.asset(
        'assets/lottie/sunny.json',
        height: 200,
        width: 200,
      );
    } else if (description.contains("cloud") || description.contains("haze")) {
      return Lottie.asset(
        'assets/lottie/cloudy.json',
        height: 200,
        width: 200,
      );
    } else if (description.contains("snow")) {
      return Lottie.asset(
        'assets/lottie/snowy.json',
        height: 200,
        width: 200,
      );
    } else if (description.contains("rain")) {
      return Lottie.asset(
        'assets/lottie/rainy.json',
        height: 200,
        width: 200,
      );
    }

    // Default animation
    return Lottie.asset(
      'assets/lottie/sunny.json',
      height: 200,
      width: 200,
    );
  }

  // to get current Day and Date
  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, d MMMM').format(now); // Format: "Monday, 1 April"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SEARCH ICON
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the TextField
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38, // Shadow color
                    offset: Offset(0, 4), // Shadow position
                    blurRadius: 4, // Spread of the shadow
                    spreadRadius: 0, // Size of the shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    hintText: 'Enter Location',
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white),
                onSubmitted: (value) {
                  setState(() {
                    location = value;
                    fetchWeather();
                    _searchController.clear();
                  });
                },
              ),
            ),

            const SizedBox(height: 40),

            // LOCATION ICON + MY CURRENT LOCATION
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 35,
                ),
                const SizedBox(width: 12),
                Text(
                  '${weatherData['location']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    color: Colours.textColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // LOTTIE ANIMATION
            _getAnimation(),

            const SizedBox(height: 20),

            // TEMP
            Text(
              '${weatherData['temperature']} °C',
              style: const TextStyle(
                fontSize: 75,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Colours.textColor,
              ),
            ),

            const SizedBox(height: 20),

            // WEATHER CONDITION
            Text(
              '${weatherData['description']}',
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Colours.textColor,
              ),
            ),

            // DAY-DATE

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getFormattedDate(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colours.textColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // OTHER INFO.
            Container(
              margin: const EdgeInsets.all(7),
              height: 100,
              width: 250,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 4.0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat),
                      const SizedBox(width: 10),
                      Text(
                        'Humidity: ${weatherData['humidity']}%',
                        style: const TextStyle(
                          color: Colours.textColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wind_power),
                      const SizedBox(width: 10),
                      Text(
                        'Wind: ${weatherData['windSpeed']} m/s',
                        style: const TextStyle(
                          color: Colours.textColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

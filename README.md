# Weather App 

This app showcases a Flutter application that connects to a NodeJs server for fetching Weather Data of our current and searched locations. Along with animated weather data using Lottie Animations. Here are some of the app samples:

<img width="361" alt="Current Location" src="https://github.com/user-attachments/assets/0e6dccab-7840-4af9-aa15-437d1259ce68">

<img width="356" alt="Searched Location 1: Kolkata" src="https://github.com/user-attachments/assets/aab21999-1613-4e92-aed7-638ac18515fa">

<img width="362" alt="Searched Loaction 2: Ishigaki" src="https://github.com/user-attachments/assets/33d6c6d5-154a-47f8-b43d-df212e929c54">

## Server (NodeJs)
Implemented in Node.js with the 'express' library, the server fetches data from the weather api on port 3000.

### Installation and Usage

1. Ensure Node.js is installed on your machine.
2. Navigate to the server directory: 'cd server'
3. Install dependencies: 'npm install'
4. Start the server: 'npm start'
5. The server initiates on 'http://localhost:3000'.

## Client (Flutter)

The Flutter client app connects seamlessly to the server. 

### Installation and Usage

1. Confirm Flutter is installed on your machine.
2. Navigate to the Flutter app directory: 'cd weather_app'
3. Install dependencies: 'flutter pub get'
4. Connect your device or launch an emulator.
5. Run the Flutter app: 'flutter run'
6. Input the server URL (e.g., 'http://localhost:3000')

## Functionality

- The app provides a user interface where users can enter a location to view weather information. It fetches data from the backend, displays the location name, weather icon, temperature, description, and other details like wind speed and humidity, and updates the background and weather icon based on weather conditions.

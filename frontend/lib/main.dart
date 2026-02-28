import 'package:flutter/material.dart';

import 'theme_notifier.dart';
import 'colorscheme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 1. IMPORT your new registration screen here
import 'registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'First Aid App',
          theme: ThemeData(
            colorScheme: AppColors.lightScheme,
            scaffoldBackgroundColor: AppColors.lightBackground,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: AppColors.darkScheme,
            scaffoldBackgroundColor: AppColors.darkBackground,
            useMaterial3: true,
          ),
          themeMode: mode,
          // 2. CHANGE the home property to RegistrationScreen
          home: RegistrationScreen(),
        );
      },
    );
  }
}

// ... the rest of your EmergencyScreen code remains below ...

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  String _status = "System Ready";

  // 1. Request All Permissions (Location, SMS, Call Log)
  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.sms,
      Permission.phone, // For call log/dialing
    ].request();

    if (statuses[Permission.location]!.isGranted) {
      setState(() => _status = "Permissions Granted");
    } else {
      setState(() => _status = "Permissions Denied");
    }
  }

  // 2. Get Location and Send to Backend
  Future<void> _sendEmergencyAlert() async {
    setState(() => _status = "Fetching Location...");

    try {
      // Get current GPS coordinates
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() => _status = "Sending Alert...");

      // Replace with your actual Backend URL (use 10.0.2.2 if using Android Emulator)
      final url = Uri.parse('http://10.0.2.2:3000/api/emergency/alert');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": "user_123",
          "latitude": position.latitude,
          "longitude": position.longitude,
          "timestamp": DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _status = "Alert Sent Successfully!");
      } else {
        setState(() => _status = "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _status = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Aid SOS")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Status: $_status", style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _requestPermissions,
              child: Text("Grant Permissions"),
            ),
            SizedBox(height: 20),
            // The Big Red SOS Button
            GestureDetector(
              onLongPress:
                  _sendEmergencyAlert, // Long press to prevent accidents
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.red,
                child: Text(
                  "HOLD FOR SOS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

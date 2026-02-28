import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers to capture text input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _medsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Emergency Service Controllers
  final TextEditingController _policeController = TextEditingController();
  final TextEditingController _ambulanceController = TextEditingController();
  final TextEditingController _fireController = TextEditingController();

  void _showLocationReminder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "💡 Reminder: Please add the service numbers closest to your current city/location for faster response.",
        ),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Future<void> _saveProfile() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/user/register');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "full_name": _nameController.text,
          "age": _ageController.text,
          "blood_type": _bloodController.text,
          "allergies": _allergyController.text,
          "medications": _medsController.text,
          "medical_notes": _notesController.text,
          "police": _policeController.text,
          "ambulance": _ambulanceController.text,
          "fire": _fireController.text,
        }),
      );

      if (response.statusCode == 200) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Profile Saved Successfully!")));
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save profile. Please try again.")),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Up Medical Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(labelText: "Age"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _bloodController,
                    decoration: InputDecoration(
                      labelText: "Blood Type (e.g. O+)",
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _allergyController,
              decoration: InputDecoration(labelText: "Allergies"),
            ),
            TextField(
              controller: _medsController,
              decoration: InputDecoration(labelText: "Current Medications"),
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: "Additional Medical Notes",
              ),
              maxLines: 3,
            ),

            Divider(height: 40),
            Text(
              "Emergency Services",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            // Notification triggers when user taps these fields
            TextField(
              controller: _policeController,
              decoration: InputDecoration(labelText: "Local Police Number"),
              onTap: _showLocationReminder,
            ),
            TextField(
              controller: _ambulanceController,
              decoration: InputDecoration(labelText: "Local Ambulance Number"),
              onTap: _showLocationReminder,
            ),
            TextField(
              controller: _fireController,
              decoration: InputDecoration(
                labelText: "Local Fire Service Number",
              ),
              onTap: _showLocationReminder,
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Save & Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

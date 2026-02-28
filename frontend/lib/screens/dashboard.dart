import 'package:flutter/material.dart';
import '../settings/setting.dart';
import '../first_aid/first_aid.dart';
import '../emergency_hub/hub.dart';

// Dummy data for saved contacts and general emergency numbers
final List<Map<String, String>> emergencyContacts = [
  {'id': '1', 'name': 'Family Contact 1', 'number': '0722387741'},
  {'id': '2', 'name': 'Family Contact 2', 'number': '0722484280'},
];

final List<Map<String, dynamic>> emergencyServices = [
  {
    'id': 'police',
    'name': 'Police',
    'number': '0748008452',
    'icon': Icons.shield,
  },
  {
    'id': 'ambulance',
    'name': 'Ambulance',
    'number': '0791182653',
    'icon': Icons.medical_services,
  },
  {
    'id': 'fire',
    'name': 'Fire',
    'number': '0745799633',
    'icon': Icons.local_fire_department,
  },
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Function to simulate a phone call
  void initiateCall(BuildContext context, String number, String contactName) {
    // In a real app, you'd use url_launcher to call
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Calling $contactName'),
        content: Text('Attempting to dial: $number'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void handleSOSPress(BuildContext context) {
    // Logic for a global SOS button
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SOS Triggered!'),
        content: const Text(
          'Location shared and emergency services/contacts notified.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Dashboard'),
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quick Emergency Services
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Emergency Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: emergencyServices.map((service) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF007BFF,
                              ), // Blue color
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => initiateCall(
                              context,
                              service['number'],
                              service['name'],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  service['icon'],
                                  size: 30,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  service['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // My Primary Contacts
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Primary Contacts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  ...emergencyContacts.map((contact) {
                    return InkWell(
                      onTap: () => initiateCall(
                        context,
                        contact['number']!,
                        contact['name']!,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFEEEEEE),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              contact['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              contact['number']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF28A745), // Green color
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MedicalIdScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Manage All Contacts →',
                        style: TextStyle(
                          color: Color(0xFF007BFF),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Navigation to First Aid Content
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107), // Yellow/Orange
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuideListScreen()),
                );
              },
              child: const Center(
                child: Text(
                  '📖 First Aid Guides',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
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

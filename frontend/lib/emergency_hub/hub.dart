import 'package:flutter/material.dart';

class MedicalIdScreen extends StatefulWidget {
  const MedicalIdScreen({super.key});

  @override
  State<MedicalIdScreen> createState() => _MedicalIdScreenState();
}

class _MedicalIdScreenState extends State<MedicalIdScreen> {
  bool isNotesVisible = true;

  // Placeholder Data
  final Map<String, dynamic> medicalData = {
    "name": "CASTRO N KABURU",
    "dob": "04/01/2004 (21)",
    "bloodType": "O+",
    "conditions": ["Diabetes (Type 1)", "Asthma"],
    "allergies": ["Penicillin", "Peanuts"],
    "medications": [
      "Insulin (Fast-Acting), 10 units before meals, 3xx dx daily, for T1D",
    ],
    "organDonor": "YES",
    "specialInstructions": "Prone to seizures.",
    "contact1": "Tim M (Friend)",
    "contact2": "Ronny K (Friend)",
  };

  void _callNumber(String number) {
    // In a real app, use url_launcher
    debugPrint("Calling $number");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color handled by theme
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EMERGENCY PROFILE HEADER
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B30), // Red
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.local_hospital, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "EMERGENCY PROFILE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // PROFILE DATA
              Text(
                medicalData["name"],
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              ContactRow(
                name: medicalData["contact1"],
                number: "0745799633",
                onCall: () => _callNumber("0745799633"),
              ),
              ContactRow(
                name: medicalData["contact2"],
                number: "0791182653",
                onCall: () => _callNumber("0791182653"),
              ),

              const Divider(color: Color(0xFF3A3A3C), height: 31),

              DataText(label: "DOB / AGE:", value: medicalData["dob"]),
              DataText(label: "BLOOD TYPE:", value: medicalData["bloodType"]),

              const Divider(color: Color(0xFF3A3A3C), height: 31),

              // MEDICAL CONDITIONS & ALLERGIES
              const SectionTitle(title: "MEDICAL CONDITIONS & ALLERGIES"),
              const DataText(value: "**CHRONIC CONDITIONS:**", isBold: true),
              ...List<String>.from(
                medicalData["conditions"],
              ).map((item) => ListItem(text: item)),
              const SizedBox(height: 10),
              const DataText(value: "**ALLERGIES:**", isBold: true),
              ...List<String>.from(
                medicalData["allergies"],
              ).map((item) => ListItem(text: item)),

              const Divider(color: Color.fromARGB(255, 0, 0, 0), height: 31),

              // MEDICATIONS
              const SectionTitle(title: "MEDICATIONS"),
              ...List<String>.from(medicalData["medications"]).map(
                (item) => Text(
                  item,
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16),
                ),
              ),

              const Divider(color: Color(0xFF3A3A3C), height: 31),

              // OTHER IMPORTANT NOTES
              const SectionTitle(title: "OTHER IMPORTANT NOTES"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataText(
                          label: "ORGAN DONOR:",
                          value: medicalData["organDonor"],
                        ),
                        if (isNotesVisible)
                          ListItem(text: medicalData["specialInstructions"]),
                      ],
                    ),
                  ),
                  Switch(
                    value: isNotesVisible,
                    onChanged: (val) => setState(() => isNotesVisible = val),
                    activeTrackColor: const Color(0xFF81b0ff),
                    activeThumbColor: const Color(0xFFf5dd4b),
                    inactiveTrackColor: const Color(0xFF767577),
                  ),
                ],
              ),

              // EDIT BUTTON
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF), // Blue
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Edit Screen
                  },
                  child: const Text(
                    "EDIT MY INFORMATION",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const Center(
                child: Text(
                  "Data last updated. Nov 18, 2025",
                  style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFAAAAAA),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final String name;
  final String number;
  final VoidCallback onCall;

  const ContactRow({
    super.key,
    required this.name,
    required this.number,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16)),
          InkWell(
            onTap: onCall,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF34C759), // Green
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "CALL",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataText extends StatelessWidget {
  final String? label;
  final String value;
  final bool isBold;

  const DataText({
    super.key,
    this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    String text = label != null ? "$label $value" : value;
    // Simple bold handling assuming **markdown** style was stripped or handled.
    // Logic to strip ** if present or handle manually as React Native code did string interpolation.
    // The RN code used "**DOB / AGE:** {dob}". in Flutter we just show it.
    text = text.replaceAll(
      '**',
      '',
    ); // Strip markdown bold markers for clean text

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 16,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  const ListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Text(
        "* $text",
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FirstAidGuide {
  final String title;
  final List<String> steps;
  final String warning;
  final String? imagePath; // New field for the image

  FirstAidGuide({
    required this.title,
    required this.steps,
    required this.warning,
    this.imagePath,
  });
}

void main() => runApp(FirstAidApp());

class FirstAidApp extends StatelessWidget {
  const FirstAidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      home: GuideListScreen(),
    );
  }
}

class GuideListScreen extends StatelessWidget {
  // Our data set for the requested guidelines
  final List<FirstAidGuide> guides = [
    FirstAidGuide(
      title: "Choking",
      imagePath: "assets/images/choking_heimlich.png", // Path to your asset
      steps: [
        "Stand behind the person and wrap arms around their waist.",
        "Make a fist and place it just above the navel.",
        "Grasp your fist with the other hand.",
        "Perform 5 quick, upward and inward abdominal thrusts (Heimlich maneuver).",
        "Repeat until the object is forced out or the person becomes unresponsive.",
      ],
      warning: "Do not perform abdominal thrusts on infants or pregnant women.",
    ),
    FirstAidGuide(
      title: "Bleeding",
      steps: [
        "Apply firm, direct pressure to the wound with a clean cloth.",
        "Maintain pressure until the bleeding stops.",
        "If blood soaks through, add more cloth on top; do not remove the original layer.",
        "Elevate the injured limb above heart level if possible.",
      ],
      warning:
          "If bleeding is spurting or won't stop, apply a tourniquet and call emergency services.",
    ),
    FirstAidGuide(
      title: "Burns",
      steps: [
        "Run cool (not cold) water over the burn for at least 10-20 minutes.",
        "Remove restrictive items like rings before swelling begins.",
        "Cover the burn loosely with a sterile gauze bandage.",
        "Take an over-the-counter pain reliever if needed.",
      ],
      warning: "Do not pop blisters or apply butter/ointments to a fresh burn.",
    ),
    FirstAidGuide(
      title: "Fractures",
      steps: [
        "Do not move the person unless they are in immediate danger.",
        "Immobilize the injured limb using splints or a sling.",
        "Apply ice to reduce swelling.",
        "Call emergency services if the fracture is severe.",
      ],
      warning: "Do not attempt to realign bones yourself.",
    ),
    FirstAidGuide(
      title: "Cuts & Wounds",
      steps: [
        "Wash your hands before touching the wound.",
        "Clean the wound with gentle soap and water.",
        "Apply an antibiotic ointment or petroleum jelly.",
        "Cover with a bandage to keep it clean.",
      ],
      warning:
          "Seek medical help for deep wounds, animal bites, or rusty metal cuts.",
    ),
  ];

  GuideListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Aid Guide")),
      body: ListView.builder(
        itemCount: guides.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.medical_services, color: Colors.red),
              title: Text(
                guides[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(guide: guides[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final FirstAidGuide guide;
  const DetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(guide.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Emergency Steps:",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            ...guide.steps.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "${entry.key + 1}. ${entry.value}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "⚠️ WARNING: ${guide.warning}",
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

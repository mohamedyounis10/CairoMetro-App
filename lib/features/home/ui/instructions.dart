import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/section.dart';

class InstructionsScreen extends StatelessWidget {
  // Instructions
  final List<String> doList = [
    "Follow the signage and pay attention to announcements and radio alerts inside the station.",
    "Assist the elderly, women, children, and people with special needs (allow them to pass first through ticket gates, escalators, elevators, boarding the train, and give them priority to sit).",
    "Maintain cleanliness in stations and trains, and dispose of waste in bins.",
    "If you notice any suspicious activity in the station or train, report to the authorities.",
    "Inform the station officer about any observations in the station or train.",
    "Use safety and emergency equipment (fire extinguishers or train emergency alarms) only in emergencies to avoid legal consequences.",
    "Use your ticket or smart card to pass through ticket gates.",
    "Approach the ticket gate officer if there is a malfunction.",
    "Hold the handrail and stand on the escalator in the direction of movement.",
    "When waiting for the train, stand behind the yellow line on the platform.",
    "Allow passengers to exit the train before boarding.",
    "Move away from the doors after boarding the train."
  ];
  final List<String> dontList = [
    "Do not smoke inside the metro.",
    "Do not carry flammable or hazardous chemical materials.",
    "Do not bring animals.",
    "Do not tamper with or attempt to damage the station, train, or ticket gates to avoid legal consequences.",
    "Do not jump over ticket gates to pass through to avoid fines.",
    "Do not force your way or pass in groups through the ticket gates.",
    "Do not run, sit, or play on escalators.",
    "Do not allow children to ride or use escalators alone.",
    "Do not push, play, or run on the train platform.",
    "Do not go down to the tracks to pick up lost items; immediately contact station staff for help.",
    "Do not open or close train doors manually.",
    "Do not board the train after the door-closing alarm has started.",
    "Do not sit on the train floor."
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            buildSection("Do", doList, Colors.green[50]!, Colors.green),
            buildSection("Don't", dontList, Colors.red[50]!, Colors.red),
          ],
        ),
      );
  }
}

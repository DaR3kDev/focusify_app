import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static const Color primaryColor = Color(0xFFFF8A3D);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double focus = 25;
  double shortBreak = 5;
  double longBreak = 15;

  bool autoStart = false;
  bool notification = true;

  String theme = "dark";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              // 🔥 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "CHRONOMETRIC\nSANCTUARY",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: SettingScreen.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Quick Start",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Tune your sanctuary for optimal focus sessions.",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 25),

              // 🔥 TIMER CONFIG
              _sectionTitle("TIMER CONFIGURATION"),

              _sliderCard(
                title: "Focus duration",
                value: focus,
                unit: "MIN",
                min: 5,
                max: 60,
                onChanged: (v) => setState(() => focus = v),
              ),

              _sliderCard(
                title: "Short Break",
                value: shortBreak,
                unit: "MIN",
                min: 1,
                max: 15,
                onChanged: (v) => setState(() => shortBreak = v),
              ),

              _sliderCard(
                title: "Long Break",
                value: longBreak,
                unit: "MIN",
                min: 5,
                max: 45,
                onChanged: (v) => setState(() => longBreak = v),
              ),

              const SizedBox(height: 20),

              // 🔥 AUTOMATION
              _sectionTitle("AUTOMATION & FEEDBACK"),

              _switchCard(
                title: "Auto-start next session",
                subtitle:
                    "Automatically begin focus or break after timer expires",
                value: autoStart,
                onChanged: (v) => setState(() => autoStart = v),
              ),

              _switchCard(
                title: "Notification sound",
                subtitle: "Play a gentle chime when timer finishes",
                value: notification,
                onChanged: (v) => setState(() => notification = v),
              ),

              const SizedBox(height: 20),

              // 🔥 THEME
              _sectionTitle("AESTHETIC ENVIRONMENT"),

              Row(
                children: [
                  _themeCard("dark"),
                  const SizedBox(width: 12),
                  _themeCard("light"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.orange,
          fontSize: 10,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // 🔥 SLIDER CARD
  Widget _sliderCard({
    required String title,
    required double value,
    required String unit,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(
                "${value.toInt()} $unit",
                style: TextStyle(
                  color: SettingScreen.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: SettingScreen.primaryColor,
            inactiveColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // 🔥 SWITCH CARD
  Widget _switchCard({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.white38),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70)),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: SettingScreen.primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // 🔥 THEME CARD
  Widget _themeCard(String type) {
    final isSelected = theme == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => theme = type),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF161A22),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? SettingScreen.primaryColor
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              type.toUpperCase(),
              style: TextStyle(
                color: isSelected ? SettingScreen.primaryColor : Colors.white54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

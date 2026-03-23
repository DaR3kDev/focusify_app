import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFFFF8A3D);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget _circleButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
        const SizedBox(height: 6),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 9,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Cronométrico\nSantuario",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "DEEP WORK",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "FOCUS",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: CircularProgressIndicator(
                          value: 0.75, // progreso (ejemplo)
                          strokeWidth: 10,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation(
                            HomeScreen.primaryColor,
                          ),
                        ),
                      ),

                      const Text(
                        "25:00",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 48,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: HomeScreen.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeScreen._circleButton(
                    Icons.skip_next_rounded,
                    "Saltar Descanso",
                  ),
                  const SizedBox(width: 20),
                  HomeScreen._circleButton(
                    Icons.settings_rounded,
                    "Configurar",
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

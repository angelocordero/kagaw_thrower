import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_catapult_client/screens/input_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    const ProjectCatapultClient(),
  );
}

class ProjectCatapultClient extends StatelessWidget {
  const ProjectCatapultClient({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InputScreen(),
    );
  }
}

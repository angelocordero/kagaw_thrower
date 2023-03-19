import 'package:flutter/material.dart';
import 'package:project_catapult_client/widgets/drive_buttons.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key, required this.channel});

  final WebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              left: 100,
              bottom: 150,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  print('forward');
                },
                icon: Icons.keyboard_arrow_up,
              ),
            ),
            Positioned(
              left: 100,
              bottom: 50,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  print('down');
                },
                icon: Icons.keyboard_arrow_down,
              ),
            ),
            Positioned(
              right: 100,
              bottom: 150,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  print('forward');
                },
                icon: Icons.keyboard_arrow_up,
              ),
            ),
            Positioned(
              right: 100,
              bottom: 50,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  print('down');
                },
                icon: Icons.keyboard_arrow_down,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

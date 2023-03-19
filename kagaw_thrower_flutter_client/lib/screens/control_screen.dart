import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../widgets/drive_buttons.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key, required this.channel});

  final WebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Left Forward Button
            Positioned(
              left: 100,
              bottom: 150,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  channel.sink.add('LEFT_DRIVE_MOTOR_FORWARD');
                },
                icon: Icons.keyboard_arrow_up,
              ),
            ),

            // Left Reverse Button
            Positioned(
              left: 100,
              bottom: 50,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  channel.sink.add('LEFT_DRIVE_MOTOR_REVERSE');
                },
                icon: Icons.keyboard_arrow_down,
              ),
            ),

            // Right Forward Button
            Positioned(
              right: 100,
              bottom: 150,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  channel.sink.add('RIGHT_DRIVE_MOTOR_FORWARD');
                },
                icon: Icons.keyboard_arrow_up,
              ),
            ),

            // Right Reverse Button
            Positioned(
              right: 100,
              bottom: 50,
              width: 100,
              height: 50,
              child: DriveButton(
                onTapOrHold: () {
                  channel.sink.add('RIGHT_DRIVE_MOTOR_REVERSE');
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

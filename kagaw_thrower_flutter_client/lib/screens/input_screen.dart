import 'package:flutter/material.dart';
import 'package:project_catapult_client/screens/control_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  static TextEditingController ipAddressController = TextEditingController.fromValue(const TextEditingValue(text: '192.168.4.1'));
  WebSocketChannel? channel;

  Widget status = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 2 / 3,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Input IP Address',
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: ipAddressController,
              ),
              ElevatedButton(
                onPressed: () {
                  Uri wsUrl = Uri.parse('ws://${ipAddressController.text}/ws');

                  setState(() {
                    status = const Column(
                      children: [
                        Text('Connecting...'),
                        LinearProgressIndicator(),
                      ],
                    );
                  });

                  channel = WebSocketChannel.connect(wsUrl);

                  channel?.ready.then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ControlScreen(
                            channel: channel!,
                          );
                        },
                      ),
                    );
                  }).onError((error, stackTrace) {
                    setState(() {
                      status = Text(
                        'Connection Error: ${error.toString()}',
                        style: const TextStyle(color: Colors.red),
                      );
                    });
                  }).timeout(
                    const Duration(seconds: 5),
                    onTimeout: () {
                      setState(() {
                        status = const Text(
                          'Timeout Error',
                          style: TextStyle(color: Colors.red),
                        );
                      });
                    },
                  );
                },
                child: const Text('Connect'),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(height: 50, child: status),
            ],
          ),
        ),
      ),
    );
  }
}



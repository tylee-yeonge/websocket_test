import 'package:flutter/material.dart';
import 'package:websocket_test/view/main_view.dart';

void main() {
  runApp(const WebsocketTestApp());
}

class WebsocketTestApp extends StatefulWidget {
  const WebsocketTestApp({super.key});

  @override
  State<WebsocketTestApp> createState() => _WebsocketTestAppState();
}

class _WebsocketTestAppState extends State<WebsocketTestApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainView(),
    );
  }
}

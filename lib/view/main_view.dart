import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roslibdart/roslibdart.dart';
import 'dart:async';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late Ros ros;
  late Topic chatter;

  @override
  void initState() {
    ros = Ros(url: 'ws://127.0.0.1:9090');
    chatter = Topic(
        ros: ros,
        name: '/rosbridge_tester/task_state',
        type: "thira_task_msgs/TaskState",
        reconnectOnClose: true,
        queueLength: 10,
        queueSize: 10);
    super.initState();
    ros.connect();
    print("websocket connected");
    chatter.subscribe(subscribeHandler);
  }

  void destroyConnection() async {
    await chatter.unsubscribe();
    await ros.close();
    setState(() {});
  }

  String msgReceived = '';
  String taskName = "";
  String taskId = "";
  String taskState = "";
  // Map<String, dynamic> receivedData = {};
  Future<void> subscribeHandler(Map<String, dynamic> msg) async {
    // print("msg:$msg");
    msgReceived = json.encode(msg);
    taskName = msg["task_name"];
    taskId = msg["task_id"];
    taskState = msg["task_state"];
    print("taskName:$taskName, taskId:$taskId, taskState:$taskState");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roslibdart Subscriber Example'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("taskName: $taskName, taskId: $taskId, taskState: $taskState"),
          ],
        ),
      ),
    );
  }
}

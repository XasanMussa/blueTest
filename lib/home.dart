import 'dart:convert';
import 'package:bluetest/Alarms.dart';
import 'package:bluetest/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_devices.dart';

enum BluetoothConnectionState {
  disconnected,
  connecting,
  connected,
  error,
}

class homepage extends StatefulWidget {
  const homepage({super.key, required this.title});

  final String title;

  @override
  State<homepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<homepage> {
  BluetoothConnectionState _btStatus = BluetoothConnectionState.disconnected;
  BluetoothConnection? connection;
  String _receivedMessage = "";
  int message = 0;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // String _messageBuffer = "";
  // double? percentValue;

  void _sendMessage(String text) async {
    connection?.output.add(utf8.encode(text + "\r\n"));
    await connection?.output.allSent;
  }

  void _receiveMessage() {
    if (connection == null || !connection!.isConnected) {
      print('Connection is not active.');
      return;
    }

    connection!.input!.listen((Uint8List data) {
      String message = utf8.decode(data); // Convert bytes to string
      setState(() {
        _receivedMessage = message.trim(); // Update received message
      });
    }, onError: (dynamic error) {
      print('Error receiving message: $error');
    });
  }

  void _showSnackbar(String message) {
    print("showing snackbar: " + message);
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        title: Text("SAC"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_bluetooth),
            onPressed: () async {
              BluetoothDevice? device = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BluetoothDevices()));

              if (device == null) return;

              print(
                  'Connecting to device...'); // show loading screen that indicates the device is connecting
              setState(() {
                _btStatus = BluetoothConnectionState.connecting;
              });

              BluetoothConnection.toAddress(device.address).then((_connection) {
                // _sendMessage("1");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("device connected successfully"),
                  duration: Duration(seconds: 5),
                ));
                // print(
                //     'Connected to the device'); // show snacbar that tells the device is connected successfully [by voice will be great]
                connection = _connection;
                setState(() {
                  _btStatus = BluetoothConnectionState.connected;
                });
                _receiveMessage();
              }).catchError((error) {
                print(
                    'Cannot connect, exception occured'); // show snackbar indicating the device is not connecting
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Bluetooth Device can not be connected. try again"),
                    duration: Duration(seconds: 5)));
                print(error);
                setState(() {
                  _btStatus = BluetoothConnectionState.error;
                  message = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("device diconnected"),
                    duration: Duration(seconds: 5)));
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text("Alarms"),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Alarms(
                              sendMessage: _sendMessage,
                            )));
              },
            ),
            ListTile(
              title: Text("About"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => about()));
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: 150, // Adjust the size of the circle
                height: 150, // Adjust the size of the circle
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 14, 83, 233).withOpacity(
                          0.5), // Adjust the shadow color and opacity
                      offset: Offset(0, 4), // Adjust the x and y offset
                      blurRadius: 4, // Adjust the blur radius
                      spreadRadius: 2, // Adjust the spread radius
                    ),
                  ],
                ),

                child: Center(
                  child: Text(
                    "\t\t\t\t" + message.toString() + "\u00B0" + "\n celsius",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.blue, width: 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                child: Text("celsius")),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  // _receiveMessage();
                  _sendMessage("success");

                  print("bluetooth data is " + _receivedMessage);

                  setState(() {
                    List<String> values = _receivedMessage
                        .split('.'); // Split the received data by '.'
                    List<int> integers =
                        []; // List to store the extracted integer values
                    values.forEach((value) {
                      try {
                        double parsedValue =
                            double.parse(value); // Parse the value as a double
                        int intValue =
                            parsedValue.toInt(); // Extract the integer part
                        integers.add(intValue);
                      } catch (e) {
                        print("Error parsing value: $e");
                      }
                    });

                    if (integers.isNotEmpty) {
                      message = integers[
                          0]; // Set the first integer value as 'message'
                      print(
                          "Extracted integer: $message"); // Print the extracted integer
                    }
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: const Color.fromRGBO(33, 150, 243, 1), width: 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                child: Text("fahrenheit")),
          ],
        ),
      ),
    );
  }
}

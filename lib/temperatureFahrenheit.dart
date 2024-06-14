import 'dart:convert';

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

  // void _onDataReceived(Uint8List data) {
  //   // Allocate buffer for parsed data
  //   int backspacesCounter = 0;
  //   data.forEach((byte) {
  //     if (byte == 8 || byte == 127) {
  //       backspacesCounter++;
  //     }
  //   });
  //   Uint8List buffer = Uint8List(data.length - backspacesCounter);
  //   int bufferIndex = buffer.length;

  //   // Apply backspace control character
  //   backspacesCounter = 0;
  //   for (int i = data.length - 1; i >= 0; i--) {
  //     if (data[i] == 8 || data[i] == 127) {
  //       backspacesCounter++;
  //     } else {
  //       if (backspacesCounter > 0) {
  //         backspacesCounter--;
  //       } else {
  //         buffer[--bufferIndex] = data[i];
  //       }
  //     }
  //   }

  //   // Create message if there is new line character
  //   String dataString = String.fromCharCodes(buffer);
  //   int index = buffer.indexOf(13);
  //   var message = '';
  //   if (~index != 0) {
  //     message = backspacesCounter > 0
  //         ? _messageBuffer.substring(
  //             0, _messageBuffer.length - backspacesCounter)
  //         : _messageBuffer + dataString.substring(0, index);
  //     _messageBuffer = dataString.substring(index);
  //   } else {
  //     _messageBuffer = (backspacesCounter > 0
  //         ? _messageBuffer.substring(
  //             0, _messageBuffer.length - backspacesCounter)
  //         : _messageBuffer + dataString);
  //   }

  //   // calculate percentage from message
  //   // analog 10 bit
  //   if (message.isEmpty) return; // to avoid fomrmat exception
  //   double? analogMessage = double.tryParse(message.trim());
  //   setState(() {
  //     var percent = (analogMessage ?? 0) / 1023;
  //     percentValue = 1 - percent; // inverse percent
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                print(
                    'Connected to the device'); // show snacbar that tells the device is connected successfully [by voice will be great]
                connection = _connection;
                setState(() {
                  _btStatus = BluetoothConnectionState.connected;
                });
                _receiveMessage();

                // connection!.input!.listen(_onDataReceived).onDone(() {
                //   setState(() {
                //     _btStatus = BluetoothConnectionState.disconnected;
                //   });
                // });
              }).catchError((error) {
                print(
                    'Cannot connect, exception occured'); // show snackbar indicating the device is not connecting
                print(error);

                setState(() {
                  _btStatus = BluetoothConnectionState.error;
                });
              });
            },
          ),
        ],
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
                    "\t\t\t\t" + "33\u00B0" + "\n celsius",
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
                  _receiveMessage();

                  print("bluetooth data is " + _receivedMessage);
                  setState(() {
                    double mes = double.parse(_receivedMessage);
                    message = mes.toInt();
                  });
                },
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
                child: Text("fahrenheit")),
          ],
        ),
      ),
    );
  }
}

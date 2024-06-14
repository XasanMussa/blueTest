import 'package:bluetest/blue_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // Add this import
import 'package:just_audio/just_audio.dart';
import 'package:bluetest/home.dart';

class Alarms extends StatefulWidget {
  final Function(String) sendMessage;
  const Alarms({required this.sendMessage});

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  String _currentTime = '';
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    _updateTime();
    // Update time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAzan() async {
    try {
      await _audioPlayer.setAsset('assets/azan2.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing azan: $e');
    }
  }

  Future<void> dispose() async {
    //set state ka bixi (await na ku dar saa u damiso)
    setState(() {
      _audioPlayer.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          Center(
            child: Card(
              child: BlueCard(text: _currentTime),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 40,
            width: 170,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 23, 115, 235)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () {
                  playAzan();
                },
                child: Text("sound")),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 40,
            width: 170,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 23, 115, 235)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () {
                  dispose();
                },
                child: Text("pause")),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 40,
            width: 170,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 23, 115, 235)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () {
                  widget.sendMessage("test success");
                },
                child: Text("SAC alarm")),
          )
        ],
      ),
    );
  }
}

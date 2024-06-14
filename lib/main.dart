// import 'package:bluetest/shared_preference_util.dart';
import 'package:bluetest/home.dart';
import 'package:flutter/material.dart';



void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'screen2': (context) => screen2(),
        'screen3': (context) => screen3(),
        'screen4': (context) => screen4(),
        'home': (context) => homepage(title: "Smart Alarm Clock")
      },
      debugShowCheckedModeBanner: false,
      title: 'Smart Alarm Clock',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: screen1(),
    );
  }
}





//screen 1 of the onboarding

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Image.asset(
            "assets/screen1.png",
            height: 450,
          ),
          Text(
            "WELCOME TO ",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "SAC system ",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: 220,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'screen2');
              },
              child: Text(
                "NEXT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 23, 115, 235)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

//screen 2 begin here

class screen2 extends StatefulWidget {
  const screen2({super.key});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Image.asset(
            "assets/screen2.png",
            height: 400,
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Text(
              "Simple and intuitive! Our user-friendly interface makes it easy to manage alarms and check the temperature, all in one place.",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.5,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 40,
            width: 220,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'screen3');
              },
              child: Text(
                "NEXT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 23, 115, 235)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

//screen 3 begins here

class screen3 extends StatefulWidget {
  const screen3({super.key});

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Image.asset(
            "assets/screen3.png",
            height: 400,
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Text(
              "Join our community of happy users! Experience the convenience and peace of mind our app brings to your daily routine.",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.5,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 40,
            width: 220,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'screen4');
              },
              child: Text(
                "NEXT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 23, 115, 235)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

//screen 4 begins here
class screen4 extends StatefulWidget {
  const screen4({super.key});

  @override
  State<screen4> createState() => _screen4State();
}

class _screen4State extends State<screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Image.asset(
            "assets/screen4.png",
            height: 400,
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Text(
              "Embrace the power of knowing! Stay ahead of the weather with real-time updates, empowering you to plan and pursue your adventures fearlessly",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.5,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 40,
            width: 220,
            child: ElevatedButton(
              onPressed: () {
                // SharedPrefUtil.setFirstTime(false);
                Navigator.pushNamed(context, 'home');
              },
              child: Text(
                "NEXT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 23, 115, 235)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

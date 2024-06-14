import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Meet Our Team",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
              '''we are dedicated team of engineers, designers who came together to create this system \n
           with diverse backgrounds and a shared love for technology, \n
           each member of the team brings unique expertise to the table'''),
          Text(
            "Supervision",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
              '''our project was overseen by Eng Abdullah Hassan, whose guidance and expertise were instrumental in shaping the direction our project, \n
          his invaluable feedback and support have helped us navigate challenges and achieve our goals'''),
          Text(
              '''before listing the names of our contributers, we'd like to extend our gratitude to everyone \n
          who has played a part in bringing this project to life, whether through testing, feedback or moral support, your contriubtions have been invaluable.
          '''),
          Text(
            "Contributers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("Eng. Abdullahi Hassan: [Supervisor]"),
          Text("Eng Hassan Musse Abshir: [App developer] "),
          Text("Mohamed Salad Mohamed [IOT developer]"),
          Text("Anas Dahir Mohamed [IOT developer]"),
          Text("Rawda Abdullahi Salad [designer]"),
          Text("Faduma Abdullahi Abdi [designer]")
        ],
      ),
    );
  }
}

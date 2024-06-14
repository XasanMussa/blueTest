import "package:flutter/material.dart";

class temperature extends StatelessWidget {
  const temperature({super.key});

  @override
  Widget build(BuildContext context) {
    //original temperature value that will be shown on the screen
    double temp = 0;
    //celsius degree temperature
    double temp_cel = temp;
    //fahrenheit degree temperature
    double temp_fahr = 0;

    //method that converts celsius to fahrenhiet
    double celsiusToFahrenheit(double celsius) {
      return (celsius * 9 / 5) + 32;
    }
    //method that converts  fahrenhiet to celsius

    double fahrenheitToCelsius(double fahrenheit) {
      return (fahrenheit - 32) * 5 / 9;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.more)),
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
                    "\t\t\t\ " + temp.toString() + "Celsius",
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
                onPressed: () {
                  fahrenheitToCelsius(temp);
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
                child: Text("celsius")),
            SizedBox(
              height: 10,
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
                child: Text("fahrenheit")),
          ],
        ),
      ),
    );
  }
}

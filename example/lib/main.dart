import 'package:flutter/material.dart';
import 'package:joystick/joystick.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedGallery = 0;
  int selectedImage = 0;
  List<List<String>> galleryList = [
    [
      "assets/birds/b1.jpg",
      "assets/birds/b2.jpg",
      "assets/birds/b3.jpg",
      "assets/birds/b4.jpg",
    ],
    [
      "assets/cats/c1.jpg",
      "assets/cats/c2.jpg",
      "assets/cats/c3.jpg",
      "assets/cats/c4.jpg",
    ],
    [
      "assets/dogs/d1.jpg",
      "assets/dogs/d2.jpg",
      "assets/dogs/d3.jpg",
      "assets/dogs/d4.jpg",
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(galleryList[selectedGallery][selectedImage]),
                fit: BoxFit.cover)),
        child: Joystick(
            size: 100,
            isDraggable: true,
            iconColor: Colors.amber,
            backgroundColor: Colors.black,
            opacity: 0.5,
            joystickMode: JoystickModes.all,
            onUpPressed: () {
              if (selectedGallery - 1 > 0)
                setState(() {
                  selectedGallery -= 1;
                });
            },
            onLeftPressed: () {
              if (selectedImage - 1 > 0)
                setState(() {
                  selectedImage -= 1;
                });
            },
            onRightPressed: () {
              if (selectedImage + 1 < galleryList[selectedGallery].length)
                setState(() {
                  selectedImage += 1;
                });
            },
            onDownPressed: () {
              if (selectedGallery + 1 < galleryList.length)
                setState(() {
                  selectedGallery += 1;
                });
            },
            onPressed: (_direction) {
              // print("pressed $_direction");
            }),
      ),
    );
  }
}

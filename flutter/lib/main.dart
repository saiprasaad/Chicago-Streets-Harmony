import 'package:chicago_social/views/eventspage.dart';
import 'package:chicago_social/views/reporthomeless.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100]!.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
                    
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/party.gif",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () {
                      Navigator.push(context,
                MaterialPageRoute(builder: (_) => EventsPage()));
                    }, child: const Text("Parade Details"))])),
                  
            Column(
              children: [
                Image.asset(
                  "assets/images/chicago.gif",
                  width: 300,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontFamily: 'Bobbers',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Chicago Streets Harmony'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100]!.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/trust.gif",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [ElevatedButton(onPressed: () {
                      Navigator.push(context,
                MaterialPageRoute(builder: (_) => HomelessReportingPage()));
                    }, child: const Text("Report Homeless"))],) ,
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

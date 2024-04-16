import 'dart:async';
import 'package:chicago_social/models/parade.dart';
import 'package:chicago_social/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SwipeCardDeck extends StatefulWidget {
  final String eventName;
  const SwipeCardDeck({super.key, required this.eventName});

  @override
  State<SwipeCardDeck> createState() => _SwipeCardDeckState();
}

class _SwipeCardDeckState extends State<SwipeCardDeck> {
  late Future<List<Unit>> _parades;
  PageController _pageController = PageController();
  late Timer _timer; // Initialize here
  int _currentPageIndex = 0;
  int _numPages = 5; // Change this to the total number of pages/cards

  @override
  void initState() {
    super.initState();
    _parades = fetchParades();
    // retrieveParades();
  }


  Future<List<Unit>> fetchParades() async {
    List<Unit> paradeUnits = [
      Unit(
        id: 1,
        name: "City High School Marching Band",
        description:
            "The City High School Marching Band showcases their musical talents with a lively performance featuring classic tunes and intricate formations.",
        imageUrl: "https://example.com/image1.jpg",
        country: "United States",
        performers: "City High School students",
        props: "Marching band instruments",
        messages: "Celebrate the spirit of music and teamwork!",
      ),
      Unit(
        id: 2,
        name: "Local Dance Academy",
        description:
            "The Local Dance Academy dazzles the crowd with a colorful and energetic dance routine, featuring dancers of all ages and styles.",
        imageUrl: "https://example.com/image2.jpg",
        country: "United States",
        performers: "Local Dance Academy students",
        props: "Colorful costumes",
        messages: "Expressing joy",
      ),
      // Unit(
      //   id: 3,
      //   name: "Community Float: 'Harvest of Hope'",
      //   description:
      //       "The 'Harvest of Hope' float represents the spirit of gratitude and community, adorned with bountiful decorations, fall foliage, and messages of thanks.",
      //   imageUrl: "https://example.com/image3.jpg",
      //   country: "United States",
      //   performers: ["Community volunteers", "Local residents"],
      //   props: ["Decorative elements", "Fall-themed decorations"],
      //   messages: ["Expressing gratitude for our community's support!"],
      // ),
      // Unit(
      //   id: 4,
      //   name: "City Fire Department Honor Guard",
      //   description:
      //       "The City Fire Department Honor Guard leads the parade with dignity and respect, paying tribute to the brave men and women who serve and protect the community.",
      //   imageUrl: "https://example.com/image4.jpg",
      //   country: "United States",
      //   performers: ["City Fire Department personnel"],
      //   props: ["Uniforms", "Flags"],
      //   messages: ["Honoring our local heroes and first responders!"],
      // ),
      // Unit(
      //   id: 5,
      //   name: "Local Charity: 'Feeding Families'",
      //   description:
      //       "Representatives from the 'Feeding Families' charity walk alongside their float, raising awareness for hunger relief efforts in the community and collecting donations.",
      //   imageUrl: "https://example.com/image5.jpg",
      //   country: "United States",
      //   performers: ["Charity representatives", "Volunteers"],
      //   props: ["Float with banners and donation boxes"],
      //   messages: ["Join us in the fight against hunger! Donate today!"],
      // ),
    ];

    await Future.delayed(const Duration(seconds: 7));
    _startAutoSlide();
    return paradeUnits;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      if (_currentPageIndex < _numPages - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Unit>>(
        future: _parades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Image.asset("assets/images/loading.gif"),
                  const SizedBox(height: 10),
                  const Text("Loading")
                ])));
          } else {
            final parades = snapshot.data as List<Unit>;
            return Scaffold(
              body: PageView.builder(
                controller: _pageController,
                itemCount: _numPages,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/${parades[index].id}.jpg",
                        height: 300,
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Text(
                            parades[index].name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            parades[index].description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 20),
                          )
                        ]),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                "Props: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(
                                parades[index].props,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 20),
                                softWrap: true,
                              ))
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                "Country: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(
                                parades[index].country,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 20),
                                softWrap: true,
                              ))
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                "Mesage: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(
                                parades[index].messages,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 20),
                                softWrap: true,
                              ))
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                "Performers: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(
                                parades[index].performers,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 20),
                                softWrap: true,
                              ))
                            ],
                          )),
                    ],
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            );
          }
        });
  }
}

import 'dart:async';
import 'package:chicago_social/models/parade.dart';
import 'package:chicago_social/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParadeDesc extends StatefulWidget {
  final List<Unit> units;
  const ParadeDesc({super.key, required this.units});

  @override
  State<ParadeDesc> createState() => _ParadeDescState();
}

class _ParadeDescState extends State<ParadeDesc> {
  PageController _pageController = PageController();
  late Timer _timer; // Initialize here
  int _currentPageIndex = 0;
  int _numPages = 5; // Change this to the total number of pages/cards

  @override
  void initState() {
    super.initState();

   _startAutoSlide();
    // retrieveParades();
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
    return Scaffold(
              body: PageView.builder(
                controller: _pageController,
                itemCount: _numPages,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/${index+1}.jpg",
                        height: 300,
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Text(
                            widget.units[index].name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            widget.units[index].description,
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
                                widget.units[index].props,
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
                                widget.units[index].country,
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
                                widget.units[index].messages,
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
                                widget.units[index].performers,
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
}

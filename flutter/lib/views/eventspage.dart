import 'package:chicago_social/models/parade.dart';
import 'package:chicago_social/models/unit.dart';
import 'package:chicago_social/views/paradedesc.dart';
import 'package:chicago_social/views/paradedescriptionpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}


class _EventsPageState extends State<EventsPage> {
late Future<List<Parade>> paradesList;

  @override
  void initState() {
    super.initState();
    paradesList = retrieveParades();
  }

    Future<List<Parade>> retrieveParades() async {
      List<Parade> parades = [];
    try {
      final response = await http.get(Uri.parse('http://104.194.124.109:8080/getEventData'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonDataList = jsonDecode(response.body);

      // Extract parade information
      
      for (var jsonData in jsonDataList) {
        String paradeName = jsonData['name'];
        String paradeDate = jsonData['date'];
        String paradeDescription = jsonData['description'];
        

        // Extract unit information for this parade
        List<Unit> units = [];
        for (var unitData in jsonData['parade']) {
          Unit unit = Unit(
            id: int.parse(unitData['id']),
            name: unitData['name'],
            description: unitData['description'],
            imageUrl: unitData['imageUrl'],
            country: unitData['country'],
            performers: unitData['performers'],
            props: unitData['props'],
            messages: unitData['messages'],
          );
          units.add(unit);
        }

        // Create Parade object
        Parade parade = Parade(
          name: paradeName,
          date: paradeDate,
          description: paradeDescription,
          units: units,
        );

        parades.add(parade);
      }

      // Print parade information (optional)
      parades.forEach((parade) {
        print("Parade Name: ${parade.name}");
        print("Date: ${parade.date}");
        print("Description: ${parade.description}");

        // Print unit information (optional)
        parade.units.forEach((unit) {
          print("Unit Name: ${unit.name}");
          print("Unit Description: ${unit.description}");
          print("Image URL: ${unit.imageUrl}");
        });
      });
      return parades;
    } else {
      return parades;
    }
  } catch (error) {
    print(error);
    return parades;

  }
  }

  List<String> _parseStringOrList(dynamic data) {
  if (data is String) {
    return [data];
  } else if (data is Iterable<dynamic>) {
    return List<String>.from(data);
  }
  return [];
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Parade>>(
        future: paradesList,
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
            final parade = snapshot.data as List<Parade>;
            return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
        title: const Text(
          "Events Page",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.calendar_month_outlined),
                      title: Text(
                        parade[0].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {
                         Navigator.push(context,
                MaterialPageRoute(builder: (_) => ParadeDesc(units: parade[0].units)));
                      },),
                      subtitle: Text(parade[0].date),
                      selected: true,
                      onTap: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Scrollbar(child:  ListView(
                      children: List.generate(
          parade.length - 1,
          (index) => 
                        ListTile(
                          leading: const Icon(Icons.calendar_month_outlined),
                          title: Text(
                            parade[index+1].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const IconButton(icon:  Icon(Icons.play_arrow), onPressed: null,),
                          subtitle: Text(parade[index+1].date),
                          selected: true,
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ))))
                      ],
                    )),
        ],
      ),
    );}});
  }
}

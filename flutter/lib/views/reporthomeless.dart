import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';


class HomelessReportingPage extends StatefulWidget {
  const HomelessReportingPage({super.key});

  @override
  State<HomelessReportingPage> createState() => _HomelessReportingPageState();
}

class _HomelessReportingPageState extends State<HomelessReportingPage> {
  bool uploadPic = false;
  late Future<String> location;
  Future<String> _getCurrentLocation() async {
    await Permission.location.request();
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return await _fetchAddress(position.latitude, position.longitude);
  } catch (e) {
    print('Error getting location: $e');
    return "Error";
    // Handle any errors that occur during location fetching
  }
}

Future<String> _fetchAddress(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
      return address;
    } else {
      print('No address found for the current location');
    }
  } catch (e) {
    return "Error";
    // Handle any errors that occur during address fetching
  }
  return "";
}

@override
void initState() {
  super.initState();
  location = _getCurrentLocation();
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: location,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Image.asset("assets/images/loading.gif"),
                  const SizedBox(height: 10),
                  const Text("Fetching location")
                ])));
          } else {
            final currentLocation = snapshot.data as String;
            return  Scaffold(
      appBar: AppBar(title: const Text("Report Homeless")),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        uploadPic == false ? Image.asset(
          "assets/images/homeless.png",
          width: 200,
          height: 200,
        ) : Image.asset(
          "assets/images/homeless_upload.jpg",
          width: 200,
          height: 200,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            uploadPic = true;
          });
        }, child: const Text("Upload Image")),
        const SizedBox(
          height: 10,
        ),
         Padding(padding: EdgeInsets.all(15), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
         const Icon(
            Icons.pin_drop_outlined,
            size: 30,
          ),
          SizedBox(width: 5),
          Flexible(child: Text(currentLocation, style: TextStyle(fontSize: 16), softWrap: true, textAlign: TextAlign.center,))])),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText:
                      'Enter description of the person', // Placeholder text
                  contentPadding:
                      EdgeInsets.all(8.0), // Padding inside the text field
                  border: InputBorder.none, // Hide the default border
                ),
                maxLines: null, // Allow multiple lines of text
              ),
            )),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Submit")),
      ])),
    );
    }});
  }
}

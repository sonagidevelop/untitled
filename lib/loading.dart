import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {



  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }
  void getLocation() async {
    try{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String lat = position.latitude.toString();
    String lon = position.longitude.toString();
    print(position);
    print(lat);
    print(lon); } catch(e) {
      print("there was an error");
    }
  }

  void fetchData() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String lat = position.latitude.toString();
    String lon = position.longitude.toString();
    lat = '${lat}'+'0';
    lon = '${lon}'+'0';
    print(lat);
    print(lon);

     Response response = await get(
         Uri.parse("https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${lon}0,${lat}0&sourcecrs=epsg:4326&output=json"),
       headers: test
     );
     String jsonData = response.body;
     print(jsonData);
     // var myJson_gu = jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
     // print(myJson_gu);
     // var myJson_si = jsonDecode(jsonData)["results"][1]['region']['area1']['name'];
     // print(myJson_si);
  }

  Map<String, String> test = {
    "X-NCP-APIGW-API-KEY-ID" : "n9hamqjko2",
    "X-NCP-APIGW-API-KEY" : "H0oYKsp8RuG0tn63J3geayID1VrBDVeeXuchqMSa"
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            fetchData();

          },
          child: Text('Get my location'),
        ),
      ),
    );
  }
}

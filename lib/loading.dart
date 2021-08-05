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
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String lat = position.latitude.toString();
      String lon = position.longitude.toString();
      print(position);
      print(lat);
      print(lon);
    } catch (e) {
      print("there was an error");
    }
  }

  Future<List> fetchData() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String lat = position.latitude.toString();
    String lon = position.longitude.toString();
    lat = '${lat}' + '0';
    lon = '${lon}' + '0';
    print(lat);
    print(lon);

    Response response = await get(
        Uri.parse(
            "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${lon}0,${lat}0&sourcecrs=epsg:4326&output=json"),
        headers: test);
    String jsonData = response.body;
    print(jsonData);
    var myJson_gu =
        jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
    print(myJson_gu);
    var myJson_si =
        jsonDecode(jsonData)["results"][1]['region']['area1']['name'];
    print(myJson_si);
    List<String> gusi = [myJson_si, myJson_gu];

    return gusi;
  }

  Map<String, String> test = {
    "X-NCP-APIGW-API-KEY-ID": "n9hamqjko2",
    "X-NCP-APIGW-API-KEY": "H0oYKsp8RuG0tn63J3geayID1VrBDVeeXuchqMSa"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       fetchData();
              //     },
              //     child: Text('Get my location')),
              FutureBuilder(
                builder: (context, snapshot){
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator();
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  else {
                    List ll = snapshot.data as List;

                    return Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ll[0]),
                          Text("   "),
                          Text(ll[1]),
                        ],
                      ),
                    );
                  }
                },
                future: fetchData(),
              )
            ],
          ),
        )
        );
  }
}

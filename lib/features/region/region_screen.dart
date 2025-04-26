import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vote_player_app/utils/location.dart';

class RegionScreen extends StatefulWidget {
  static String routeName = '/region';
  const RegionScreen({super.key});

  @override
  State<RegionScreen> createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("지역검색 화면")),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<Position>(
              future: determinePosition(),
              builder: (context, snapshot) {
                print('@@@@ ${snapshot.data?.latitude.toString()}');
                print('@@@@ ${snapshot.data?.longitude.toString()}');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (<Widget>[
                      Text(
                        'latitude : ${snapshot.data?.latitude.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'longitude: ${snapshot.data?.longitude.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ]),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

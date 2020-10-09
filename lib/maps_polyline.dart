import 'dart:async';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;

class TestMapPolyline extends StatefulWidget {
  @override
  _TestMapPolylineState createState() => _TestMapPolylineState();
}

LocationManager.LocationData locationData;

class _TestMapPolylineState extends State<TestMapPolyline> {
  List<Marker> _allMarkers = [];
  // final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  GoogleMapController controller;

  List<LatLng> latlngSegment1 = List();
  List<LatLng> latlngSegment2 = List();
  static LatLng _lat1 = LatLng(12.970750, 74.833225);
  static LatLng _lat2 = LatLng(12.971139, 74.832506);
  // static LatLng _lat3 = LatLng(12.910933, 74.898540);
  // static LatLng _lat4 = LatLng(12.883865, 74.863714);
  // static LatLng _lat5 = LatLng(12.926148, 74.857930);

  static LatLng _mid = LatLng(_lat1.latitude / 2 + _lat2.latitude / 2,
      _lat1.longitude / 2 + _lat2.longitude / 2);

  // LatLng _lastMapPosition = _lat1;

  local() async {
    LocationManager.Location location = LocationManager.Location();

    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    // _lastMapPosition = _mid;
    // LatLng(
    //     locationData.latitude < 0
    //         ? (locationData.latitude * -1)
    //         : locationData.latitude,
    //     locationData.longitude < 0
    //         ? (locationData.longitude * -1)
    //         : locationData.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _mid, zoom: 19.0)));
    return _mid;
  }

  Future<LatLng> getUserLocation() async {
    LatLng currentLocation = await local();
    try {
      currentLocation = await local();
      return currentLocation;
    } on Exception {
      currentLocation = _lat1;
      return _lat1;
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  Future<void> _goToTheLake() async {
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: _mid,
        zoom: 19.0,
      ),
    ));
    local();
  }

  @override
  void initState() {
    super.initState();
    local();
    //line segment 1
    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
    // latlngSegment1.add(_lat3);

    //line segment 2
    // latlngSegment2.add(_lat4);
    // latlngSegment2.add(_lat5);
    _allMarkers.add(Marker(
      markerId: MarkerId("TLP1"),
      draggable: false,
      onTap: () {},
      position: _lat1,
      infoWindow: InfoWindow(title: "TLP1"),
    ));
    _allMarkers.add(Marker(
      markerId: MarkerId("Transmitting station"),
      draggable: false,
      onTap: () {},
      position: _lat2,
      infoWindow: InfoWindow(title: "Transmitting station"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // local();
    return Scaffold(
        body: GoogleMap(
          //that needs a list<Polyline>
          polylines: _polyline,
          markers: Set.from(_allMarkers),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _mid,
            zoom: 19.0,
          ),
          mapType: MapType.terrain,
          myLocationEnabled: true,
        ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: FloatingActionButton.extended(
                  onPressed: _goToTheLake,
                  backgroundColor: Colors.indigo[50],
                  foregroundColor: Colors.indigo,
                  elevation: 4,
                  label: Text('Reset'),
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.indigo,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      // local();
      controller = controllerParam;
      // _markers.add(Marker(
      //   // This marker id can be anything that uniquely identifies each marker.
      //   markerId: MarkerId(_lastMapPosition.toString()),
      //   //_lastMapPosition is any coordinate which should be your default
      //   //position when map opens up
      //   // position: _lastMapPosition,
      //   // infoWindow: InfoWindow(
      //   //   title: 'Current Location',
      //   //   snippet: '',
      //   // ),
      // ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: latlngSegment1,
        width: 2,
        color: Colors.blue,
      ));

      //different sections of polyline can have different colors
      _polyline.add(Polyline(
        polylineId: PolylineId('line2'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment2,
        width: 2,
        color: Colors.red,
      ));
    });
  }
}

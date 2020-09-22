import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPicker extends StatefulWidget {
  final Function(LatLng latLng) onSaveLocation;
  final LatLng latLng;

  LocationPicker({this.onSaveLocation,this.latLng});

  @override
  _LocationPickerState createState() => _LocationPickerState(latLng);
}

class _LocationPickerState extends State<LocationPicker> {
  static double _cameraZoom = 8.0;
  Completer<GoogleMapController> _controller;
  LatLng _center;
  LatLng _lastCameraPosition;
  final Set<Marker> _markers = {};
  Marker userMarker;
  BitmapDescriptor userMarkerIcon;
  CameraPosition initialCameraPosition;


  _LocationPickerState(LatLng latLng){
    _controller = Completer<GoogleMapController>();
    _center = latLng ?? LatLng(23.8103, 90.4125);
    _lastCameraPosition = _center;
    initialCameraPosition = CameraPosition(
      target: _center,
      zoom: _cameraZoom,
    );
  }



  //Map Controller Functions
  _onCameraMove(CameraPosition cameraPosition) {
    _lastCameraPosition = cameraPosition.target;
  }

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _pickLocation() async {
    userMarker = Marker(
        markerId: MarkerId('Current Location'),
        position:
            LatLng(_lastCameraPosition.latitude, _lastCameraPosition.longitude),
        infoWindow: InfoWindow(title: 'You'),
        icon: BitmapDescriptor.defaultMarker);
    setState(() {
      _markers.add(userMarker);
    });
  }

  Future<bool> _requestPermission() async {
    var status = await Permission.location.status;
    logger.i(status);
    if (!status.isGranted) {
      var req = await Permission.location.request();
      logger.i(req);
      return req.isGranted;
    }
    {
      return true;
    }
  }

  void _goToCurrentDeviceLocation() async {
    bool hasPermission = await _requestPermission();
    if (hasPermission) {
      logger.i("getting current location");
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      logger.i(position);
      Marker marker = new Marker(
          markerId: MarkerId('You'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'You'));
      _goToPosition(marker);
    } else {
      BotToast.showText(text: "Permission Denied cannot get location");
    }
  }

  Future<void> _goToPosition(Marker marker) async {
    final GoogleMapController _googleMapController = await _controller.future;
    var position = CameraPosition(
      target: marker.position,
      zoom: 16,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(position));
  }



  @override
  Widget build(BuildContext context) {
    var googleMap = Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      child: GoogleMap(
        markers: _markers,
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        onMapCreated: _onMapCreated,
        onCameraMove: _onCameraMove,
        initialCameraPosition: initialCameraPosition,
      ),
    );

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your location'),
        actions: [
          InkWell(
            onTap: () {
              if (userMarker != null) {
                if(widget.onSaveLocation != null)
                widget?.onSaveLocation(userMarker.position);
                logger.i(userMarker.position);
                Navigator.of(context).pop();
              } else {
                BotToast.showText(text: 'Please select a position on map');
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text('Save'),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            googleMap,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Icon(
                  FontAwesomeIcons.mapPin,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: _pickLocation,
                child: Container(
                    width: width * 0.5,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 35),
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        border: Border.all(
                          color: Colors.blue[300],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue[200],
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(1, 1))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        StringResources.pickLocationText,
                        key: Key('pickLocationTextKey'),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: _goToCurrentDeviceLocation,
                child: Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(left: 10, bottom: 35),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300], width: 1)),
                  child: Center(
                    child: Icon(
                      Icons.my_location,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowLocationOnMapWidget extends StatefulWidget {
  final String markerLabel;
  final LatLng latLng;

  ShowLocationOnMapWidget({
    @required this.markerLabel,
    @required this.latLng,
  });

  @override
  _ShowLocationOnMapWidgetState createState() =>
      _ShowLocationOnMapWidgetState();
}

class _ShowLocationOnMapWidgetState extends State<ShowLocationOnMapWidget> {
  var mapLoadDelay = Duration(milliseconds: 600);

  @override
  void initState() {
    Future.delayed(mapLoadDelay).then((value) {
      _goToPosition(widget.latLng, widget.markerLabel);
    });
    super.initState();
  }

  List<Marker> markers = [];
  final double _cameraZoom = 10.4746;
  Completer<GoogleMapController> _controller = Completer();

  Future<void> _goToPosition(LatLng latLng, String label) async {
    var markId = MarkerId(widget.markerLabel);
    Marker _marker = Marker(
      onTap: () {
        print("tapped");
      },
      position: latLng,
      infoWindow: InfoWindow(title: label ?? ""),
      markerId: markId,
    );
    markers.add(_marker);
    final GoogleMapController _googleMapController = await _controller.future;
    var position = CameraPosition(
      target: latLng,
      zoom: _cameraZoom,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: widget.latLng,
      zoom: _cameraZoom,
    );
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<bool>(
          future: Future.delayed(mapLoadDelay).then((value) => true),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return SizedBox();
            return GoogleMap(
              markers: markers.toSet(),
              gestureRecognizers: Set()
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer()))
                ..add(
                    Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: initialCameraPosition,
            );
          }),
    );
  }
}

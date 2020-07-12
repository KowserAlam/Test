import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class PickCompanyLocation extends StatelessWidget {
  final LatLng _latLn;
  final _apiKey = "AIzaSyAMUgyO17OnIHXmjCMpRksW1jLc2DORM9g";

  PickCompanyLocation(this._latLn);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacePicker(
              apiKey: _apiKey,
              useCurrentLocation: true,
              selectedPlaceWidgetBuilder:
                  (_, selectedPlace, state, isSearchBarFocused) {
                return isSearchBarFocused
                    ? Container()
                    // Use FloatingCard or just create your own Widget.
                    : FloatingCard(
                        bottomPosition:
                            MediaQuery.of(context).size.height * 0.05,
                        leftPosition: MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        borderRadius: BorderRadius.circular(12.0),

                        child: state == SearchingState.Searching
                            ? Center(child: CircularProgressIndicator())
                            : RaisedButton(
                                onPressed: () {
                                  print(
                                      "do something with [selectedPlace] data");
                                },
                              ),
                      );
              }, initialPosition: _latLn,
            ),
          ),
        );
      },
    );
  }
}

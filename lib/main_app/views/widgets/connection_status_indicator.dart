import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectionStatusIndicator extends StatelessWidget {
  final Widget child;

  const ConnectionStatusIndicator({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<ConnectivityResult>(
          stream:  Connectivity().onConnectivityChanged,
          builder: (context,AsyncSnapshot<ConnectivityResult> snapshot) {
            if(snapshot.hasData){

              return  Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.orange,
                height: 30,
                child: Text("Device is offline",style: TextStyle(color: Colors.white),),
              );
            }

            return SizedBox();

          }
        ),

        Expanded(
          child: child,
        )
      ],
    );
  }
}

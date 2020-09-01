import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/util/locator.dart';
import 'package:provider/provider.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  var _notifier = locator<RestartNotifier>();

  void restartApp() {
    _notifier.restartApp();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _notifier,
      child: Consumer<RestartNotifier>(builder: (context, restartNotifier, _) {
        return KeyedSubtree(
          key: restartNotifier.key,
          child: widget.child,
        );
      }),
    );
  }
}

class RestartNotifier with ChangeNotifier {
  Key _key = UniqueKey();

  Key get key => _key;

  void restartApp() {
    _key = UniqueKey();
    notifyListeners();
  }
}

import 'package:flutter/widgets.dart';

extension MyNavigatorStateExtension on NavigatorState {

  void pushNamedIfNotCurrent( String routeName, {Object arguments} ) {
    if (!isCurrent(routeName)) {
      pushNamed( routeName, arguments: arguments );
    }
  }

  bool isCurrent( String routeName ) {
    bool isCurrent = false;
    popUntil( (route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    } );
    return isCurrent;
  }

  bool isInStack(String routeName) {
    return true;
  }

}
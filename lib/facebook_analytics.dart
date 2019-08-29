import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FacebookAnalytics {
  factory FacebookAnalytics() => _instance;

  @visibleForTesting
  FacebookAnalytics.private(MethodChannel platformChannel)
      : _channel = platformChannel;

  static final FacebookAnalytics _instance =
      FacebookAnalytics.private(const MethodChannel('facebook_analytics'));

  MethodChannel _channel = const MethodChannel('facebook_analytics');

  Future<void> logEvent(
      {@required String name, Map<String, dynamic> parameters}) async {

    await _channel
        .invokeListMethod('logEvent', {"name": name, "parameters": parameters});
  }

  Future<void> setCurrentScreen(
      {@required String screenName,
      String screenClassOverride = 'Flutter'}) async {
    if (screenName == null) {
      throw ArgumentError.notNull('screenName');
    }


    await _channel.invokeMethod<void>('setCurrentScreen', <String, String>{
      'screenName': screenName,
      'screenClassOverride': screenClassOverride,
    });
  }

  Future<void> setUserID({@required String userID}) async {
    if (userID == null) {
      throw ArgumentError.notNull('userID');
    }

    await _channel.invokeMethod<void>('setUserID', {
      'userId': userID
    });
  }

  Future<void> updateUserProperties({@required Map<String, dynamic> parameters}) async {
    if (parameters == null) {
      throw ArgumentError.notNull('updateUserProperties');
    }

    await _channel.invokeMethod<void>('updateUserProperties', {
      'parameters': parameters
    });
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routeObserverProvider = Provider<RouteObserver<PageRoute>>(
  (ref) => AppRouteObserver(),
);

class AppRouteObserver extends RouteObserver<PageRoute> {}

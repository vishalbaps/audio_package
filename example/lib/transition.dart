import 'package:flutter/cupertino.dart';

Page<T> buildCustomTransitionPage<T>({
  required Widget child,
}) {
  return CupertinoPage<T>(
    child: child,
  );
}
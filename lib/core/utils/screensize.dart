import 'package:flutter/cupertino.dart';

double screenWidth(BuildContext context, {double? dividedBy}) {
  return MediaQuery.of(context).size.width / (dividedBy ?? 1.0);
}

double screenHeight(BuildContext context, {double? dividedBy}) {
  return MediaQuery.of(context).size.height / (dividedBy ?? 1.0);
}

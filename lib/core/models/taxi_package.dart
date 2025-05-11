import 'package:flutter/foundation.dart';

class TaxiPackage {
  final String name;
  final String description;
  final double price;
  final int distance; // Assuming distance might be used later

  TaxiPackage({
    required this.name,
    required this.description,
    required this.price,
    required this.distance,
  });
}
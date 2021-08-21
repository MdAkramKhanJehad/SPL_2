import 'package:cloud_firestore/cloud_firestore.dart';

class FertilizerCalculator{
  final List<String> units;
  final String name;
  final List<Fertilizer> hectare,acre;
  FertilizerCalculator({required this.name,
    required this.acre,required this.hectare,
    required this.units});

  factory FertilizerCalculator.fromJson(doc,List<Fertilizer>acre,List<Fertilizer>hectare){
    return FertilizerCalculator(
      name: doc['name'],
      units: List<String>.from(doc['units']),
      acre:acre,
      hectare:hectare,
    );
  }
  @override
  String toString() {
    return 'FertilizerCalculator{units: $units, name: $name, hectare: $hectare, acre: $acre}';
  }
}

class Fertilizer{
  final String unit,fertilizer_name;
  final double quantity;
  Fertilizer({required this.unit,required this.quantity,required this.fertilizer_name});

  factory Fertilizer.fromJson(doc){
    return Fertilizer(unit: doc['unit'], quantity: doc['quantity'].toDouble(), fertilizer_name: doc['fertilizer_name']);
  }

  @override
  String toString() {
    return 'Fertilizer{unit: $unit, fertilizer_name: $fertilizer_name, quantity: $quantity}';
  }
}

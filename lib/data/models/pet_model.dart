import 'dart:convert';

import 'package:equatable/equatable.dart';

class PetModel extends Equatable {
  const PetModel({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.character,
    required this.species,
    required this.imageURL,
    this.isAdopted = false,
    required this.sex,
    required this.color,
  });

  final String id;
  final String name;
  final int age;
  final int price;
  final String character;
  final String species;
  final String imageURL;
  final bool isAdopted;
  final String sex;
  final String color;

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        price,
        character,
        species,
        imageURL,
        isAdopted,
        sex,
        color
      ];

  PetModel copyWith({
    String? id,
    String? name,
    int? age,
    int? price,
    String? character,
    String? species,
    String? imageURL,
    bool? isAdopted,
    String? sex,
    String? color,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      price: price ?? this.price,
      character: character ?? this.character,
      species: species ?? this.species,
      imageURL: imageURL ?? this.imageURL,
      isAdopted: isAdopted ?? this.isAdopted,
      sex: sex ?? this.sex,
      color: color ?? this.color,
    );
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'] ?? "",
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      character: map['character'] ?? '',
      species: map['species'] ?? '',
      imageURL: map['imageURL'] ?? '',
      isAdopted: map['isAdopted'] ?? false,
      sex: map['sex'] ?? '',
      color: map['color'] ?? '',
    );
  }

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source));
}

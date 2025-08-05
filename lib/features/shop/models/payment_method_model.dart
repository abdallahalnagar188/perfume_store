import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethodModel {
  final String name;
  final String image;

  PaymentMethodModel({required this.image, required this.name});

  static PaymentMethodModel empty() => PaymentMethodModel(image: '', name: '');

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper Function to get the full name
  String get fullName => '$firstName $lastName';

  /// Helper Function to get the format phone number
  String get formatPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> namePars(fullName) => fullName.split(" ");

  /// static function to generate username from full name
  static String generateUsername(fullName) {
    List<String> namePars = fullName.split(" ");
    String firstName = namePars[0].toLowerCase();
    String lastName = namePars.length > 1 ? namePars[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  /// static function to create an empty user model
  static UserModel empty = UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
  );

  /// convert model fo JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

///Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id ?? '',
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      username: data['Username'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
    );
  }
}

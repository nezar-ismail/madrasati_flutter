import 'package:hive/hive.dart';

import 's_manger_field.dart';

class SMangerBox {
  static const String boxName = 'schoolMangerBox';
  static Future<void> init() async {
    await Hive.openBox<LocalSManger>(boxName);
  }

  // Save the entire SMangerBox object to the box
  static Future<void> saveUser(LocalSManger user) async {
    var box = Hive.box<LocalSManger>(boxName);
    await box.put('currentUser', user);
  }

  // Get the entire SMangerBox object from the box
  static LocalSManger? getUser() {
    var box = Hive.box<LocalSManger>(boxName);
    return box.get('currentUser');
  }

  // Delete the current user from the box
  static Future<void> deleteUser() async {
    var box = Hive.box<LocalSManger>(boxName);
    await box.delete('currentUser');
  }

  // Close the Hive box (optional, typically done when the app closes)
  static Future<void> closeBox() async {
    await Hive.box(boxName).close();
  }

  // Save and retrieve individual fields:

  // Save userEmail
  static Future<void> putUserEmail(String email) async {
    var user = getUser() ?? LocalSManger();
    user.userEmail = email;
    await saveUser(user);
  }

  // Get userEmail
  static String? getUserEmail() {
    return getUser()?.userEmail;
  }

  // Save firstName
  static Future<void> putFirstName(String firstName) async {
    var user = getUser() ?? LocalSManger();
    user.firstName = firstName;
    await saveUser(user);
  }

  // Get firstName
  static String? getFirstName() {
    return getUser()?.firstName;
  }

  // Save lastName
  static Future<void> putLastName(String lastName) async {
    var user = getUser() ?? LocalSManger();
    user.lastName = lastName;
    await saveUser(user);
  }

  // Get lastName
  static String? getLastName() {
    return getUser()?.lastName;
  }

  // Save imagePath
  static Future<void> putImagePath(String imagePath) async {
    var user = getUser() ?? LocalSManger();
    user.imagePath = imagePath;
    await saveUser(user);
  }

  // Get imagePath
  static String? getImagePath() {
    return getUser()?.imagePath;
  }

  // Save birthDate
  static Future<void> putBirthDate(DateTime birthDate) async {
    var user = getUser() ?? LocalSManger();
    user.birthDate = birthDate;
    await saveUser(user);
  }

  // Get birthDate
  static DateTime? getBirthDate() {
    return getUser()?.birthDate;
  }

  // Save gender
  static Future<void> putGender(String gender) async {
    var user = getUser() ?? LocalSManger();
    user.gender = gender;
    await saveUser(user);
  }

  // Get gender
  static String? getGender() {
    return getUser()?.gender;
  }
}

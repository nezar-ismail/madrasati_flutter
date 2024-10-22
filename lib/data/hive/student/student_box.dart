import 'package:hive/hive.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
class UserBox {
  static const String boxName = 'userBox';

  // Open the Hive box for LocalStudent data
  static Future<void> init() async {
    await Hive.openBox<LocalStudent>(boxName);
  }

  // Save the entire LocalStudent object to the box
  static Future<void> saveUser(LocalStudent user) async {
    var box = Hive.box<LocalStudent>(boxName);
    await box.put('currentUser', user);
  }

  // Get the entire LocalStudent object from the box
  static LocalStudent? getUser() {
    var box = Hive.box<LocalStudent>(boxName);
    return box.get('currentUser');
  }

  // Delete the current user from the box
  static Future<void> deleteUser() async {
    var box = Hive.box<LocalStudent>(boxName);
    await box.delete('currentUser');
  }

  // Close the Hive box (optional, typically done when the app closes)
  static Future<void> closeBox() async {
    await Hive.box(boxName).close();
  }

  // Save and retrieve individual fields:

  // Save userEmail
  static Future<void> putUserEmail(String email) async {
    var user = getUser() ?? LocalStudent();
    user.userEmail = email;
    await saveUser(user);
  }

  // Get userEmail
  static String? getUserEmail() {
    return getUser()?.userEmail;
  }

  // Save firstName
  static Future<void> putFirstName(String firstName) async {
    var user = getUser() ?? LocalStudent();
    user.firstName = firstName;
    await saveUser(user);
  }

  // Get firstName
  static String? getFirstName() {
    return getUser()?.firstName;
  }

  // Save lastName
  static Future<void> putLastName(String lastName) async {
    var user = getUser() ?? LocalStudent();
    user.lastName = lastName;
    await saveUser(user);
  }

  // Get lastName
  static String? getLastName() {
    return getUser()?.lastName;
  }

  // Save imagePath
  static Future<void> putImagePath(String imagePath) async {
    var user = getUser() ?? LocalStudent();
    user.imagePath = imagePath;
    await saveUser(user);
  }

  // Get imagePath
  static String? getImagePath() {
    return getUser()?.imagePath;
  }

  // Save birthDate
  static Future<void> putBirthDate(String birthDate) async {
    var user = getUser() ?? LocalStudent();
    user.birthDate = birthDate;
    await saveUser(user);
  }

  // Get birthDate
  static String? getBirthDate() {
    return getUser()?.birthDate;
  }

  // Save gender
  static Future<void> putGender(String gender) async {
    var user = getUser() ?? LocalStudent();
    user.gender = gender;
    await saveUser(user);
  }

  // Get gender
  static String? getGender() {
    return getUser()?.gender;
  }
}

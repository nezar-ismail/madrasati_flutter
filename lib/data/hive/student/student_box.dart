import 'package:hive/hive.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';

class UserBox {
  UserBox._();
  static final UserBox instance = UserBox._();
  static final Box<LocalStudent> _box = Hive.box('userBox');
   static Box<LocalStudent> get box => _box;

  // Save the entire LocalStudent object to the box
  static Future<void> saveUser(LocalStudent user) async {
    await _box.put('currentUser', user);
  }

  // Get the entire LocalStudent object from the box
  static LocalStudent? getUser() {
    return _box.get('currentUser');
  }

  // Delete the current user from the box
  static Future<void> deleteUser() async {
    await _box.delete('currentUser');
  }

  // Close the Hive box (optional, typically done when the app closes)
  static Future<void> closeBox() async {
    await _box.close();
  }

  // Save and retrieve individual fields:

  static Future<void> setUserEmail(String email) async {
    var user = getUser() ?? LocalStudent();
    user.userEmail = email;
    await saveUser(user);
  }

  static String? getUserEmail() {
    return getUser()?.userEmail;
  }

  static Future<void> setFirstName(String firstName) async {
    var user = getUser() ?? LocalStudent();
    user.firstName = firstName;
    await saveUser(user);
  }

  static String? getFirstName() {
    return getUser()?.firstName;
  }

  static Future<void> setLastName(String lastName) async {
    var user = getUser() ?? LocalStudent();
    user.lastName = lastName;
    await saveUser(user);
  }

  static String? getLastName() {
    return getUser()?.lastName;
  }

  static Future<void> setImagePath(String imagePath) async {
    var user = getUser() ?? LocalStudent();
    user.imagePath = imagePath;
    await saveUser(user);
  }

  static String? getImagePath() {
    return getUser()?.imagePath;
  }

  static Future<void> setBirthDate(String birthDate) async {
    var user = getUser() ?? LocalStudent();
    user.birthDate = birthDate;
    await saveUser(user);
  }

  static String? getBirthDate() {
    return getUser()?.birthDate;
  }

  static Future<void> setGender(String gender) async {
    var user = getUser() ?? LocalStudent();
    user.gender = gender;
    await saveUser(user);
  }

  static String? getGender() {
    return getUser()?.gender;
  }

    // Save schoolId
  static Future<void> putSchoolId(String schoolId) async {
    var user = getUser() ?? LocalStudent();
    user.schoolId = schoolId;
    await saveUser(user);
  }

  // Get schoolId
  static String? getSchoolId() {
    return getUser()?.schoolId;
  }

  // Save groupId
  static Future<void> putGroupId(String groupId) async {
    var user = getUser() ?? LocalStudent();
    user.groupId = groupId;
    await saveUser(user);
  }

  // Get groupId
  static String? getGroupId() {
    return getUser()?.groupId;
  }

  // Save userId
  static Future<void> putStudentId(String userId) async {
    var user = getUser() ?? LocalStudent();
    user.studentId = userId;
    await saveUser(user);
  }

  // Get userId
  static String? getStudentId() {
    return getUser()?.studentId;
  }
}

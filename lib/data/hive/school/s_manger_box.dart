import 'package:hive/hive.dart';
import 's_manger_field.dart';

class SMangerBox {
  SMangerBox._();
  static final SMangerBox instance = SMangerBox._();
  static final Box<LocalSchoolManger> _box = Hive.box('schoolMangerBox');
  static Box<LocalSchoolManger> get box => _box;
  // Save the entire LocalSchoolManger object to the box
  /// Saves the given [LocalSchoolManger] to the box, replacing the existing
  /// user if one is already present.
  static Future<void> saveUser(LocalSchoolManger user) async {
    await _box.put('currentUser', user);
  }

  // Get the entire LocalSchoolManger object from the box
  /// Retrieves the currently saved [LocalSchoolManger] object, or returns `null`
  /// if no user is saved.
  static LocalSchoolManger? getUser() {
    return _box.get('currentUser');
  }

  // Delete the current user from the box
  /// Deletes the currently saved [LocalSchoolManger] from the box.
  static Future<void> deleteUser() async {
    await _box.delete('currentUser');
  }

  // Close the Hive box (optional, typically done when the app closes)
  /// Closes the Hive box associated with `SMangerBox`. This is usually called
  /// when the app is closed.
  static Future<void> closeBox() async {
    await _box.close();
  }

  // Save and retrieve individual fields

  /// Sets the email of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setUserEmail(String email) async {
    var user = getUser() ?? LocalSchoolManger();
    user.userEmail = email;
    await saveUser(user);
  }

  /// Retrieves the email of the saved [LocalSchoolManger], or returns `null`.
  static String? getUserEmail() {
    return getUser()?.userEmail;
  }

  /// Sets the first name of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setFirstName(String firstName) async {
    var user = getUser() ?? LocalSchoolManger();
    user.firstName = firstName;
    await saveUser(user);
  }

  /// Retrieves the first name of the saved [LocalSchoolManger], or returns `null`.
  static String? getFirstName() {
    return getUser()?.firstName;
  }

  /// Sets the last name of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setLastName(String lastName) async {
    var user = getUser() ?? LocalSchoolManger();
    user.lastName = lastName;
    await saveUser(user);
  }

  /// Retrieves the last name of the saved [LocalSchoolManger], or returns `null`.
  static String? getLastName() {
    return getUser()?.lastName;
  }

  /// Sets the image path of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setImagePath(String imagePath) async {
    var user = getUser() ?? LocalSchoolManger();
    user.imagePath = imagePath;
    await saveUser(user);
  }

  /// Retrieves the image path of the saved [LocalSchoolManger], or returns `null`.
  static String? getImagePath() {
    return getUser()?.imagePath;
  }

  /// Sets the birth date of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setBirthDate(String birthDate) async {
    var user = getUser() ?? LocalSchoolManger();
    user.birthDate = birthDate;
    await saveUser(user);
  }

  /// Retrieves the birth date of the saved [LocalSchoolManger], or returns `null`.
  static String? getBirthDate() {
    return getUser()?.birthDate;
  }

  /// Sets the gender of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setGender(String gender) async {
    var user = getUser() ?? LocalSchoolManger();
    user.gender = gender;
    await saveUser(user);
  }

  /// Retrieves the gender of the saved [LocalSchoolManger], or returns `null`.
  static String? getGender() {
    return getUser()?.gender;
  }

  /// Sets the school ID of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setSchoolId(String schoolId) async {
    var user = getUser() ?? LocalSchoolManger();
    user.schoolId = schoolId;
    await saveUser(user);
  }

  /// Retrieves the school ID of the saved [LocalSchoolManger], or returns `null`.
  static String? getSchoolId() {
    return getUser()?.schoolId;
  }

  /// Sets the group ID of the saved [LocalSchoolManger] and saves the update.
  static Future<void> setGroupId(String groupId) async {
    var user = getUser() ?? LocalSchoolManger();
    user.groupId = groupId;
    await saveUser(user);
  }

  /// Retrieves the group ID of the saved [LocalSchoolManger], or returns `null`.
  static String? getGroupId() {
    return getUser()?.groupId;
  }
}

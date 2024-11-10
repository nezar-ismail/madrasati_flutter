import 'package:hive/hive.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';

class UserBox {
  UserBox._();
  static final UserBox instance = UserBox._();
  static final Box<LocalStudent> _box = Hive.box('userBox');
  static Box<LocalStudent> get box => _box;

  // Save the entire LocalStudent object to the box
  /// Saves the given [LocalStudent] user to the box, replacing the existing
  /// user if one is already present. This function is asynchronous and
  /// returns a [Future] that completes when the user has been saved.
  static Future<void> saveUser(LocalStudent user) async {
    await _box.put('currentUser', user);
  }

  // Get the entire LocalStudent object from the box
  /// Retrieves the entire [LocalStudent] object currently saved in the box.
  ///
  /// Returns the saved [LocalStudent] object, or `null` if no user is
  /// currently saved in the box.
  static LocalStudent? getUser() {
    return _box.get('currentUser');
  }

  // Delete the current user from the box
  /// Deletes the currently saved [LocalStudent] user from the box. If no user has
  /// been saved yet, this will do nothing.
  static Future<void> deleteUser() async {
    await _box.delete('currentUser');
  }

  // Close the Hive box (optional, typically done when the app closes)
  /// Closes the Hive box associated with the `UserBox`. This is typically called
  /// when the app is closed, but is not strictly necessary as the box will be
  /// closed automatically when the app exits.
  static Future<void> closeBox() async {
    await _box.close();
  }

  // Save and retrieve individual fields:

  /// Sets the email address of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [email] and saved to the
  /// box. Otherwise, the existing user will have its email address updated to
  /// the given [email].
  static Future<void> setUserEmail(String email) async {
    var user = getUser() ?? LocalStudent();
    user.userEmail = email;
    await saveUser(user);
  }

  /// Retrieves the email address of the currently saved [LocalStudent] user.
  ///
  /// Returns the user's email address as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getUserEmail() {
    return getUser()?.userEmail;
  }

  /// Sets the first name of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [firstName] and saved to the
  /// box. Otherwise, the existing user will have its first name updated to the
  /// given [firstName].
  static Future<void> setFirstName(String firstName) async {
    var user = getUser() ?? LocalStudent();
    user.firstName = firstName;
    await saveUser(user);
  }

  /// Retrieves the first name of the currently saved [LocalStudent] user.
  ///
  /// Returns the user's first name as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getFirstName() {
    return getUser()?.firstName;
  }

  /// Sets the last name of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [lastName] and saved to the
  /// box. Otherwise, the existing user will have its last name updated to the
  /// given [lastName].
  static Future<void> setLastName(String lastName) async {
    var user = getUser() ?? LocalStudent();
    user.lastName = lastName;
    await saveUser(user);
  }

  /// Retrieves the last name of the currently saved [LocalStudent] user.
  ///
  /// Returns the user's last name as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getLastName() {
    return getUser()?.lastName;
  }

  /// Sets the image path of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [imagePath] and saved to the
  /// box. Otherwise, the existing user will have its image path updated to the
  /// given [imagePath].
  static Future<void> setImagePath(String imagePath) async {
    var user = getUser() ?? LocalStudent();
    user.imagePath = imagePath;
    await saveUser(user);
  }

  /// Retrieves the image path of the currently saved [LocalStudent] user.
  ///
  /// Returns the user's image path as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getImagePath() {
    return getUser()?.imagePath;
  }

  /// Sets the birth date of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [birthDate] and saved to the
  /// box. Otherwise, the existing user will have its birth date updated to the
  /// given [birthDate].
  static Future<void> setBirthDate(String birthDate) async {
    var user = getUser() ?? LocalStudent();
    user.birthDate = birthDate;
    await saveUser(user);
  }

  /// Retrieves the birth date of the currently saved [LocalStudent] user.
  ///
  /// Returns the user's birth date as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getBirthDate() {
    return getUser()?.birthDate;
  }

  /// Sets the gender of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [gender] and saved to the
  /// box. Otherwise, the existing user will have its gender updated to the
  /// given [gender].
  static Future<void> setGender(String gender) async {
    var user = getUser() ?? LocalStudent();
    user.gender = gender;
    await saveUser(user);
  }

  /// Retrieves the gender of the currently saved [LocalStudent] user.
  ///
  /// Returns the user's gender as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getGender() {
    return getUser()?.gender;
  }

  // Save schoolId
  /// Sets the school ID of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [schoolId] and saved to the
  /// box. Otherwise, the existing user will have its school ID updated to the
  /// given [schoolId].
  static Future<void> putSchoolId(String schoolId) async {
    var user = getUser() ?? LocalStudent();
    user.schoolId = schoolId;
    await saveUser(user);
  }

  // Get schoolId
  /// Returns the school ID of the currently logged in student, or null if no user is logged in.
  static String? getSchoolId() {
    return getUser()?.schoolId;
  }

  // Save groupId
  /// Sets the group ID of the currently saved [LocalStudent] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalStudent] will be created with the given [groupId] and saved to the
  /// box. Otherwise, the existing user will have its group ID updated to the
  /// given [groupId].
  static Future<void> putGroupId(String groupId) async {
    var user = getUser() ?? LocalStudent();
    user.groupId = groupId;
    await saveUser(user);
  }

  // Get groupId
  /// Returns the group ID of the currently logged in student, or null if no user is logged in.
  static String? getGroupId() {
    return getUser()?.groupId;
  }

  // Save userId
  /// Saves the given [userId] to Hive as the student ID of the currently logged in user.
  /// If no user is logged in, creates a new user with the given [userId].
  static Future<void> putStudentId(String userId) async {
    var user = getUser() ?? LocalStudent();
    user.studentId = userId;
    await saveUser(user);
  }

  // Get userId
  /// Returns the student ID of the currently logged in user, or null if no user is logged in.
  static String? getStudentId() {
    return getUser()?.studentId;
  }
}

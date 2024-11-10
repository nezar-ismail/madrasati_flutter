import 'package:hive/hive.dart';

import 's_manger_field.dart';

class SMangerBox {
  static const String boxName = 'schoolMangerBox';
  /// Initialize the SMangerBox by opening the Hive box if it doesn't already
  /// exist. This should be called at the start of the app to ensure the box
  /// exists before using it.
  static Future<void> init() async {
    await Hive.openBox<LocalSManger>(boxName);
  }

  // Save the entire SMangerBox object to the box
  /// Save the [LocalSManger] object to the box, replacing the existing
  /// user if one is already present.
  static Future<void> saveUser(LocalSManger user) async {
    var box = Hive.box<LocalSManger>(boxName);
    await box.put('currentUser', user);
  }

  // Get the entire SMangerBox object from the box
  /// Retrieves the currently saved [LocalSManger] from the box. If no user has
  /// been saved, this will return null.
  static LocalSManger? getUser() {
    var box = Hive.box<LocalSManger>(boxName);
    return box.get('currentUser');
  }

  // Delete the current user from the box
  /// Deletes the currently saved [LocalSManger] from the box. If no user has
  /// been saved, this will do nothing.
  static Future<void> deleteUser() async {
    var box = Hive.box<LocalSManger>(boxName);
    await box.delete('currentUser');
  }

  // Close the Hive box (optional, typically done when the app closes)
  /// Closes the Hive box associated with this class. This is typically called
  /// when the app is closed, but is not strictly necessary as the box will be
  /// closed automatically when the app exits.
  static Future<void> closeBox() async {
    await Hive.box(boxName).close();
  }

  // Save and retrieve individual fields:

  // Save userEmail
  /// Sets the user's email address and saves the updated user to the box.
  /// If no user has been saved yet, a new [LocalSManger] will be created with
  /// the given [email] and saved to the box. Otherwise, the existing user
  /// will have its email address updated to the given [email].
  static Future<void> putUserEmail(String email) async {
    var user = getUser() ?? LocalSManger();
    user.userEmail = email;
    await saveUser(user);
  }

  // Get userEmail
/// Retrieves the email address of the currently saved [LocalSManger] user.
/// 
/// Returns the user's email address as a [String], or `null` if no user is
/// currently saved in the box.
  static String? getUserEmail() {
    return getUser()?.userEmail;
  }

  // Save firstName
  /// Sets the first name of the currently saved [LocalSManger] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalSManger] will be created with the given [firstName] and saved to the
  /// box. Otherwise, the existing user will have its first name updated to the
  /// given [firstName].
  static Future<void> putFirstName(String firstName) async {
    var user = getUser() ?? LocalSManger();
    user.firstName = firstName;
    await saveUser(user);
  }

  // Get firstName
/// Retrieves the first name of the currently saved [LocalSManger] user.
/// 
/// Returns the user's first name as a [String], or `null` if no user is
/// currently saved in the box.
  static String? getFirstName() {
    return getUser()?.firstName;
  }

  // Save lastName
/// Sets the last name of the currently saved [LocalSManger] user and saves
/// the updated user to the box. If no user has been saved yet, a new
/// [LocalSManger] will be created with the given [lastName] and saved to the
/// box. Otherwise, the existing user will have its last name updated to the
/// given [lastName].
  static Future<void> putLastName(String lastName) async {
    var user = getUser() ?? LocalSManger();
    user.lastName = lastName;
    await saveUser(user);
  }

  // Get lastName
  /// Retrieves the last name of the currently saved [LocalSManger] user.
  /// 
  /// Returns the user's last name as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getLastName() {
    return getUser()?.lastName;
  }

  // Save imagePath
  /// Sets the image path of the currently saved [LocalSManger] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalSManger] will be created with the given [imagePath] and saved to the
  /// box. Otherwise, the existing user will have its image path updated to the
  /// given [imagePath].
  static Future<void> putImagePath(String imagePath) async {
    var user = getUser() ?? LocalSManger();
    user.imagePath = imagePath;
    await saveUser(user);
  }

  // Get imagePath
  /// Retrieves the image path of the currently saved [LocalSManger] user.
  /// 
  /// Returns the user's image path as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getImagePath() {
    return getUser()?.imagePath;
  }

  // Save birthDate
  /// Sets the birth date of the currently saved [LocalSManger] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalSManger] will be created with the given [birthDate] and saved to the
  /// box. Otherwise, the existing user will have its birth date updated to the
  /// given [birthDate].
  static Future<void> putBirthDate(String birthDate) async {
    var user = getUser() ?? LocalSManger();
    user.birthDate = birthDate;
    await saveUser(user);
  }

  // Get birthDate
  /// Retrieves the birth date of the currently saved [LocalSManger] user.
  /// 
  /// Returns the user's birth date as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getBirthDate() {
    return getUser()?.birthDate;
  }

  // Save gender
  /// Sets the gender of the currently saved [LocalSManger] user and saves
  /// the updated user to the box. If no user has been saved yet, a new
  /// [LocalSManger] will be created with the given [gender] and saved to the
  /// box. Otherwise, the existing user will have its gender updated to the
  /// given [gender].
  static Future<void> putGender(String gender) async {
    var user = getUser() ?? LocalSManger();
    user.gender = gender;
    await saveUser(user);
  }

  // Get gender
  /// Retrieves the gender of the currently saved [LocalSManger] user.
  /// 
  /// Returns the user's gender as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getGender() {
    return getUser()?.gender;
  }

  // Save schoolId
/// Sets the school ID of the currently saved [LocalSManger] user and saves
/// the updated user to the box. If no user has been saved yet, a new
/// [LocalSManger] will be created with the given [schoolId] and saved to the
/// box. Otherwise, the existing user will have its school ID updated to the
/// given [schoolId].
  static Future<void> putSchoolId(String schoolId) async {
    var user = getUser() ?? LocalSManger();
    user.schoolId = schoolId;
    await saveUser(user);
  }

  // Get schoolId
  /// Retrieves the school ID of the currently saved [LocalSManger] user.
  /// 
  /// Returns the user's school ID as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getSchoolId() {
    return getUser()?.schoolId;
  }

  // Save groupId
/// Sets the group ID of the currently saved [LocalSManger] user and saves
/// the updated user to the box. If no user has been saved yet, a new
/// [LocalSManger] will be created with the given [groupId] and saved to the
/// box. Otherwise, the existing user will have its group ID updated to the
/// given [groupId].
  static Future<void> putGroupId(String groupId) async {
    var user = getUser() ?? LocalSManger();
    user.groupId = groupId;
    await saveUser(user);
  }

  // Get groupId
  /// Retrieves the group ID of the currently saved [LocalSManger] user.
  /// 
  /// Returns the user's group ID as a [String], or `null` if no user is
  /// currently saved in the box.
  static String? getGroupId() {
    return getUser()?.groupId;
  }
}

import 'package:webspc/DTO/user.dart';

import 'cars.dart';

class Checksection {
  static String loggedInUser = '';

  static void setLoggecInUser(String email) {
    loggedInUser = email;
  }

  static String getLoggedInUser() {
    return loggedInUser;
  }
}

class username {
  static String loggedInUsername = '';

  static void setLoggecInUsername(String name) {
    loggedInUsername = name;
  }

  static String getLoggedInUsername() {
    return loggedInUsername;
  }
}

class Session {
  static Users loggedInUser = Users(
    userId: "0",
  );
  static Car carUserInfor = Car();
  static Users FamilyInUser = Users(userId: "0");
}

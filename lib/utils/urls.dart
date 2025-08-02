class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String profileUpdatedUrl = '$_baseUrl/profileUpdate';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String newTask = '$_baseUrl/listTaskByStatus/New';
  static const String progressTask = '$_baseUrl/listTaskByStatus/Progress';
  static const String completedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelTask = '$_baseUrl/listTaskByStatus/Cancel';
  static String updatedTaskStatusUrl(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteTaskStatusUrl(String taskId) =>
      '$_baseUrl/deleteTask/$taskId';
  static String emailTaskStatusUrl(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpTaskStatusUrl(String emailId ,String pin) =>
      '$_baseUrl/RecoverVerifyOTP/$emailId/$pin';
  static const String setPasswordTaskUrl = '$_baseUrl/RecoverResetPass';
}

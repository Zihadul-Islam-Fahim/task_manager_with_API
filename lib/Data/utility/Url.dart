class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String getNewTask = '$_baseUrl/listTaskByStatus/New';
  static const String getProgressTask = '$_baseUrl/listTaskByStatus/Progress';
  static const String getCompletedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String getCanceledTask = '$_baseUrl/listTaskByStatus/Canceled';
  static const String taskCount = '$_baseUrl/taskStatusCount';
  static const String verifyEmail = '$_baseUrl/RecoverVerifyEmail';
  static const String verifyOTP = '$_baseUrl/RecoverVerifyOTP';
  static const String setPassword = '$_baseUrl/RecoverResetPass';
  static const String profileUpdate = '$_baseUrl/profileUpdate';

  static String updateTaskStatus(taskId, status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(taskId) => '$_baseUrl/deleteTask/$taskId';
}

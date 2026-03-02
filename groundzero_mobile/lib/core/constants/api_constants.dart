class ApiConstants {
  ApiConstants._();

  // Android emulator uses 10.0.2.2 to reach host localhost
  static const String baseUrl = 'http://10.0.2.2:5147/api';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  // Users
  static const String currentUser = '/users/me';
  static const String updateProfile = '/users/me';
  static const String uploadProfilePicture = '/users/me/picture';
  static const String myGamification = '/users/me/gamification';
  static const String users = '/users';

  // Staff
  static const String staff = '/staff';

  // Products
  static const String products = '/products';
  static const String productCategories = '/product-categories';

  // Orders
  static const String orders = '/orders';

  // Appointments
  static const String appointments = '/appointments';

  // Reviews
  static const String reviews = '/reviews';

  // Workouts
  static const String workoutPlans = '/workout-plans';
  static const String exercises = '/exercises';
  static const String workoutLogs = '/workout-logs';

  // Gamification
  static const String gymVisits = '/gym-visits';
  static const String leaderboard = '/gamification/leaderboard';
  static const String levels = '/gamification/levels';
}

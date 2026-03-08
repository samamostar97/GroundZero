class ApiConstants {
  ApiConstants._();

  // Configurable via: flutter run --dart-define=API_URL=http://10.0.2.2:5147/api
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://10.0.2.2:5147/api',
  );

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // Users
  static const String currentUser = '/users/me';
  static const String updateProfile = '/users/me';
  static const String uploadProfilePicture = '/users/me/picture';
  static const String myGamification = '/users/me/gamification';
  static const String changePassword = '/users/me/password';
  static const String users = '/users';

  // Staff
  static const String staff = '/staff';
  static String staffAvailableSlots(int staffId) =>
      '/staff/$staffId/available-slots';

  // Products
  static const String products = '/products';
  static const String categories = '/categories';

  // Recommendations
  static const String userRecommendations = '/recommendations/user';

  // Orders
  static const String orders = '/orders';
  static const String myOrders = '/orders/my';

  // Appointments
  static const String appointments = '/appointments';
  static const String myAppointments = '/appointments/my';

  // Reviews
  static const String reviews = '/reviews';
  static String productReviews(int productId) =>
      '/reviews/product/$productId';
  static String staffReviews(int staffId) => '/reviews/staff/$staffId';
  static String reviewById(int id) => '/reviews/$id';

  // Workouts
  static const String workoutPlans = '/workout-plans';
  static const String exercises = '/exercises';
  static const String workoutLogs = '/workout-logs';

  // Gamification
  static const String gymVisits = '/gym-visits';
  static const String leaderboard = '/leaderboard';
  static const String levels = '/gamification/levels';

  // Memberships
  static const String membershipPlans = '/membership-plans';
  static const String myMembership = '/memberships/my';
  static const String myMembershipHistory = '/memberships/my/history';
}

class ApiConstants {
  ApiConstants._();

  // Configurable via: flutter run --dart-define=API_URL=http://localhost:5147/api
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:5147/api',
  );

  // Auth
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  // Users
  static const String users = '/users';
  static const String currentUser = '/users/me';

  // Staff
  static const String staff = '/staff';
  static String staffPicture(int staffId) => '/staff/$staffId/picture';

  // Products
  static const String products = '/products';
  static String productImage(int productId) => '/products/$productId/image';

  // Categories
  static const String categories = '/categories';

  // Orders
  static const String orders = '/orders';
  static String orderStatus(int orderId) => '/orders/$orderId/status';

  // Appointments
  static const String appointments = '/appointments';
  static String appointmentStatus(int id) => '/appointments/$id/status';
  static String appointmentCancel(int id) => '/appointments/$id/cancel';

  // Gym Visits
  static const String gymVisits = '/gym-visits';
  static const String checkIn = '/gym-visits/check-in';
  static const String checkOut = '/gym-visits/check-out';

  // Memberships
  static const String memberships = '/memberships';
  static const String membershipPlans = '/membership-plans';
  static String cancelMembership(int id) => '/memberships/$id/cancel';

  // Reports (file export)
  static const String revenueReport = '/reports/revenue';
  static const String productReport = '/reports/products';
  static const String userReport = '/reports/users';
  static const String appointmentReport = '/reports/appointments';
  static const String gamificationReport = '/reports/gamification';

  // Reports (JSON data)
  static const String revenueReportData = '/reports/revenue/data';
  static const String productReportData = '/reports/products/data';
  static const String userReportData = '/reports/users/data';
  static const String appointmentReportData = '/reports/appointments/data';
  static const String gamificationReportData = '/reports/gamification/data';

  // Dashboard
  static const String dashboard = '/dashboard';

  // Leaderboard
  static const String leaderboard = '/leaderboard';
}

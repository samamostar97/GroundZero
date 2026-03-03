import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_repository.dart';
import '../models/gamification_model.dart';

final gamificationProvider = FutureProvider<GamificationModel>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getMyGamification();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/membership_repository.dart';
import '../models/membership_plan_model.dart';
import '../models/user_membership_model.dart';

final currentMembershipProvider = FutureProvider<UserMembershipModel?>((ref) {
  final repo = ref.watch(membershipRepositoryProvider);
  return repo.getMyMembership();
});

final membershipPlansProvider = FutureProvider<List<MembershipPlanModel>>((ref) {
  final repo = ref.watch(membershipRepositoryProvider);
  return repo.getMembershipPlans(isActive: true);
});

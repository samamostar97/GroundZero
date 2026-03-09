import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../users/data/users_repository.dart';
import '../../users/models/user_model.dart';
import '../providers/checkin_provider.dart';

class CheckinScreen extends ConsumerStatefulWidget {
  const CheckinScreen({super.key});

  @override
  ConsumerState<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends ConsumerState<CheckinScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkinNotifierProvider);
    final visits = state.filteredVisits;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Check-in / Check-out',
            style: GoogleFonts.barlowCondensed(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Korisnici trenutno u teretani',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Search + Check-in button
          Row(
            children: [
              SearchInput(
                hint: 'Pretraži korisnike u teretani...',
                onChanged: (value) {
                  ref.read(checkinNotifierProvider.notifier).setSearch(value);
                },
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () => _showCheckinDialog(context, ref),
                  icon: const Icon(Icons.person_add_rounded, size: 18),
                  label: const Text('CHECK-IN KORISNIKA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    textStyle: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Active visits table
          Expanded(
            child: _buildContent(context, ref, state, visits),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref,
      CheckinState state, List visits) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 40, color: AppColors.error),
            const SizedBox(height: 12),
            Text(state.error!,
                style: GoogleFonts.inter(
                    fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(checkinNotifierProvider.notifier).loadActive(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (visits.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fitness_center_rounded,
                size: 48, color: AppColors.textHint.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Text(
              state.search.isNotEmpty
                  ? 'Nema rezultata pretrage.'
                  : 'Nema korisnika u teretani.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      );
    }

    final now = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowHeight: 48,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 52,
              columnSpacing: 24,
              horizontalMargin: 20,
              columns: const [
                DataColumn(label: Text('Korisnik')),
                DataColumn(label: Text('Check-in vrijeme')),
                DataColumn(label: Text('Trajanje')),
                DataColumn(label: Text('Akcije')),
              ],
              rows: state.filteredVisits.map((visit) {
                final duration = now.difference(visit.checkInAt);
                final hours = duration.inHours;
                final minutes = duration.inMinutes % 60;
                final durationText = hours > 0
                    ? '${hours}h ${minutes}min'
                    : '${minutes}min';

                return DataRow(
                  cells: [
                    DataCell(Text(
                      visit.userFullName,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    )),
                    DataCell(Text(
                      DateFormat('HH:mm').format(visit.checkInAt),
                    )),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          durationText,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: state.isActionLoading
                              ? null
                              : () async {
                                  final error = await ref
                                      .read(checkinNotifierProvider.notifier)
                                      .checkOut(visit.userId);
                                  if (!mounted) return;
                                  if (error != null) {
                                    showErrorSnackBar(context, error);
                                  } else {
                                    showSuccessSnackBar(context,
                                        '${visit.userFullName} odjavljen/a.');
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.error.withValues(alpha: 0.15),
                            foregroundColor: AppColors.error,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: Size.zero,
                            textStyle: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('CHECK-OUT'),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showCheckinDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _CheckinDialog(),
    );
  }
}

class _CheckinDialog extends ConsumerStatefulWidget {
  const _CheckinDialog();

  @override
  ConsumerState<_CheckinDialog> createState() => _CheckinDialogState();
}

class _CheckinDialogState extends ConsumerState<_CheckinDialog> {
  final _searchController = TextEditingController();
  List<UserModel> _users = [];
  bool _isLoading = true;
  bool _isCheckinLoading = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      final result = await ref.read(usersRepositoryProvider).getUsers(
            pageNumber: 1,
            pageSize: 50,
            search: _search.isNotEmpty ? _search : null,
            hasActiveMembership: true,
          );
      if (mounted) {
        setState(() {
          _users = result.items;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 500,
        height: 520,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Check-in korisnika',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.textHint,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Prikazani su samo korisnici sa aktivnom članarinom',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: 16),

              // Search
              TextField(
                controller: _searchController,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Pretraži korisnika...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textHint,
                  ),
                  prefixIcon: const Icon(Icons.search,
                      size: 18, color: AppColors.textHint),
                  filled: true,
                  fillColor: AppColors.inputFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: AppColors.border, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: AppColors.border, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: AppColors.accent, width: 1),
                  ),
                ),
                onChanged: (value) {
                  _search = value;
                  _loadUsers();
                },
              ),
              const SizedBox(height: 16),

              // User list
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.accent),
                      )
                    : _users.isEmpty
                        ? Center(
                            child: Text(
                              _search.isNotEmpty
                                  ? 'Nema rezultata pretrage.'
                                  : 'Nema korisnika sa aktivnom članarinom.',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.textHint,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: _users.length,
                            separatorBuilder: (_, _) => Divider(
                              height: 1,
                              color: AppColors.border.withValues(alpha: 0.5),
                            ),
                            itemBuilder: (context, index) {
                              final user = _users[index];
                              return ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                leading: CircleAvatar(
                                  radius: 18,
                                  backgroundColor:
                                      AppColors.accent.withValues(alpha: 0.1),
                                  child: Text(
                                    '${user.firstName[0]}${user.lastName[0]}',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${user.firstName} ${user.lastName}',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                subtitle: Text(
                                  user.email,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppColors.textHint,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.success
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Aktivna članarina',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.success,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      height: 28,
                                      child: ElevatedButton(
                                        onPressed: _isCheckinLoading
                                            ? null
                                            : () => _doCheckin(user),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.accent,
                                          foregroundColor: AppColors.onAccent,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          minimumSize: Size.zero,
                                          textStyle: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: const Text('CHECK-IN'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _doCheckin(UserModel user) async {
    setState(() => _isCheckinLoading = true);
    final error = await ref
        .read(checkinNotifierProvider.notifier)
        .checkIn(user.id);
    if (!mounted) return;
    setState(() => _isCheckinLoading = false);

    if (error != null) {
      showErrorSnackBar(context, error);
    } else {
      Navigator.pop(context);
      showSuccessSnackBar(context,
          '${user.firstName} ${user.lastName} prijavljen/a.');
    }
  }
}

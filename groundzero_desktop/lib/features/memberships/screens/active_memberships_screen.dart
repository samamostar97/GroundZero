import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_exception.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/pill_toggle.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../membership_plans/providers/membership_plans_provider.dart';
import '../../users/data/users_repository.dart';
import '../../users/models/user_model.dart';
import '../providers/active_memberships_provider.dart';
import '../providers/memberships_provider.dart';

class ActiveMembershipsScreen extends ConsumerStatefulWidget {
  const ActiveMembershipsScreen({super.key});

  @override
  ConsumerState<ActiveMembershipsScreen> createState() =>
      _ActiveMembershipsScreenState();
}

class _ActiveMembershipsScreenState
    extends ConsumerState<ActiveMembershipsScreen> {
  int _viewIndex = 0; // 0 = Aktivne, 1 = Historija

  void _onViewChanged(int index) {
    setState(() => _viewIndex = index);
    ref.read(activeMembershipsNotifierProvider.notifier).setSearch('');
    ref.read(membershipsNotifierProvider.notifier).setSearch('');
    if (index == 1) {
      ref.read(membershipsNotifierProvider.notifier).loadPage(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_viewIndex == 1) {
      return _buildHistoryView(context);
    }
    return _buildActiveView(context);
  }

  Widget _buildActiveView(BuildContext context) {
    final state = ref.watch(activeMembershipsNotifierProvider);
    final memberships = state.filteredMemberships;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Članarine',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Korisnici sa trenutno aktivnom članarinom',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              PillToggle(
                labels: const ['Aktivne', 'Historija'],
                selectedIndex: _viewIndex,
                onChanged: _onViewChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search + Assign button
          Row(
            children: [
              SearchInput(
                hint: 'Pretraži aktivne članarine...',
                onChanged: (value) {
                  ref
                      .read(activeMembershipsNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () => _showAssignDialog(context, ref),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('DODIJELI ČLANARINU'),
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
          const SizedBox(height: 12),

          // Active memberships table
          Expanded(
            child: _buildActiveContent(context, ref, state, memberships),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView(BuildContext context) {
    final state = ref.watch(membershipsNotifierProvider);

    const statusLabels = {
      'Expired': 'Istekla',
      'Cancelled': 'Otkazana',
    };
    const statusColors = {
      'Expired': AppColors.warning,
      'Cancelled': AppColors.error,
    };

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Članarine',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pregled isteklih i otkazanih članarina',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              PillToggle(
                labels: const ['Aktivne', 'Historija'],
                selectedIndex: _viewIndex,
                onChanged: _onViewChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    value: state.statusFilter,
                    dropdownColor: AppColors.surfaceHigh,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.textHint, size: 20),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Svi statusi'),
                      ),
                      ...statusLabels.entries.map(
                        (e) => DropdownMenuItem<String?>(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      ref
                          .read(membershipsNotifierProvider.notifier)
                          .setStatusFilter(v);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži historiju članarina...',
                onChanged: (value) {
                  ref
                      .read(membershipsNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // History table
          Expanded(
            child: _buildHistoryContent(context, ref, state, statusLabels, statusColors),
          ),

          // Pagination
          if (!state.isLoading && state.error == null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: PaginationControls(
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                totalCount: state.totalCount,
                onPrevious: () {
                  ref
                      .read(membershipsNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(membershipsNotifierProvider.notifier)
                      .loadPage(state.currentPage + 1);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryContent(BuildContext context, WidgetRef ref,
      MembershipsState state, Map<String, String> statusLabels,
      Map<String, Color> statusColors) {
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
                  ref.read(membershipsNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.memberships.isEmpty) {
      return Center(
        child: Text(
          'Nema članarina u historiji.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textHint,
          ),
        ),
      );
    }

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
              columns: [
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Korisnik'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('userFullName')),
                DataColumn(label: const Text('Plan'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('planName')),
                DataColumn(label: const Text('Cijena'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('planPrice')),
                DataColumn(label: const Text('Početak'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('startDate')),
                DataColumn(label: const Text('Kraj'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('endDate')),
                const DataColumn(label: Text('Status')),
              ],
              rows: state.memberships.map((m) {
                final label = statusLabels[m.status] ?? m.status;
                final color = statusColors[m.status] ?? AppColors.textHint;
                return DataRow(
                  cells: [
                    DataCell(Text('#${m.id}')),
                    DataCell(Text(m.userFullName)),
                    DataCell(Text(m.planName)),
                    DataCell(Text('${m.planPrice.toStringAsFixed(2)} KM')),
                    DataCell(Text(DateFormat('dd.MM.yyyy.').format(m.startDate))),
                    DataCell(Text(DateFormat('dd.MM.yyyy.').format(m.endDate))),
                    DataCell(_StatusBadge(label: label, color: color)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveContent(BuildContext context, WidgetRef ref,
      ActiveMembershipsState state, List memberships) {
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
              onPressed: () => ref
                  .read(activeMembershipsNotifierProvider.notifier)
                  .loadActive(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (memberships.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.card_membership_rounded,
                size: 48, color: AppColors.textHint.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Text(
              state.search.isNotEmpty
                  ? 'Nema rezultata pretrage.'
                  : 'Nema aktivnih članarina.',
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
                DataColumn(label: Text('Plan')),
                DataColumn(label: Text('Cijena')),
                DataColumn(label: Text('Početak')),
                DataColumn(label: Text('Kraj')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Akcije')),
              ],
              rows: memberships.cast().map((m) {
                final daysLeft = m.endDate.difference(now).inDays;
                final expiringSoon = daysLeft <= 7 && daysLeft >= 0;

                return DataRow(
                  cells: [
                    DataCell(Text(
                      m.userFullName,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    )),
                    DataCell(Text(m.planName)),
                    DataCell(
                        Text('${m.planPrice.toStringAsFixed(2)} KM')),
                    DataCell(Text(
                        DateFormat('dd.MM.yyyy.').format(m.startDate))),
                    DataCell(Text(
                        DateFormat('dd.MM.yyyy.').format(m.endDate))),
                    DataCell(
                      expiringSoon
                          ? _ExpiringSoonBadge(daysLeft: daysLeft)
                          : _StatusBadge(
                              label: 'Aktivna',
                              color: AppColors.success,
                            ),
                    ),
                    DataCell(
                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: state.isActionLoading
                              ? null
                              : () async {
                                  final confirmed = await showConfirmDialog(
                                    context: context,
                                    title: 'Otkazivanje članarine',
                                    message:
                                        'Da li ste sigurni da želite otkazati članarinu za ${m.userFullName}?',
                                    confirmLabel: 'Otkaži',
                                    isDestructive: true,
                                  );
                                  if (confirmed) {
                                    final error = await ref
                                        .read(activeMembershipsNotifierProvider
                                            .notifier)
                                        .cancel(m.id);
                                    if (!mounted) return;
                                    if (error != null) {
                                      showErrorSnackBar(context, error);
                                    } else {
                                      showSuccessSnackBar(
                                          context, 'Članarina otkazana.');
                                    }
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
                          child: const Text('OTKAŽI'),
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

  void _showAssignDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _AssignMembershipDialog(),
    );
  }
}

class _ExpiringSoonBadge extends StatelessWidget {
  final int daysLeft;

  const _ExpiringSoonBadge({required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    final label = daysLeft <= 0 ? 'Ističe danas' : 'Ističe za $daysLeft d';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.warning,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _AssignMembershipDialog extends ConsumerStatefulWidget {
  const _AssignMembershipDialog();

  @override
  ConsumerState<_AssignMembershipDialog> createState() =>
      _AssignMembershipDialogState();
}

class _AssignMembershipDialogState
    extends ConsumerState<_AssignMembershipDialog> {
  final _userSearchController = TextEditingController();
  UserModel? _selectedUser;
  int? _selectedPlanId;
  DateTime _startDate = DateTime.now();
  List<UserModel> _userSuggestions = [];
  bool _showUserSuggestions = false;
  bool _isSubmitting = false;
  String? _error;
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _userSearchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay();
    if (_userSuggestions.isEmpty || !_showUserSuggestions) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 400,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 44),
          child: Material(
            color: AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(8),
            elevation: 8,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _userSuggestions.length,
                itemBuilder: (context, index) {
                  final user = _userSuggestions[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
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
                    hoverColor: AppColors.accent.withValues(alpha: 0.08),
                    onTap: () {
                      setState(() {
                        _selectedUser = user;
                        _userSearchController.text =
                            '${user.firstName} ${user.lastName}';
                        _showUserSuggestions = false;
                      });
                      _removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  Future<void> _searchUsers(String query) async {
    if (query.length < 2) {
      setState(() {
        _userSuggestions = [];
        _showUserSuggestions = false;
      });
      _removeOverlay();
      return;
    }

    try {
      final result = await ref.read(usersRepositoryProvider).getUsers(
            pageNumber: 1,
            pageSize: 5,
            search: query,
          );
      setState(() {
        _userSuggestions = result.items;
        _showUserSuggestions = true;
      });
      _showOverlay();
    } catch (_) {}
  }

  Future<void> _submit() async {
    if (_selectedUser == null || _selectedPlanId == null) return;

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      await ref.read(activeMembershipsNotifierProvider.notifier).assign({
        'userId': _selectedUser!.id,
        'membershipPlanId': _selectedPlanId,
        'startDate': _startDate.toIso8601String(),
      });
      if (mounted) {
        Navigator.of(context).pop();
        showSuccessSnackBar(context, 'Članarina uspješno dodijeljena.');
      }
    } on ApiException catch (e) {
      setState(() {
        _isSubmitting = false;
        _error = e.firstError;
      });
    } catch (_) {
      setState(() {
        _isSubmitting = false;
        _error = 'Greška pri dodjeljivanju članarine.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final plansState = ref.watch(membershipPlansNotifierProvider);
    final activePlans =
        plansState.plans.where((p) => p.isActive).toList();

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border, width: 0.5),
      ),
      child: Container(
        width: 460,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dodijeli članarinu',
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: AppColors.textHint),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // User search
            Text(
              'Korisnik',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            CompositedTransformTarget(
              link: _layerLink,
              child: TextField(
                controller: _userSearchController,
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
                  suffixIcon: _selectedUser != null
                      ? IconButton(
                          icon: const Icon(Icons.close,
                              size: 16, color: AppColors.textHint),
                          onPressed: () {
                            setState(() {
                              _selectedUser = null;
                              _userSearchController.clear();
                              _userSuggestions = [];
                            });
                            _removeOverlay();
                          },
                        )
                      : null,
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
                  _selectedUser = null;
                  _searchUsers(value);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Plan dropdown
            Text(
              'Plan članarine',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int?>(
                  value: _selectedPlanId,
                  isExpanded: true,
                  dropdownColor: AppColors.surfaceHigh,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                  hint: Text(
                    'Odaberi plan',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textHint,
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textHint, size: 20),
                  items: activePlans.map((plan) {
                    return DropdownMenuItem<int?>(
                      value: plan.id,
                      child: Text(
                        '${plan.name} — ${plan.price.toStringAsFixed(2)} KM (${plan.durationDays} dana)',
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() => _selectedPlanId = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Start date picker
            Text(
              'Datum početka',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: AppColors.accent,
                          onPrimary: AppColors.onAccent,
                          surface: AppColors.surfaceHigh,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() => _startDate = picked);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: AppColors.textHint),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd.MM.yyyy.').format(_startDate),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.error,
                ),
              ),
            ],

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Odustani',
                    style:
                        GoogleFonts.inter(color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _selectedUser == null ||
                          _selectedPlanId == null ||
                          _isSubmitting
                      ? null
                      : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    textStyle: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onAccent,
                          ),
                        )
                      : const Text('Dodijeli'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

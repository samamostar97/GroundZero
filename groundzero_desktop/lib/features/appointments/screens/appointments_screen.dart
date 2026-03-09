import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/pill_toggle.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../staff/providers/staff_provider.dart';
import '../providers/appointments_provider.dart';

const _statusLabels = {
  'Pending': 'Na čekanju',
  'Confirmed': 'Potvrđeno',
  'Completed': 'Završeno',
  'Cancelled': 'Otkazano',
};

const _statusColors = {
  'Pending': AppColors.warning,
  'Confirmed': AppColors.accent,
  'Completed': AppColors.success,
  'Cancelled': AppColors.error,
};

// Request int → response string mapping
const _statusIntToString = {
  0: 'Pending',
  1: 'Confirmed',
  2: 'Completed',
  3: 'Cancelled',
};

// Active = Pending, Confirmed
const _activeExclude = {2, 3}; // exclude Completed, Cancelled
// History = Completed, Cancelled
const _historyExclude = {0, 1}; // exclude Pending, Confirmed

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  int _viewIndex = 0; // 0 = Aktivni, 1 = Historija

  void _onViewChanged(int index) {
    setState(() => _viewIndex = index);
    final notifier = ref.read(appointmentsNotifierProvider.notifier);
    notifier.switchView(
      excludeStatuses: index == 0 ? _activeExclude : _historyExclude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentsNotifierProvider);
    final staffState = ref.watch(staffNotifierProvider);
    final isHistory = _viewIndex == 1;

    // Filter dropdown items based on view
    final statusFilterItems = <int?, String>{null: 'Svi statusi'};
    if (!isHistory) {
      statusFilterItems.addAll({0: 'Na čekanju', 1: 'Potvrđeno'});
    } else {
      statusFilterItems.addAll({2: 'Završeno', 3: 'Otkazano'});
    }

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
                    'Termini',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isHistory
                        ? 'Pregled završenih i otkazanih termina'
                        : 'Pregled i upravljanje terminima',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              PillToggle(
                labels: const ['Aktivni', 'Historija'],
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
              // Staff filter
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int?>(
                    value: state.staffFilter,
                    dropdownColor: AppColors.surfaceHigh,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.textHint, size: 20),
                    hint: Text(
                      'Svo osoblje',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    items: [
                      DropdownMenuItem<int?>(
                        value: null,
                        child: Text('Svo osoblje'),
                      ),
                      ...staffState.staff.map(
                        (s) => DropdownMenuItem<int?>(
                          value: s.id,
                          child: Text('${s.firstName} ${s.lastName}'),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      ref
                          .read(appointmentsNotifierProvider.notifier)
                          .setStaffFilter(v);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Status filter
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int?>(
                    value: state.statusFilter,
                    dropdownColor: AppColors.surfaceHigh,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.textHint, size: 20),
                    items: statusFilterItems.entries.map(
                      (e) => DropdownMenuItem<int?>(
                        value: e.key,
                        child: Text(e.value),
                      ),
                    ).toList(),
                    onChanged: (v) {
                      ref
                          .read(appointmentsNotifierProvider.notifier)
                          .setStatusFilter(v);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži termine...',
                onChanged: (value) {
                  ref
                      .read(appointmentsNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Table
          Expanded(
            child: _buildContent(context, ref, state, isHistory),
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
                      .read(appointmentsNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(appointmentsNotifierProvider.notifier)
                      .loadPage(state.currentPage + 1);
                },
              ),
            ),
        ],
      ),
    );
  }

  int? _sortColumnIndex(String? sortBy) {
    return switch (sortBy) {
      'id' => 0,
      'userFullName' => 1,
      'staffFullName' => 2,
      'scheduledAt' => 3,
      'durationMinutes' => 4,
      _ => null,
    };
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, AppointmentsState state, bool isHistory) {
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
            Text(
              state.error!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(appointmentsNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.appointments.isEmpty) {
      return Center(
        child: Text(
          'Nema termina.',
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
              sortColumnIndex: _sortColumnIndex(state.sortBy),
              sortAscending: !state.sortDescending,
              columns: [
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(appointmentsNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Korisnik'), onSort: (_, __) => ref.read(appointmentsNotifierProvider.notifier).setSort('userFullName')),
                DataColumn(label: const Text('Osoblje'), onSort: (_, __) => ref.read(appointmentsNotifierProvider.notifier).setSort('staffFullName')),
                DataColumn(label: const Text('Termin'), onSort: (_, __) => ref.read(appointmentsNotifierProvider.notifier).setSort('scheduledAt')),
                DataColumn(label: const Text('Trajanje'), onSort: (_, __) => ref.read(appointmentsNotifierProvider.notifier).setSort('durationMinutes')),
                const DataColumn(label: Text('Status')),
                if (!isHistory) const DataColumn(label: Text('Akcije')),
              ],
              rows: state.appointments.map((appt) {
                final statusLabel =
                    _statusLabels[appt.status] ?? appt.status;
                final statusColor =
                    _statusColors[appt.status] ?? AppColors.textHint;

                return DataRow(
                  cells: [
                    DataCell(Text('#${appt.id}')),
                    DataCell(Text(appt.userFullName)),
                    DataCell(Text(appt.staffFullName)),
                    DataCell(
                      Text(DateFormat('dd.MM.yyyy. HH:mm')
                          .format(appt.scheduledAt)),
                    ),
                    DataCell(Text('${appt.durationMinutes} min')),
                    DataCell(_StatusBadge(
                      label: statusLabel,
                      color: statusColor,
                    )),
                    if (!isHistory)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (appt.status != 'Cancelled' &&
                                appt.status != 'Completed')
                              PopupMenuButton<int>(
                              tooltip: 'Promijeni status',
                              icon: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: AppColors.textSecondary,
                              ),
                              color: AppColors.surfaceHigh,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: AppColors.border, width: 0.5),
                              ),
                              onSelected: (newStatus) async {
                                final error = await ref
                                    .read(
                                        appointmentsNotifierProvider.notifier)
                                    .updateStatus(appt.id, newStatus);
                                if (context.mounted) {
                                  if (error != null) {
                                    showErrorSnackBar(context, error);
                                  } else {
                                    showSuccessSnackBar(
                                        context, 'Status termina ažuriran.');
                                  }
                                }
                              },
                              itemBuilder: (context) => _statusIntToString
                                  .entries
                                  .where((e) => e.value != appt.status)
                                  .where((e) => e.value != 'Cancelled')
                                  .map(
                                    (e) => PopupMenuItem<int>(
                                      value: e.key,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: _statusColors[e.value],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _statusLabels[e.value] ?? e.value,
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          if (appt.status != 'Cancelled' &&
                              appt.status != 'Completed')
                            _ActionButton(
                              icon: Icons.cancel_outlined,
                              color: AppColors.error,
                              tooltip: 'Otkaži',
                              onTap: () async {
                                final confirmed = await showConfirmDialog(
                                  context: context,
                                  title: 'Otkazivanje termina',
                                  message:
                                      'Da li ste sigurni da želite otkazati termin #${appt.id}?',
                                  confirmLabel: 'Otkaži termin',
                                  isDestructive: true,
                                );
                                if (confirmed) {
                                  final error = await ref
                                      .read(appointmentsNotifierProvider
                                          .notifier)
                                      .cancel(appt.id);
                                  if (context.mounted) {
                                    if (error != null) {
                                      showErrorSnackBar(context, error);
                                    } else {
                                      showSuccessSnackBar(
                                          context, 'Termin je otkazan.');
                                    }
                                  }
                                }
                              },
                            ),
                        ],
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

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(widget.icon, size: 18, color: widget.color),
          ),
        ),
      ),
    );
  }
}

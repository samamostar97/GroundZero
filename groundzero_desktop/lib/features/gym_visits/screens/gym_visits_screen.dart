import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../users/data/users_repository.dart';
import '../../users/models/user_model.dart';
import '../providers/gym_visits_provider.dart';

class GymVisitsScreen extends ConsumerStatefulWidget {
  const GymVisitsScreen({super.key});

  @override
  ConsumerState<GymVisitsScreen> createState() => _GymVisitsScreenState();
}

class _GymVisitsScreenState extends ConsumerState<GymVisitsScreen> {
  final _searchController = TextEditingController();
  UserModel? _selectedUser;
  List<UserModel> _suggestions = [];
  bool _showSuggestions = false;
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay();
    if (_suggestions.isEmpty || !_showSuggestions) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
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
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final user = _suggestions[index];
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
                        _searchController.text =
                            '${user.firstName} ${user.lastName}';
                        _showSuggestions = false;
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
        _suggestions = [];
        _showSuggestions = false;
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
        _suggestions = result.items;
        _showSuggestions = true;
      });
      _showOverlay();
    } catch (_) {
      // silently fail
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gymVisitsNotifierProvider);

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
            'Prijava i odjava korisnika u teretanu',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Action Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Row(
              children: [
                // User autocomplete
                CompositedTransformTarget(
                  link: _layerLink,
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
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
                                    _searchController.clear();
                                    _suggestions = [];
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
                          borderSide: BorderSide(
                              color: AppColors.accent, width: 1),
                        ),
                      ),
                      onChanged: (value) {
                        _selectedUser = null;
                        _searchUsers(value);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Check-in button
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: state.isActionLoading || _selectedUser == null
                        ? null
                        : () async {
                            final error = await ref
                                .read(gymVisitsNotifierProvider.notifier)
                                .checkIn(_selectedUser!.id);
                            if (!mounted) return;
                            if (error != null) {
                              showErrorSnackBar(context, error);
                            } else {
                              showSuccessSnackBar(context,
                                  'Korisnik ${_selectedUser!.firstName} ${_selectedUser!.lastName} prijavljen.');
                              setState(() {
                                _selectedUser = null;
                                _searchController.clear();
                              });
                            }
                          },
                    icon: const Icon(Icons.login, size: 18),
                    label: const Text('CHECK-IN'),
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
                const SizedBox(width: 8),

                // Check-out button
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: state.isActionLoading || _selectedUser == null
                        ? null
                        : () async {
                            final error = await ref
                                .read(gymVisitsNotifierProvider.notifier)
                                .checkOut(_selectedUser!.id);
                            if (!mounted) return;
                            if (error != null) {
                              showErrorSnackBar(context, error);
                            } else {
                              showSuccessSnackBar(context,
                                  'Korisnik ${_selectedUser!.firstName} ${_selectedUser!.lastName} odjavljen.');
                              setState(() {
                                _selectedUser = null;
                                _searchController.clear();
                              });
                            }
                          },
                    icon: const Icon(Icons.logout, size: 18),
                    label: const Text('CHECK-OUT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceHigh,
                      foregroundColor: AppColors.textPrimary,
                      textStyle: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColors.border, width: 0.5),
                      ),
                    ),
                  ),
                ),

                if (state.isActionLoading) ...[
                  const SizedBox(width: 12),
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // History header + search
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historija posjeta',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SearchInput(
                hint: 'Pretraži posjete...',
                onChanged: (value) {
                  ref
                      .read(gymVisitsNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // History table
          Expanded(
            child: _buildContent(context, ref, state),
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
                      .read(gymVisitsNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(gymVisitsNotifierProvider.notifier)
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
      'checkInAt' => 2,
      'durationMinutes' => 4,
      'xpEarned' => 5,
      _ => null,
    };
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, GymVisitsState state) {
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
                  ref.read(gymVisitsNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.visits.isEmpty) {
      return Center(
        child: Text(
          'Nema posjeta.',
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
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Korisnik'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('userFullName')),
                DataColumn(label: const Text('Prijava'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('checkInAt')),
                const DataColumn(label: Text('Odjava')),
                DataColumn(label: const Text('Trajanje'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('durationMinutes')),
                DataColumn(label: const Text('XP'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('xpEarned')),
              ],
              rows: state.visits.map((visit) {
                final isActive = visit.checkOutAt == null;
                return DataRow(
                  cells: [
                    DataCell(Text('#${visit.id}')),
                    DataCell(Text(visit.userFullName)),
                    DataCell(
                      Text(DateFormat('dd.MM.yyyy. HH:mm')
                          .format(visit.checkInAt)),
                    ),
                    DataCell(
                      visit.checkOutAt != null
                          ? Text(DateFormat('dd.MM.yyyy. HH:mm')
                              .format(visit.checkOutAt!))
                          : Text('—'),
                    ),
                    DataCell(
                      isActive
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Aktivan',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.success,
                                ),
                              ),
                            )
                          : Text('${visit.durationMinutes} min'),
                    ),
                    DataCell(Text('${visit.xpEarned}')),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../users/data/users_repository.dart';
import '../../users/models/user_model.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
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
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Dashboard',
            style: GoogleFonts.barlowCondensed(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pregled stanja teretane',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // KPI cards
          Row(
            children: [
              _StatCard(
                label: 'Trenutno u teretani',
                value: state.data?.currentlyInGym.toString() ?? '—',
                icon: Icons.fitness_center_rounded,
              ),
              const SizedBox(width: 16),
              _StatCard(
                label: 'Narudžbe na čekanju',
                value: state.data?.pendingOrderCount.toString() ?? '—',
                icon: Icons.shopping_bag_rounded,
              ),
              const SizedBox(width: 16),
              _StatCard(
                label: 'Termini danas',
                value: state.data?.todayAppointments.toString() ?? '—',
                icon: Icons.calendar_today_rounded,
              ),
              const SizedBox(width: 16),
              _StatCard(
                label: 'Novi korisnici (mjesec)',
                value: state.data?.newUsersThisMonth.toString() ?? '—',
                icon: Icons.person_add_rounded,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Main content
          if (state.isLoading && state.data == null)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            )
          else if (state.error != null && state.data == null)
            Expanded(
              child: Center(
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
                      onPressed: () => ref
                          .read(dashboardNotifierProvider.notifier)
                          .loadData(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                      ),
                      child: const Text('Pokušaj ponovo'),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left panel — Gym visits
                  Expanded(child: _buildGymPanel(state)),
                  const SizedBox(width: 16),
                  // Right panel — Pending orders
                  Expanded(child: _buildOrdersPanel(state)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGymPanel(DashboardState state) {
    final visits = state.data?.activeGymVisits ?? [];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel header
          Row(
            children: [
              Icon(Icons.fitness_center_rounded,
                  size: 18, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'Trenutno u teretani',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (state.isLoading && state.data != null)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accent,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Search + Check-in
          Row(
            children: [
              Expanded(
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: SizedBox(
                    height: 40,
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
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: state.isActionLoading || _selectedUser == null
                      ? null
                      : () async {
                          final error = await ref
                              .read(dashboardNotifierProvider.notifier)
                              .checkIn(_selectedUser!.id);
                          if (!mounted) return;
                          if (error != null) {
                            showErrorSnackBar(context, error);
                          } else {
                            showSuccessSnackBar(context,
                                '${_selectedUser!.firstName} ${_selectedUser!.lastName} prijavljen/a.');
                            setState(() {
                              _selectedUser = null;
                              _searchController.clear();
                            });
                          }
                        },
                  icon: const Icon(Icons.login, size: 16),
                  label: const Text('PRIJAVI'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    textStyle: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              if (state.isActionLoading) ...[
                const SizedBox(width: 10),
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Active visits list
          Expanded(
            child: visits.isEmpty
                ? Center(
                    child: Text(
                      'Nema trenutno prijavljenih korisnika.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textHint,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: visits.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, index) {
                      final visit = visits[index];
                      final checkInTime =
                          DateFormat('HH:mm').format(visit.checkInAt.toLocal());
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.accent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  visit.userFullName
                                      .split(' ')
                                      .map((n) => n.isNotEmpty ? n[0] : '')
                                      .take(2)
                                      .join()
                                      .toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    visit.userFullName,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Prijava: $checkInTime',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                onPressed: state.isActionLoading
                                    ? null
                                    : () async {
                                        final error = await ref
                                            .read(dashboardNotifierProvider
                                                .notifier)
                                            .checkOut(visit.userId);
                                        if (!mounted) return;
                                        if (error != null) {
                                          showErrorSnackBar(context, error);
                                        } else {
                                          showSuccessSnackBar(context,
                                              '${visit.userFullName} odjavljen/a.');
                                        }
                                      },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.error,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  textStyle: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text('Odjavi'),
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
    );
  }

  Widget _buildOrdersPanel(DashboardState state) {
    final orders = state.data?.pendingOrders ?? [];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel header
          Row(
            children: [
              Icon(Icons.shopping_bag_rounded,
                  size: 18, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'Pristigle narudžbe',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (state.isLoading && state.data != null)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accent,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Orders list
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: Text(
                      'Nema narudžbi na čekanju.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textHint,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: orders.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final dateStr = DateFormat('dd.MM.yyyy. HH:mm')
                          .format(order.createdAt.toLocal());
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.userFullName,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${order.totalAmount.toStringAsFixed(2)} KM  •  ${order.itemCount} stavki  •  $dateStr',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: state.isActionLoading
                                    ? null
                                    : () async {
                                        final error = await ref
                                            .read(dashboardNotifierProvider
                                                .notifier)
                                            .confirmOrder(order.id);
                                        if (!mounted) return;
                                        if (error != null) {
                                          showErrorSnackBar(context, error);
                                        } else {
                                          showSuccessSnackBar(context,
                                              'Narudžba #${order.id} potvrđena.');
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success
                                      .withValues(alpha: 0.15),
                                  foregroundColor: AppColors.success,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  textStyle: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text('Potvrdi'),
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: state.isActionLoading
                                    ? null
                                    : () async {
                                        final error = await ref
                                            .read(dashboardNotifierProvider
                                                .notifier)
                                            .cancelOrder(order.id);
                                        if (!mounted) return;
                                        if (error != null) {
                                          showErrorSnackBar(context, error);
                                        } else {
                                          showSuccessSnackBar(context,
                                              'Narudžba #${order.id} otkazana.');
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.error.withValues(alpha: 0.15),
                                  foregroundColor: AppColors.error,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  textStyle: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text('Otkaži'),
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
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent, size: 20),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.barlowCondensed(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

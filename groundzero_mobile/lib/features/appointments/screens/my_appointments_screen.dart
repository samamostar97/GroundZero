import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/appointment_status_badge.dart';
import '../../../shared/widgets/category_chip.dart';
import '../../../shared/widgets/empty_state.dart';
import '../models/appointment_model.dart';
import '../providers/appointment_provider.dart';

class MyAppointmentsScreen extends ConsumerStatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  ConsumerState<MyAppointmentsScreen> createState() =>
      _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState
    extends ConsumerState<MyAppointmentsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(myAppointmentsNotifierProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myAppointmentsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Moji termini', style: AppTextStyles.heading3),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline_rounded),
            tooltip: 'Osoblje',
            onPressed: () => context.push('/staff'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Status filter chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              children: [
                CategoryChip(
                  label: 'Svi',
                  isSelected: state.statusFilter == null,
                  onTap: () => ref
                      .read(myAppointmentsNotifierProvider.notifier)
                      .setStatusFilter(null),
                ),
                const SizedBox(width: 8),
                CategoryChip(
                  label: 'Na čekanju',
                  isSelected: state.statusFilter == 'Pending',
                  onTap: () => ref
                      .read(myAppointmentsNotifierProvider.notifier)
                      .setStatusFilter('Pending'),
                ),
                const SizedBox(width: 8),
                CategoryChip(
                  label: 'Potvrđeno',
                  isSelected: state.statusFilter == 'Confirmed',
                  onTap: () => ref
                      .read(myAppointmentsNotifierProvider.notifier)
                      .setStatusFilter('Confirmed'),
                ),
                const SizedBox(width: 8),
                CategoryChip(
                  label: 'Završeno',
                  isSelected: state.statusFilter == 'Completed',
                  onTap: () => ref
                      .read(myAppointmentsNotifierProvider.notifier)
                      .setStatusFilter('Completed'),
                ),
                const SizedBox(width: 8),
                CategoryChip(
                  label: 'Otkazano',
                  isSelected: state.statusFilter == 'Cancelled',
                  onTap: () => ref
                      .read(myAppointmentsNotifierProvider.notifier)
                      .setStatusFilter('Cancelled'),
                ),
              ],
            ),
          ),

          // Appointments list
          Expanded(
            child: RefreshIndicator(
              color: AppColors.accent,
              onRefresh: () async {
                ref
                    .read(myAppointmentsNotifierProvider.notifier)
                    .loadInitial();
              },
              child: _buildContent(state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(MyAppointmentsState state) {
    if (state.isLoading && state.appointments.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (state.appointments.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 120),
          EmptyState(
            icon: Icons.calendar_today_outlined,
            message: 'Nemate nijedan termin.',
          ),
        ],
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: state.appointments.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index >= state.appointments.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                color: AppColors.accent,
                strokeWidth: 2,
              ),
            ),
          );
        }

        return _AppointmentListTile(
          appointment: state.appointments[index],
        );
      },
    );
  }
}

class _AppointmentListTile extends StatelessWidget {
  final AppointmentModel appointment;

  const _AppointmentListTile({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/appointments/${appointment.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: staff name + status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    appointment.staffFullName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                AppointmentStatusBadge(status: appointment.status),
              ],
            ),
            const SizedBox(height: 8),

            // Staff type
            Text(
              _typeLabel(appointment.staffType),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),

            // Footer: date/time + duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: AppColors.textHint,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDateTime(appointment.scheduledAt),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${appointment.durationMinutes} min',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(String staffType) {
    return switch (staffType) {
      'Trainer' => 'Trener',
      'Nutritionist' => 'Nutricionist',
      _ => staffType,
    };
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}. '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

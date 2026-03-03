import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/appointment_repository.dart';
import '../models/appointment_model.dart';
import '../models/create_appointment_request.dart';

// --- Create Appointment (sealed state machine) ---

sealed class CreateAppointmentState {
  const CreateAppointmentState();
}

class CreateAppointmentIdle extends CreateAppointmentState {
  const CreateAppointmentIdle();
}

class CreateAppointmentLoading extends CreateAppointmentState {
  const CreateAppointmentLoading();
}

class CreateAppointmentSuccess extends CreateAppointmentState {
  final AppointmentModel appointment;
  const CreateAppointmentSuccess(this.appointment);
}

class CreateAppointmentError extends CreateAppointmentState {
  final String message;
  const CreateAppointmentError(this.message);
}

final createAppointmentProvider =
    NotifierProvider<CreateAppointmentNotifier, CreateAppointmentState>(
  CreateAppointmentNotifier.new,
);

class CreateAppointmentNotifier extends Notifier<CreateAppointmentState> {
  @override
  CreateAppointmentState build() {
    return const CreateAppointmentIdle();
  }

  Future<void> book({
    required int staffId,
    required DateTime scheduledAt,
    required int durationMinutes,
    String? notes,
  }) async {
    state = const CreateAppointmentLoading();

    try {
      final repo = ref.read(appointmentRepositoryProvider);
      final request = CreateAppointmentRequest(
        staffId: staffId,
        scheduledAt: scheduledAt,
        durationMinutes: durationMinutes,
        notes: notes,
      );

      final appointment = await repo.createAppointment(request);

      // Invalidate my appointments so they refresh
      ref.invalidate(myAppointmentsNotifierProvider);

      state = CreateAppointmentSuccess(appointment);
    } catch (e) {
      if (e is ApiException && e.statusCode == 409) {
        state = CreateAppointmentError(
          e.firstError,
        );
      } else {
        state = CreateAppointmentError(
          e is ApiException
              ? e.firstError
              : 'Neočekivana greška. Pokušajte ponovo.',
        );
      }
    }
  }

  void reset() {
    state = const CreateAppointmentIdle();
  }
}

// --- My Appointments (paginated, with status filter) ---

class MyAppointmentsState {
  final List<AppointmentModel> appointments;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? statusFilter;

  const MyAppointmentsState({
    this.appointments = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.statusFilter,
  });

  MyAppointmentsState copyWith({
    List<AppointmentModel>? appointments,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? Function()? statusFilter,
  }) {
    return MyAppointmentsState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      statusFilter:
          statusFilter != null ? statusFilter() : this.statusFilter,
    );
  }
}

final myAppointmentsNotifierProvider =
    NotifierProvider<MyAppointmentsNotifier, MyAppointmentsState>(
  MyAppointmentsNotifier.new,
);

class MyAppointmentsNotifier extends Notifier<MyAppointmentsState> {
  static const _pageSize = 10;

  @override
  MyAppointmentsState build() {
    Future.microtask(() => loadInitial());
    return const MyAppointmentsState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      appointments: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(appointmentRepositoryProvider);
      final result = await repo.getMyAppointments(
        pageNumber: 1,
        pageSize: _pageSize,
        status: state.statusFilter,
      );

      state = state.copyWith(
        appointments: result.items,
        isLoading: false,
        currentPage: 1,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final repo = ref.read(appointmentRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getMyAppointments(
        pageNumber: nextPage,
        pageSize: _pageSize,
        status: state.statusFilter,
      );

      state = state.copyWith(
        appointments: [...state.appointments, ...result.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void setStatusFilter(String? status) {
    state = state.copyWith(statusFilter: () => status);
    loadInitial();
  }
}

// --- Appointment Detail ---

final appointmentDetailProvider =
    FutureProvider.family<AppointmentModel, int>((ref, appointmentId) {
  final repo = ref.watch(appointmentRepositoryProvider);
  return repo.getAppointmentById(appointmentId);
});

// --- Cancel Appointment ---

sealed class CancelAppointmentState {
  const CancelAppointmentState();
}

class CancelAppointmentIdle extends CancelAppointmentState {
  const CancelAppointmentIdle();
}

class CancelAppointmentLoading extends CancelAppointmentState {
  const CancelAppointmentLoading();
}

class CancelAppointmentSuccess extends CancelAppointmentState {
  final AppointmentModel appointment;
  const CancelAppointmentSuccess(this.appointment);
}

class CancelAppointmentError extends CancelAppointmentState {
  final String message;
  const CancelAppointmentError(this.message);
}

final cancelAppointmentProvider =
    NotifierProvider<CancelAppointmentNotifier, CancelAppointmentState>(
  CancelAppointmentNotifier.new,
);

class CancelAppointmentNotifier extends Notifier<CancelAppointmentState> {
  @override
  CancelAppointmentState build() {
    return const CancelAppointmentIdle();
  }

  Future<void> cancel(int appointmentId) async {
    state = const CancelAppointmentLoading();

    try {
      final repo = ref.read(appointmentRepositoryProvider);
      final appointment = await repo.cancelAppointment(appointmentId);

      // Invalidate related providers
      ref.invalidate(myAppointmentsNotifierProvider);
      ref.invalidate(appointmentDetailProvider(appointmentId));

      state = CancelAppointmentSuccess(appointment);
    } catch (e) {
      state = CancelAppointmentError(
        e is ApiException
            ? e.firstError
            : 'Neočekivana greška. Pokušajte ponovo.',
      );
    }
  }

  void reset() {
    state = const CancelAppointmentIdle();
  }
}

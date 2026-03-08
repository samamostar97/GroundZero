import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import '../data/reports_repository.dart';
import '../models/user_report_model.dart';

class UserReportState {
  final UserReportModel? data;
  final bool isLoading;
  final String? error;
  final DateTime from;
  final DateTime to;
  final bool isExporting;

  const UserReportState({
    this.data,
    this.isLoading = false,
    this.error,
    required this.from,
    required this.to,
    this.isExporting = false,
  });

  UserReportState copyWith({
    UserReportModel? data,
    bool clearData = false,
    bool? isLoading,
    String? error,
    DateTime? from,
    DateTime? to,
    bool? isExporting,
  }) {
    return UserReportState(
      data: clearData ? null : (data ?? this.data),
      isLoading: isLoading ?? this.isLoading,
      error: error,
      from: from ?? this.from,
      to: to ?? this.to,
      isExporting: isExporting ?? this.isExporting,
    );
  }
}

final userReportProvider =
    NotifierProvider<UserReportNotifier, UserReportState>(
        UserReportNotifier.new);

class UserReportNotifier extends Notifier<UserReportState> {
  late final ReportsRepository _repository;

  @override
  UserReportState build() {
    _repository = ref.watch(reportsRepositoryProvider);
    final now = DateTime.now();
    final from = DateTime(now.year - 1, now.month, now.day);
    Future.microtask(() => loadData());
    return UserReportState(isLoading: true, from: from, to: now);
  }

  Future<void> loadData() async {
    if (state.to.isBefore(state.from)) {
      state = state.copyWith(
        clearData: true,
        isLoading: false,
        error: "Datum 'do' mora biti nakon datuma 'od'.",
      );
      return;
    }
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await _repository.getUserData(
        from: state.from,
        to: state.to,
      );
      state = state.copyWith(data: data, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju izvještaja.',
      );
    }
  }

  void setFrom(DateTime from) => state = state.copyWith(from: from);
  void setTo(DateTime to) => state = state.copyWith(to: to);

  Future<void> exportReport(String format, BuildContext context) async {
    final ext = format == 'Excel' ? 'xlsx' : 'pdf';
    final path = await FilePicker.platform.saveFile(
      dialogTitle: 'Sačuvaj izvještaj',
      fileName: 'izvjestaj-korisnici.$ext',
      type: FileType.custom,
      allowedExtensions: [ext],
    );
    if (path == null) return;

    state = state.copyWith(isExporting: true);
    try {
      final bytes = await _repository.downloadReport(
        endpoint: ApiConstants.userReport,
        from: state.from,
        to: state.to,
        format: format == 'Excel' ? 'Excel' : 'Pdf',
      );
      await File(path).writeAsBytes(bytes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izvještaj uspješno sačuvan.')),
        );
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.firstError)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Greška pri preuzimanju izvještaja.')),
        );
      }
    } finally {
      state = state.copyWith(isExporting: false);
    }
  }
}

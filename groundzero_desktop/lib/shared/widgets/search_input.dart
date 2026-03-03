import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class SearchInput extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final Duration debounce;

  const SearchInput({
    super.key,
    this.hint = 'Pretraži...',
    required this.onChanged,
    this.debounce = const Duration(milliseconds: 500),
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 40,
      child: TextField(
        controller: _controller,
        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
          prefixIcon:
              const Icon(Icons.search_rounded, size: 20, color: AppColors.textHint),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.textHint),
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged('');
                    setState(() {});
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          filled: true,
          fillColor: AppColors.surfaceHigh,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.accent, width: 1),
          ),
        ),
        onChanged: (value) {
          setState(() {});
          _debounceTimer?.cancel();
          _debounceTimer = Timer(widget.debounce, () {
            widget.onChanged(value);
          });
        },
      ),
    );
  }
}

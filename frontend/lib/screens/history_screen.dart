import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../providers/generation_provider.dart';
import '../widgets/generation_card.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});
  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String? _filter;

  @override
  Widget build(BuildContext context) {
    final asyncHistory = ref.watch(historyProvider(_filter));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generation History'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: () => ref.invalidate(historyProvider(_filter)),
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _chip('All', null),
                _chip('Seedance', 'seedance'),
                _chip('Wan 2.7', 'wan'),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: asyncHistory.when(
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.accent)),
              error: (e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error, size: 32),
                      const SizedBox(height: 12),
                      Text('Error: $e',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.error, fontSize: 13)),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => ref.invalidate(historyProvider(_filter)),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Text('No generations yet.\nGo create something!',
                        textAlign: TextAlign.center, style: TextStyle(color: AppColors.textMuted)),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => GenerationCard(
                    gen: items[i],
                    onDelete: () {
                      // Just refresh the list after deletion
                      ref.invalidate(historyProvider(_filter));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String? value) {
    final selected = _filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 12, color: selected ? Colors.white : AppColors.textSecondary)),
        selected: selected,
        selectedColor: AppColors.accent,
        backgroundColor: AppColors.surfaceLight,
        side: BorderSide(color: selected ? AppColors.accent : AppColors.border),
        onSelected: (_) {
          setState(() => _filter = value);
          ref.invalidate(historyProvider(value));
        },
      ),
    );
  }
}
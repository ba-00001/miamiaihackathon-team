import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/mare_theme.dart';
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

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [_chip('All', null), _chip('Seedance', 'seedance'), _chip('Wan 2.7', 'wan')]),
        ),
        const Divider(height: 1, color: MareColors.border),
        Expanded(
          child: asyncHistory.when(
            loading: () => const Center(child: CircularProgressIndicator(color: MareColors.ink)),
            error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: MareColors.error))),
            data: (items) {
              if (items.isEmpty) return const Center(child: Text('No generations yet.', style: TextStyle(color: MareColors.espresso)));
              return ListView.separated(
                padding: const EdgeInsets.all(16), itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => GenerationCard(gen: items[i], onDelete: () => ref.invalidate(historyProvider(_filter))),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, String? value) {
    final selected = _filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: selected ? MareColors.pearl : MareColors.espresso)),
        selected: selected, selectedColor: MareColors.ink, backgroundColor: MareColors.pearl,
        side: BorderSide(color: selected ? MareColors.ink : MareColors.border),
        onSelected: (_) { setState(() => _filter = value); ref.invalidate(historyProvider(value)); },
      ),
    );
  }
}
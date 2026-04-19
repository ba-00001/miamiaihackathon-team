import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/mare_theme.dart';
import '../providers/generation_provider.dart';
import '../widgets/parameter_form.dart';

class GenerateScreen extends ConsumerStatefulWidget {
  const GenerateScreen({super.key});
  @override
  ConsumerState<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends ConsumerState<GenerateScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _models = ['seedance', 'wan'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _models.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final genState = ref.watch(genProvider);

    return Column(
      children: [
        TabBar(
          controller: _tabCtrl,
          indicatorColor: MareColors.ink,
          labelColor: MareColors.ink,
          unselectedLabelColor: MareColors.espresso,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: const [
            Tab(text: 'SEEDANCE 2.0'),
            Tab(text: 'WAN 2.7'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabCtrl,
            children: _models.map((m) => _buildTab(m, genState)).toList(),
          ),
        ),
        if (genState.status == GenStatus.loading)
          Container(
            padding: const EdgeInsets.all(16),
            color: MareColors.pearl,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: MareColors.ink)),
                SizedBox(width: 12),
                Text('Generating luxury assets… this takes 30-120s', style: TextStyle(color: MareColors.espresso, fontSize: 13)),
              ],
            ),
          ),
        if (genState.status == GenStatus.error)
          Container(
            padding: const EdgeInsets.all(14),
            color: MareColors.error.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.error_outline, size: 16, color: MareColors.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    genState.error ?? 'Error',
                    style: const TextStyle(color: MareColors.error, fontSize: 13),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16, color: MareColors.error),
                  onPressed: () => ref.read(genProvider.notifier).reset(),
                ),
              ],
            ),
          ),
        if (genState.status == GenStatus.success && genState.result != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: MareColors.sage.withOpacity(0.3),
              border: const Border(top: BorderSide(color: MareColors.sage, width: 1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: MareColors.ink, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Asset Saved! ID #${genState.result!.id}',
                    style: const TextStyle(color: MareColors.ink, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () => ref.read(genProvider.notifier).reset(),
                  child: const Text('Dismiss', style: TextStyle(color: MareColors.ink)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTab(String model, GenState genState) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modelHeader(model),
          const SizedBox(height: 20),
          ParameterForm(
            modelType: model,
            isLoading: genState.status == GenStatus.loading,
            onSubmit: (params) {
              ref.read(genProvider.notifier).generate(model, params);
            },
          ),
        ],
      ),
    );
  }

  Widget _modelHeader(String model) {
    final info = {
      'seedance': ('Seedance 2.0', 'Start/end frame → video generation', Icons.movie_creation_outlined),
      'wan': ('Wan 2.7', 'Image-to-video generation', Icons.videocam_outlined),
    };
    final (title, subtitle, icon) = info[model]!;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MareColors.ink.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: MareColors.ink, size: 22),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: MareColors.ink)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 13, color: MareColors.espresso)),
          ],
        ),
      ],
    );
  }
}
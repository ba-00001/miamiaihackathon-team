import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Miami AI Studio'),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: AppColors.accent,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textMuted,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'SEEDANCE'),
            Tab(text: 'WAN 2.7'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: _models.map((m) => _buildTab(m, genState)).toList(),
            ),
          ),
          // Status bar
          if (genState.status == GenStatus.loading)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.surface,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent)),
                  SizedBox(width: 12),
                  Text('Generating… this may take 30-120s', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
          if (genState.status == GenStatus.error)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              color: AppColors.error.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, size: 16, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      genState.error ?? 'Error',
                      style: const TextStyle(color: AppColors.error, fontSize: 13),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16, color: AppColors.error),
                    onPressed: () => ref.read(genProvider.notifier).reset(),
                  ),
                ],
              ),
            ),
          if (genState.status == GenStatus.success && genState.result != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.08),
                border: const Border(top: BorderSide(color: AppColors.success, width: 0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Saved! ID #${genState.result!.id}  •  ${genState.result!.modelType}',
                      style: const TextStyle(color: AppColors.success, fontSize: 13),
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref.read(genProvider.notifier).reset(),
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            ),
        ],
      ),
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
            color: AppColors.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.accentLight, size: 22),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
          ],
        ),
      ],
    );
  }
}
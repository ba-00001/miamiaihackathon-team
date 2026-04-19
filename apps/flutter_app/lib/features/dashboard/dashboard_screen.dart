import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/models/models.dart';
import '../../shared/services/demo_repository.dart';
import '../../theme/mare_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<GrowthEngineSnapshot> _snapshotFuture;
  final _repository = const DemoRepository();

  @override
  void initState() {
    super.initState();
    _snapshotFuture = _repository.loadSnapshot();
  }

  Future<void> _refresh() async {
    setState(() {
      _snapshotFuture = _repository.loadSnapshot();
    });
    await _snapshotFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GrowthEngineSnapshot>(
        future: _snapshotFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return _ErrorState(onRetry: _refresh);
          }

          final data = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  sliver: SliverList.list(
                    children: [
                      _HeroSection(data: data),
                      const SizedBox(height: 18),
                      _MetricsSection(metrics: data.metrics),
                      const SizedBox(height: 18),
                      _SectionContainer(
                        title: 'Global Prospector',
                        subtitle:
                            'Rank high-revenue salons using aesthetic signals, location density, and retail readiness.',
                        child: Column(
                          children: data.prospects
                              .map((prospect) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _ProspectCard(prospect: prospect),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _TwoColumnSection(
                        left: _SectionContainer(
                          title: 'Luxury Outreach',
                          subtitle:
                              'Human-in-the-loop drafts that sound like salon insiders, not automation.',
                          child: Column(
                            children: data.outreachDrafts
                                .map((draft) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: _OutreachCard(draft: draft),
                                    ))
                                .toList(),
                          ),
                        ),
                        right: _SectionContainer(
                          title: 'Creative Engine',
                          subtitle:
                              'AI-search-ready content built around scalp wellness, luxury rituals, and conversion.',
                          child: Column(
                            children: data.contentAssets
                                .map((asset) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: _ContentCard(asset: asset),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _TwoColumnSection(
                        left: _SectionContainer(
                          title: 'AI Watchtower',
                          subtitle:
                              'Errors surface as guided AI incidents instead of silent failures.',
                          child: _AiErrorCard(error: data.aiError),
                        ),
                        right: _SectionContainer(
                          title: 'Approval Queue',
                          subtitle:
                              'Every risky action has a clear owner, next action, and fallback lane.',
                          child: Column(
                            children: data.reviewQueue
                                .map((item) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: _ReviewCard(item: item),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _SectionContainer(
                        title: 'Developer Marker',
                        subtitle:
                            'The yellow circle is the visual cue that this is the MaRe demo environment.',
                        child: Row(
                          children: [
                            const _StatusDot(size: 18),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Whenever you see the yellow dot, you are looking at live AI-assisted or mock AI-controlled surfaces that need brand review.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(width: 12),
                            SvgPicture.asset(
                              'assets/images/growth_flow.svg',
                              width: 112,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.data});

  final GrowthEngineSnapshot data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFBF4), Color(0xFFF7EBDD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFE8DED0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final vertical = constraints.maxWidth < 860;
          final content = [
            Expanded(
              flex: vertical ? 0 : 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _StatusDot(),
                      const SizedBox(width: 10),
                      Text(
                        'Luxury-grade AI growth system',
                        style: theme.textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(data.headline, style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 16),
                  Text(
                    'Turn boutique proof into nationwide expansion by combining revenue-ranked salon discovery, brand-safe outreach, and scalable luxury content creation.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _Pill(label: data.marketFocus, color: MareColors.sage),
                      _Pill(
                        label: 'Human approval required before send',
                        color: MareColors.rose,
                      ),
                      _Pill(
                        label: 'Updated ${data.generatedAt.substring(0, 10)}',
                        color: const Color(0xFFFFF0B8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20, height: 20),
            Expanded(
              flex: vertical ? 0 : 4,
              child: SvgPicture.asset(
                'assets/images/mare_hero.svg',
                fit: BoxFit.contain,
                height: 260,
              ),
            ),
          ];

          return vertical
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                );
        },
      ),
    );
  }
}

class _MetricsSection extends StatelessWidget {
  const _MetricsSection({required this.metrics});

  final MetricSummary metrics;

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('Luxury prospects', '${metrics.luxuryProspects}'),
      ('Approved outreach', '${metrics.approvedOutreach}'),
      ('Content assets ready', '${metrics.contentAssetsReady}'),
      ('Retail lift target', metrics.retailLiftPotential),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 720 ? 2 : 4;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = cards[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.$1, style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      item.$2,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TwoColumnSection extends StatelessWidget {
  const _TwoColumnSection({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return Column(
            children: [
              left,
              const SizedBox(height: 18),
              right,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 18),
            Expanded(child: right),
          ],
        );
      },
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _ProspectCard extends StatelessWidget {
  const _ProspectCard({required this.prospect});

  final ProspectSignal prospect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8DED0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  prospect.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const _StatusDot(size: 14),
              const SizedBox(width: 8),
              Text('${prospect.fitScore.toStringAsFixed(0)} fit'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${prospect.cityState} • ${prospect.revenueBand} • ${prospect.locations} location(s)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Text(prospect.socialHook, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: prospect.reasons
                .map((reason) => _Pill(
                      label: reason,
                      color: const Color(0xFFF5EEE2),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _OutreachCard extends StatelessWidget {
  const _OutreachCard({required this.draft});

  final OutreachDraft draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8DED0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(draft.salonName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text('${draft.channel} • ${draft.subjectLine}'),
          const SizedBox(height: 10),
          Text(draft.hook, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 10),
          Text(draft.body, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          _DetailRow(label: 'Postcard', value: draft.postcardConcept),
          const SizedBox(height: 6),
          _DetailRow(label: 'Guardrail', value: draft.guardrail),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.asset});

  final ContentAsset asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8DED0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Pill(label: asset.format, color: MareColors.sage),
              _Pill(label: asset.status, color: const Color(0xFFFFF0B8)),
            ],
          ),
          const SizedBox(height: 10),
          Text(asset.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Primary keyword: ${asset.primaryKeyword}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Text(asset.openingHook, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          ...asset.talkingPoints.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: _StatusDot(size: 8),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          _DetailRow(label: 'CTA', value: asset.callToAction),
        ],
      ),
    );
  }
}

class _AiErrorCard extends StatelessWidget {
  const _AiErrorCard({required this.error});

  final AiErrorState error;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0D5A4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _StatusDot(),
              const SizedBox(width: 10),
              Expanded(
                child: Text(error.title,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(error.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 14),
          ...error.fallbacks.map(
            (fallback) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _DetailRow(label: 'Fallback', value: fallback),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.item});

  final ReviewItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8DED0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(item.lane, style: Theme.of(context).textTheme.titleLarge),
              ),
              _Pill(
                label: item.status,
                color: item.status == 'Approved'
                    ? MareColors.sage
                    : const Color(0xFFFFF0B8),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _DetailRow(label: 'Owner', value: item.owner),
          const SizedBox(height: 6),
          _DetailRow(label: 'Next', value: item.nextAction),
          const SizedBox(height: 6),
          _DetailRow(label: 'Fallback', value: item.fallback),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: MareColors.ink,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({this.size = 12});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: MareColors.gold,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _StatusDot(size: 22),
            const SizedBox(height: 16),
            Text(
              'The AI preview could not load.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Fallback mode keeps the business story visible and asks for a fresh sync instead of showing a blank screen.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(backgroundColor: MareColors.ink),
              child: const Text('Retry AI Sync'),
            ),
          ],
        ),
      ),
    );
  }
}

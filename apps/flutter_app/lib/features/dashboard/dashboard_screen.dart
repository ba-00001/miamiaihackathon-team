import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/data/mock_growth_engine_snapshot.dart';
import '../../shared/models/models.dart';
import '../../shared/services/mare_app_repository.dart';
import '../../theme/mare_theme.dart';

enum _MareView { welcome, guest, signIn, rolePicker, roleDashboard }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<MareAppSnapshot> _snapshotFuture;
  final _repository = const MareAppRepository();
  final _emailController = TextEditingController(text: 'demo@mare.app');
  final _passwordController = TextEditingController(text: 'luxury-demo');

  _MareView _view = _MareView.welcome;
  String? _selectedRoleId;

  @override
  void initState() {
    super.initState();
    _snapshotFuture = _repository.loadSnapshot();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      _snapshotFuture = _repository.loadSnapshot();
    });
    await _snapshotFuture;
  }

  void _goToGuest() {
    setState(() {
      _selectedRoleId = null;
      _view = _MareView.guest;
    });
  }

  void _goToSignIn() {
    setState(() {
      _selectedRoleId = null;
      _view = _MareView.signIn;
    });
  }

  void _goToRolePicker() {
    setState(() {
      _view = _MareView.rolePicker;
    });
  }

  void _selectRole(String roleId) {
    setState(() {
      _selectedRoleId = roleId;
      _view = _MareView.roleDashboard;
    });
  }

  void _goHome() {
    setState(() {
      _selectedRoleId = null;
      _view = _MareView.welcome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MareAppSnapshot>(
        future: _snapshotFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return _ErrorState(onRetry: _refresh);
          }

          final data = snapshot.data!;
          RoleExperience? currentRole;
          if (_selectedRoleId != null) {
            for (final role in data.roles) {
              if (role.id == _selectedRoleId) {
                currentRole = role;
                break;
              }
            }
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopBar(
                        appName: data.appName,
                        onHome: _goHome,
                        onGuest: _goToGuest,
                        onSignIn: _goToSignIn,
                        onRolePicker: _goToRolePicker,
                        view: _view,
                        selectedRoleTitle: currentRole?.title,
                      ),
                      const SizedBox(height: 18),
                      switch (_view) {
                        _MareView.welcome => _WelcomeView(
                          data: data,
                          onGuest: _goToGuest,
                          onSignIn: _goToSignIn,
                        ),
                        _MareView.guest => _GuestView(
                          guest: data.guest,
                          onSignIn: _goToSignIn,
                        ),
                        _MareView.signIn => _SignInView(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          onContinue: _goToRolePicker,
                          onGuest: _goToGuest,
                        ),
                        _MareView.rolePicker => _RolePickerView(
                          roles: data.roles,
                          onRoleSelected: _selectRole,
                        ),
                        _MareView.roleDashboard when currentRole != null =>
                          _RoleDashboardView(
                            role: currentRole,
                            aiNotice: data.aiNotice,
                            storage: data.storage,
                            onRolePicker: _goToRolePicker,
                          ),
                        _ => _WelcomeView(
                          data: data,
                          onGuest: _goToGuest,
                          onSignIn: _goToSignIn,
                        ),
                      },
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.appName,
    required this.onHome,
    required this.onGuest,
    required this.onSignIn,
    required this.onRolePicker,
    required this.view,
    required this.selectedRoleTitle,
  });

  final String appName;
  final VoidCallback onHome;
  final VoidCallback onGuest;
  final VoidCallback onSignIn;
  final VoidCallback onRolePicker;
  final _MareView view;
  final String? selectedRoleTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Wrap(
          runSpacing: 12,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InkWell(
              onTap: onHome,
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _StatusDot(size: 16),
                  const SizedBox(width: 10),
                  Text(
                    appName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _ToolbarAction(
                  label: 'Guest',
                  selected: view == _MareView.guest,
                  onPressed: onGuest,
                ),
                _ToolbarAction(
                  label: 'Sign In',
                  selected: view == _MareView.signIn,
                  onPressed: onSignIn,
                ),
                _ToolbarAction(
                  label: selectedRoleTitle ?? 'Role Picker',
                  selected:
                      view == _MareView.rolePicker ||
                      view == _MareView.roleDashboard,
                  onPressed: onRolePicker,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView({
    required this.data,
    required this.onGuest,
    required this.onSignIn,
  });

  final MareAppSnapshot data;
  final VoidCallback onGuest;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: data.appName,
          subtitle: data.tagline,
          description:
              'Welcome into one unified MaRe app. Guests can explore the brand, signed-in users can pick their role, and every role-specific experience stays inside the same luxury shell for internal teams, partners, and end users.',
          pills: [
            'Guest mode available',
            'Role selection after sign in',
            'AWS S3 media storage',
          ],
          actions: [
            FilledButton(
              onPressed: onGuest,
              style: FilledButton.styleFrom(backgroundColor: MareColors.ink),
              child: const Text('Continue as Guest'),
            ),
            OutlinedButton(
              onPressed: onSignIn,
              child: const Text('Sign In to Choose Role'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _ResponsiveCards(
          cards: [
            _ActionCard(
              title: 'Guest Experience',
              subtitle: 'No sign-in required',
              detail:
                  'Explore luxury rituals, session expectations, partner-location discovery, product browsing, and partner application entry points.',
              tags: data.guest.highlights,
            ),
            ...data.roles.map(
              (role) => _ActionCard(
                title: role.title,
                subtitle: role.audience,
                detail: role.summary,
                tags: role.quickActions,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GuestView extends StatelessWidget {
  const _GuestView({required this.guest, required this.onSignIn});

  final GuestExperience guest;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: 'Guest Mode',
          subtitle: guest.title,
          description: guest.description,
          pills: guest.highlights,
          actions: [
            FilledButton(
              onPressed: onSignIn,
              style: FilledButton.styleFrom(backgroundColor: MareColors.ink),
              child: const Text('Sign In for Role Access'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        ...guest.sections.map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _ExperienceSectionCard(section: section),
          ),
        ),
      ],
    );
  }
}

class _SignInView extends StatelessWidget {
  const _SignInView({
    required this.emailController,
    required this.passwordController,
    required this.onContinue,
    required this.onGuest,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onContinue;
  final VoidCallback onGuest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: 'Sign In',
          subtitle: 'One MaRe identity, multiple role experiences',
          description:
              'Sign in once, then choose the role you want for this session. A single user can hold multiple roles such as salon owner and end user.',
          pills: const ['Internal', 'Salon Owner', 'End User'],
          actions: [
            FilledButton(
              onPressed: onContinue,
              style: FilledButton.styleFrom(backgroundColor: MareColors.ink),
              child: const Text('Continue to Role Selection'),
            ),
            TextButton(
              onPressed: onGuest,
              child: const Text('Stay in Guest Mode'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mock sign-in for the hackathon demo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'This mock auth step demonstrates the flow only. In production it should route through the shared MaRe auth backend and role service.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RolePickerView extends StatelessWidget {
  const _RolePickerView({required this.roles, required this.onRoleSelected});

  final List<RoleExperience> roles;
  final ValueChanged<String> onRoleSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: 'Role Selection',
          subtitle: 'Pick the MaRe experience for this session',
          description:
              'The same app routes into different dashboards based on role. Users with multiple roles can switch between internal, partner, and end-user experiences without leaving MaRe.',
          pills: roles.map((role) => role.title).toList(),
        ),
        const SizedBox(height: 18),
        _ResponsiveCards(
          cards: roles
              .map(
                (role) => _ActionCard(
                  title: role.title,
                  subtitle: role.audience,
                  detail: role.summary,
                  tags: role.quickActions,
                  action: FilledButton(
                    onPressed: () => onRoleSelected(role.id),
                    style: FilledButton.styleFrom(
                      backgroundColor: MareColors.ink,
                    ),
                    child: const Text('Open Role Dashboard'),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _RoleDashboardView extends StatelessWidget {
  const _RoleDashboardView({
    required this.role,
    required this.aiNotice,
    required this.storage,
    required this.onRolePicker,
  });

  final RoleExperience role;
  final AiErrorState aiNotice;
  final StorageProfile storage;
  final VoidCallback onRolePicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: role.title,
          subtitle: role.heroTitle,
          description: role.heroDescription,
          pills: role.quickActions,
          actions: [
            FilledButton(
              onPressed: onRolePicker,
              style: FilledButton.styleFrom(backgroundColor: MareColors.ink),
              child: const Text('Switch Role'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        ...role.sections.map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _ExperienceSectionCard(section: section),
          ),
        ),
        if (role.id == 'internal') ...[
          const SizedBox(height: 2),
          _InternalOpsSection(snapshot: demoGrowthEngineSnapshot),
        ],
        _ResponsiveCards(
          cards: [
            _AiNoticeCard(aiNotice: aiNotice),
            _StorageCard(storage: storage),
          ],
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const _StatusDot(size: 18),
                Text(
                  'Yellow dot = AI-managed, fallback-enabled, or approval-sensitive surface.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SvgPicture.asset('assets/images/growth_flow.svg', width: 140),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.pills,
    this.actions = const [],
  });

  final String title;
  final String subtitle;
  final String description;
  final List<String> pills;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
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
          final stacked = constraints.maxWidth < 860;
          final illustration = SvgPicture.asset(
            'assets/images/mare_hero.svg',
            fit: BoxFit.contain,
            height: stacked ? 180 : 240,
          );

          final textContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                runSpacing: 8,
                children: [
                  const _StatusDot(),
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: stacked ? 34 : null,
                ),
              ),
              const SizedBox(height: 16),
              Text(description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: pills
                    .map(
                      (pill) => _Pill(
                        label: pill,
                        color: pill.contains('AWS')
                            ? const Color(0xFFFFF0B8)
                            : MareColors.sage,
                      ),
                    )
                    .toList(),
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 20),
                Wrap(spacing: 12, runSpacing: 12, children: actions),
              ],
            ],
          );

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [textContent, const SizedBox(height: 18), illustration],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: textContent),
              const SizedBox(width: 20),
              Expanded(flex: 4, child: illustration),
            ],
          );
        },
      ),
    );
  }
}

class _InternalOpsSection extends StatelessWidget {
  const _InternalOpsSection({required this.snapshot});

  final GrowthEngineSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prospecting And Outreach Contracts',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'This section mirrors the internal CRM objects used for salon prospecting, incentive scoring, and guarded outreach drafting.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
              _ResponsiveCards(
                cards: [
                  ...snapshot.prospects
                      .take(2)
                      .map((prospect) => _ProspectSignalCard(prospect: prospect)),
                  ...snapshot.outreachDrafts
                      .take(2)
                      .map((draft) => _OutreachDraftPreviewCard(draft: draft)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceSectionCard extends StatelessWidget {
  const _ExperienceSectionCard({required this.section});

  final ExperienceSection section;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              section.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            _ResponsiveCards(
              cards: section.cards
                  .map((card) => _ExperienceCardView(card: card))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveCards extends StatelessWidget {
  const _ResponsiveCards({required this.cards});

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardWidth = width >= 1100
            ? (width - 24) / 3
            : width >= 760
            ? (width - 16) / 2
            : width;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards
              .map(
                (card) => SizedBox(
                  width: cardWidth.clamp(260, 420).toDouble(),
                  child: card,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.tags,
    this.action,
  });

  final String title;
  final String subtitle;
  final String detail;
  final List<String> tags;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text(detail, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags
                  .map(
                    (tag) => _Pill(label: tag, color: const Color(0xFFF5EEE2)),
                  )
                  .toList(),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}

class _ExperienceCardView extends StatelessWidget {
  const _ExperienceCardView({required this.card});

  final ExperienceCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(card.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(card.subtitle, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text(card.detail, style: Theme.of(context).textTheme.bodyLarge),
            if (card.stats.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: card.stats
                    .map(
                      (stat) =>
                          _StatBadge(label: stat.label, value: stat.value),
                    )
                    .toList(),
              ),
            ],
            if (card.tags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: card.tags
                    .map(
                      (tag) =>
                          _Pill(label: tag, color: const Color(0xFFF5EEE2)),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProspectSignalCard extends StatelessWidget {
  const _ProspectSignalCard({required this.prospect});

  final ProspectSignal prospect;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFCF7),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prospect.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              '${prospect.cityState} • ${prospect.revenueBand}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              prospect.aestheticSignal,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Pill(
                  label: 'Fit ${prospect.fitScore.toStringAsFixed(0)}',
                  color: const Color(0xFFFFF0B8),
                ),
                _Pill(
                  label: '${prospect.locations} locations',
                  color: const Color(0xFFF5EEE2),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              prospect.socialHook,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _OutreachDraftPreviewCard extends StatelessWidget {
  const _OutreachDraftPreviewCard({required this.draft});

  final OutreachDraft draft;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFCF7),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Outreach ${draft.salonId}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(draft.hook, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            Text(
              draft.valueProp,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Pill(
                  label: draft.status,
                  color: const Color(0xFFFFF0B8),
                ),
                if (draft.incentives != null)
                  _Pill(
                    label:
                        'ROI ${draft.incentives!.roiMultiplier.toStringAsFixed(1)}x',
                    color: const Color(0xFFF5EEE2),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              draft.guardrail,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _AiNoticeCard extends StatelessWidget {
  const _AiNoticeCard({required this.aiNotice});

  final AiErrorState aiNotice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF7EB),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const _StatusDot(),
                Text(
                  aiNotice.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              aiNotice.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            ...aiNotice.fallbacks.map(
              (fallback) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Fallback: $fallback',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StorageCard extends StatelessWidget {
  const _StorageCard({required this.storage});

  final StorageProfile storage;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AWS Image Storage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _StorageRow(label: 'Provider', value: storage.provider),
            _StorageRow(label: 'Bucket', value: storage.bucket),
            _StorageRow(label: 'Region', value: storage.region),
            _StorageRow(label: 'Prefix', value: storage.prefix),
            _StorageRow(label: 'Mode', value: storage.mode),
            const SizedBox(height: 12),
            Text(
              storage.fallback,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _StorageRow extends StatelessWidget {
  const _StorageRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
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
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  const _ToolbarAction({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: selected ? MareColors.sage : Colors.transparent,
        foregroundColor: MareColors.ink,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8DED0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
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
              'The MaRe app shell could not load.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Fallback mode keeps the guest and role structure visible instead of showing a blank screen.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(backgroundColor: MareColors.ink),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

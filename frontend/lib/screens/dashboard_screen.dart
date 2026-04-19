import 'package:flutter/material.dart';
import '../core/mare_theme.dart';
import '../data/models.dart';
import '../data/mock_data.dart';
import '../services/api_service.dart';
import 'ai_studio_screen.dart';

enum _MareView { welcome, guest, signIn, rolePicker, roleDashboard }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MareAppSnapshot _data = demoMareAppSnapshot;

  _MareView _view = _MareView.welcome;
  String? _selectedRoleId;

  void _goToGuest() => setState(() { _selectedRoleId = null; _view = _MareView.guest; });
  void _goToSignIn() => setState(() { _selectedRoleId = null; _view = _MareView.signIn; });
  void _selectRole(String roleId) => setState(() { _selectedRoleId = roleId; _view = _MareView.roleDashboard; });
  void _goHome() => setState(() { _selectedRoleId = null; _view = _MareView.welcome; });

  @override
  Widget build(BuildContext context) {
    RoleExperience? currentRole;
    if (_selectedRoleId != null) {
      currentRole = _data.roles.firstWhere((r) => r.id == _selectedRoleId, orElse: () => _data.roles.first);
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 48, 18, 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopBar(
                  appName: _data.appName,
                  onHome: _goHome, onGuest: _goToGuest, onSignIn: _goToSignIn,
                  view: _view, selectedRoleTitle: currentRole?.title,
                ),
                const SizedBox(height: 18),
                switch (_view) {
                  _MareView.welcome => _WelcomeView(data: _data, onGuest: _goToGuest, onSignIn: _goToSignIn),
                  _MareView.guest => _GuestView(guest: _data.guest, onSignIn: _goToSignIn),
                  _MareView.signIn || _MareView.rolePicker => _SignInView(
                      onInternal: () => _selectRole('internal'),
                      onOwner: () => _selectRole('owner'),
                      onClient: () => _selectRole('client'),
                      onGuest: _goToGuest,
                    ),
                  _MareView.roleDashboard when currentRole != null => _RoleDashboardView(
                      role: currentRole, aiNotice: _data.aiNotice, storage: _data.storage, onRolePicker: _goToSignIn),
                  _ => const SizedBox(),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── UI COMPONENTS ──────────────────────────────────────
class _TopBar extends StatelessWidget {
  final String appName;
  final VoidCallback onHome, onGuest, onSignIn;
  final _MareView view;
  final String? selectedRoleTitle;

  const _TopBar({required this.appName, required this.onHome, required this.onGuest, required this.onSignIn, required this.view, this.selectedRoleTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Wrap(
          runSpacing: 12, alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InkWell(
              onTap: onHome, borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _StatusDot(size: 16), const SizedBox(width: 10),
                  Text(appName, style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ),
            Wrap(
              spacing: 10, runSpacing: 10,
              children: [
                _ToolbarAction(label: 'Enter Brand', selected: view == _MareView.guest, onPressed: onGuest),
                _ToolbarAction(label: selectedRoleTitle ?? 'Demo Access', selected: view == _MareView.signIn || view == _MareView.roleDashboard, onPressed: onSignIn),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  final MareAppSnapshot data;
  final VoidCallback onGuest, onSignIn;
  const _WelcomeView({required this.data, required this.onGuest, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: data.appName, subtitle: 'Scalp wellness, reimagined for a luxury world.',
          description: data.tagline,
          pills: const ['Quiet luxury', 'Personalized scalp journeys'],
          actions: [
            FilledButton(onPressed: onGuest, child: const Text('Enter MaRe')),
            OutlinedButton(onPressed: onSignIn, child: const Text('Demo Access', style: TextStyle(color: MareColors.ink))),
          ],
        ),
      ],
    );
  }
}

class _GuestView extends StatelessWidget {
  final GuestExperience guest;
  final VoidCallback onSignIn;
  const _GuestView({required this.guest, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: 'Guest Mode', subtitle: guest.title, description: guest.description,
          pills: guest.highlights,
          actions: [FilledButton(onPressed: onSignIn, child: const Text('Sign In for Role Access'))],
        ),
        const SizedBox(height: 18),
        ...guest.sections.map((s) => _ExperienceSectionCard(section: s, roleId: 'guest'))
      ],
    );
  }
}

class _SignInView extends StatelessWidget {
  final VoidCallback onInternal, onOwner, onClient, onGuest;
  const _SignInView({required this.onInternal, required this.onOwner, required this.onClient, required this.onGuest});

  @override
  Widget build(BuildContext context) {
    return _HeroCard(
      title: 'Demo Access', 
      subtitle: 'Quick Login for Hackathon Demos',
      description: 'Jump directly into any of the three role-based experiences with one click. No password required.',
      pills: const ['Internal Growth', 'Salon Owner', 'End User'],
      actions: [
        FilledButton.icon(onPressed: onInternal, icon: const Icon(Icons.admin_panel_settings, size: 18), label: const Text('MaRe Internal')),
        FilledButton.icon(onPressed: onOwner, icon: const Icon(Icons.storefront, size: 18), label: const Text('Salon Owner')),
        FilledButton.icon(onPressed: onClient, icon: const Icon(Icons.person, size: 18), label: const Text('End User')),
        TextButton(onPressed: onGuest, child: const Text('Return to Brand Entry', style: TextStyle(color: MareColors.ink))),
      ],
    );
  }
}

class _RoleDashboardView extends StatelessWidget {
  final RoleExperience role;
  final AiErrorState aiNotice;
  final StorageProfile storage;
  final VoidCallback onRolePicker;
  const _RoleDashboardView({required this.role, required this.aiNotice, required this.storage, required this.onRolePicker});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCard(
          title: role.title, subtitle: role.heroTitle, description: role.heroDescription,
          pills: role.quickActions,
          actions: [
            FilledButton(onPressed: onRolePicker, child: const Text('Switch Role')),
            if (role.id == 'internal')
              FilledButton.icon(
                icon: const Icon(Icons.auto_awesome),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AiStudioScreen())),
                label: const Text('Launch Creative Studio'),
              ),
          ],
        ),
        const SizedBox(height: 18),
        
        // Dynamically render all the mock data sections!
        ...role.sections.map((section) => Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: _ExperienceSectionCard(section: section, roleId: role.id),
        )),

        // Inject Role-Specific Gemini Ops
        if (role.id == 'internal') const _InternalOpsSection(),
        if (role.id == 'owner') const _OwnerOpsSection(),
        if (role.id == 'client') const _ClientOpsSection(),
      ],
    );
  }
}

// ─── DYNAMIC SECTION RENDERING ──────────────────────────
class _ExperienceSectionCard extends StatelessWidget {
  final ExperienceSection section;
  final String roleId;
  const _ExperienceSectionCard({required this.section, required this.roleId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(section.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(section.subtitle, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: MareColors.espresso)),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16, runSpacing: 16,
              children: section.cards.map((card) => _ExperienceCardView(card: card, roleId: roleId)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceCardView extends StatelessWidget {
  final ExperienceCard card;
  final String roleId;
  const _ExperienceCardView({required this.card, required this.roleId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MareColors.sand.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MareColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(card.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(card.subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(card.detail, style: Theme.of(context).textTheme.bodyMedium),
          if (card.stats.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 10, runSpacing: 10,
              children: card.stats.map((s) => _StatBadge(label: s.label, value: s.value)).toList(),
            ),
          ],
          if (card.tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(spacing: 8, runSpacing: 8, children: card.tags.map((t) => _Pill(label: t)).toList()),
          ],
        ],
      ),
    );
  }
}

// ─── ROLE-SPECIFIC GEMINI SECTIONS ──────────────────────
class _InternalOpsSection extends StatelessWidget {
  const _InternalOpsSection();

  @override
  Widget build(BuildContext context) {
    final snapshot = demoGrowthEngineSnapshot;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const _StatusDot(size: 16), const SizedBox(width: 10), Text('Prospecting & Outreach', style: Theme.of(context).textTheme.headlineMedium)]),
            const SizedBox(height: 8),
            Text('AI Drafts and CRM leads requiring approval.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: snapshot.outreachDrafts.map((d) => _OutreachDraftCard(draft: d)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnerOpsSection extends StatelessWidget {
  const _OwnerOpsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const _StatusDot(size: 16), const SizedBox(width: 10), Text('Partner Growth Engine', style: Theme.of(context).textTheme.headlineMedium)]),
            const SizedBox(height: 8),
            Text('Generate luxury marketing content instantly using Gemini 1.5 Pro.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 18),
            SizedBox(
              width: 400,
              child: Card(
                color: MareColors.sand,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Local Marketing Hook', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text('Draft an Instagram caption to promote the new MaRe Head Spa treatments at your salon.', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.auto_awesome, size: 16),
                        label: const Text('Generate with Gemini'),
                        onPressed: () => _callGemini(context, "Write a luxurious, high-end Instagram caption for a premium salon announcing they now offer the 'MaRe Head Spa' diagnostic and organic treatment ritual. Use systematic and luxury wellness lingo."),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ClientOpsSection extends StatelessWidget {
  const _ClientOpsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const _StatusDot(size: 16), const SizedBox(width: 10), Text('Personalized Care AI', style: Theme.of(context).textTheme.headlineMedium)]),
            const SizedBox(height: 8),
            Text('Get instant routine analysis powered by Gemini 1.5 Pro.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 18),
            SizedBox(
              width: 400,
              child: Card(
                color: MareColors.sand,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Routine Analyzer', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text('Ask the MaRe concierge to explain why your specific organic Italian cosmetics work for your scalp type.', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.auto_awesome, size: 16),
                        label: const Text('Analyze My Routine'),
                        onPressed: () => _callGemini(context, "As the MaRe luxury concierge, explain in two short, elegant sentences why 'Purifying Wash' and 'In Amber' treatments are perfect for someone with a dry scalp and product buildup."),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _callGemini(BuildContext context, String prompt) async {
  showDialog(
    context: context, barrierDismissible: false,
    builder: (ctx) => const AlertDialog(
      content: Row(children: [CircularProgressIndicator(color: MareColors.ink), SizedBox(width: 16), Text("Gemini is thinking...")]),
    ),
  );
  try {
    final res = await ApiService.askGemini(prompt);
    if (context.mounted) {
      Navigator.pop(context); // Close loading
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.auto_awesome, color: MareColors.gold), SizedBox(width: 8), Text('MaRe AI')]),
        content: Text(res, style: const TextStyle(height: 1.5)),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close', style: TextStyle(color: MareColors.ink)))],
      ));
    }
  } catch (e) {
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}

class _OutreachDraftCard extends StatelessWidget {
  final OutreachDraft draft;
  const _OutreachDraftCard({required this.draft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        color: MareColors.sand,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Outreach ${draft.salonId}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(draft.hook, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.auto_awesome, size: 16),
                label: const Text('Rewrite with Gemini'),
                onPressed: () => _callGemini(context, "Rewrite this luxury salon marketing hook to be more engaging and exclusive: ${draft.hook}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ─── HELPERS ────────────────────────────────────────────
class _HeroCard extends StatelessWidget {
  final String title, subtitle, description;
  final List<String> pills;
  final List<Widget> actions;

  const _HeroCard({required this.title, required this.subtitle, required this.description, required this.pills, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: const LinearGradient(colors: [Color(0xFFFFFBF4), Color(0xFFF7EBDD)]),
        border: Border.all(color: MareColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const _StatusDot(), const SizedBox(width: 8), Text(title, style: Theme.of(context).textTheme.titleLarge)]),
          const SizedBox(height: 16),
          Text(subtitle, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 16),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 18),
          Wrap(spacing: 10, runSpacing: 10, children: pills.map((p) => _Pill(label: p)).toList()),
          if (actions.isNotEmpty) ...[const SizedBox(height: 24), Wrap(spacing: 12, children: actions)],
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  const _StatBadge({required this.label, required this.value});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: MareColors.pearl,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MareColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: MareColors.espresso, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, color: MareColors.ink, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;
  const _ToolbarAction({required this.label, required this.selected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(backgroundColor: selected ? MareColors.sage : Colors.transparent, foregroundColor: MareColors.ink),
      child: Text(label),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  const _Pill({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: MareColors.sage, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final double size;
  const _StatusDot({this.size = 12});
  @override
  Widget build(BuildContext context) {
    return Container(width: size, height: size, decoration: const BoxDecoration(color: MareColors.gold, shape: BoxShape.circle));
  }
}
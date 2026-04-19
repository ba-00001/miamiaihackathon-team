import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/mare_theme.dart';
import '../data/models/generation_model.dart';
import '../services/api_service.dart';

class GenerationCard extends StatelessWidget {
  final GenerationModel gen;
  final VoidCallback? onDelete;

  const GenerationCard({super.key, required this.gen, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMM d, yyyy  h:mm a').format(gen.createdAt.toLocal());

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
            child: Row(
              children: [
                _badge(gen.modelType),
                const SizedBox(width: 8),
                _badge(gen.mediaType, color: MareColors.gold),
                const Spacer(),
                Text(date, style: const TextStyle(fontSize: 11, color: MareColors.espresso)),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 18, color: MareColors.espresso),
                  color: MareColors.pearl,
                  onSelected: (v) async {
                    if (v == 'delete') {
                      await ApiService.deleteGeneration(gen.id);
                      onDelete?.call();
                    } else if (v == 'open' && gen.presignedUrl != null) {
                      launchUrl(Uri.parse(gen.presignedUrl!));
                    }
                  },
                  itemBuilder: (_) => [
                    if (gen.presignedUrl != null)
                      const PopupMenuItem(value: 'open', child: Text('Open media')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: MareColors.error))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Text(
              gen.prompt,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: MareColors.ink, height: 1.4),
            ),
          ),
          if (gen.presignedUrl != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: () => launchUrl(Uri.parse(gen.presignedUrl!)),
                  icon: Icon(
                    gen.mediaType == 'audio' ? Icons.headphones : Icons.play_circle_outline,
                    size: 18,
                  ),
                  label: Text(gen.mediaType == 'audio' ? 'Play audio' : 'Play video'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: MareColors.border),
                    foregroundColor: MareColors.ink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _badge(String text, {Color color = MareColors.espresso}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.5)),
    );
  }
}
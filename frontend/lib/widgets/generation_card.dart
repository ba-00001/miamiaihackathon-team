import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../data/models/generation_model.dart';
import '../services/api_service.dart';

class GenerationCard extends StatelessWidget {
  final GenerationModel gen;
  final VoidCallback? onDelete;

  const GenerationCard({super.key, required this.gen, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMM d, yyyy  h:mm a').format(gen.createdAt.toLocal());

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 0),
            child: Row(
              children: [
                _badge(gen.modelType),
                const SizedBox(width: 8),
                _badge(gen.mediaType, color: AppColors.accentLight),
                const Spacer(),
                Text(date, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textMuted),
                  color: AppColors.surfaceLight,
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
                    const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: AppColors.error))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 12),
            child: Text(
              gen.prompt,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
            ),
          ),
          if (gen.presignedUrl != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              child: SizedBox(
                width: double.infinity,
                height: 38,
                child: OutlinedButton.icon(
                  onPressed: () => launchUrl(Uri.parse(gen.presignedUrl!)),
                  icon: Icon(
                    gen.mediaType == 'audio' ? Icons.headphones : Icons.play_circle_outline,
                    size: 16,
                  ),
                  label: Text(gen.mediaType == 'audio' ? 'Play audio' : 'Play video', style: const TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    foregroundColor: AppColors.accentLight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _badge(String text, {Color color = AppColors.textMuted}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.5)),
    );
  }
}
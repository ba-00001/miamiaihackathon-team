import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../core/theme.dart';
import '../services/api_service.dart';

enum MediaUploadType { image, video, audio }

/// Lets users provide media via file upload or URL paste.
/// Uploads to S3 as public-read and returns the direct URL.
class MediaUploadWidget extends StatefulWidget {
  final String label;
  final MediaUploadType type;
  final String? initialUrl;
  final bool required;
  final ValueChanged<String?> onUrlReady;

  const MediaUploadWidget({
    super.key,
    required this.label,
    this.type = MediaUploadType.image,
    this.initialUrl,
    this.required = true,
    required this.onUrlReady,
  });

  @override
  State<MediaUploadWidget> createState() => _MediaUploadWidgetState();
}

class _MediaUploadWidgetState extends State<MediaUploadWidget> {
  final _urlCtrl = TextEditingController();
  bool _isUploading = false;
  String? _resolvedUrl;
  String? _previewName;
  Uint8List? _previewBytes;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initialUrl != null && widget.initialUrl!.isNotEmpty) {
      _urlCtrl.text = widget.initialUrl!;
      _resolvedUrl = widget.initialUrl;
    }
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  List<String> get _allowedExtensions {
    switch (widget.type) {
      case MediaUploadType.image:
        return ['png', 'jpg', 'jpeg', 'webp', 'gif'];
      case MediaUploadType.video:
        return ['mp4', 'webm', 'mov'];
      case MediaUploadType.audio:
        return ['mp3', 'wav', 'ogg', 'aac'];
    }
  }

  String get _mimePrefix {
    switch (widget.type) {
      case MediaUploadType.image:
        return 'image';
      case MediaUploadType.video:
        return 'video';
      case MediaUploadType.audio:
        return 'audio';
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      if (file.bytes == null) {
        setState(() => _error = 'Could not read file bytes. Try a different file.');
        return;
      }

      setState(() {
        _isUploading = true;
        _error = null;
        _previewName = file.name;
        if (widget.type == MediaUploadType.image) {
          _previewBytes = file.bytes;
        }
      });

      final ext = file.extension ?? 'bin';
      final mime = '$_mimePrefix/$ext';
      final url = await ApiService.uploadFileBytes(file.bytes!, file.name, mime);

      setState(() {
        _resolvedUrl = url;
        _isUploading = false;
        _urlCtrl.text = '';
      });
      widget.onUrlReady(url);
    } catch (e) {
      setState(() {
        _isUploading = false;
        _error = 'Upload failed: ${e.toString().replaceFirst('Exception: ', '')}';
      });
    }
  }

  Future<void> _useUrl() async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) return;

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      setState(() => _error = 'Please enter a valid URL starting with http:// or https://');
      return;
    }

    setState(() {
      _isUploading = true;
      _error = null;
      _previewBytes = null;
      _previewName = Uri.tryParse(url)?.pathSegments.lastOrNull ?? 'media';
    });

    try {
      // Re-host through our S3 so Modelslab can access it
      final publicUrl = await ApiService.uploadFromUrl(url);
      setState(() {
        _resolvedUrl = publicUrl;
        _isUploading = false;
      });
      widget.onUrlReady(publicUrl);
    } catch (e) {
      // Fallback: use the raw URL directly
      setState(() {
        _resolvedUrl = url;
        _isUploading = false;
      });
      widget.onUrlReady(url);
    }
  }

  void _clear() {
    setState(() {
      _resolvedUrl = null;
      _previewBytes = null;
      _previewName = null;
      _urlCtrl.clear();
      _error = null;
    });
    widget.onUrlReady(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
            if (!widget.required)
              const Text(' (optional)', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        const SizedBox(height: 8),

        if (_resolvedUrl != null) ...[
          _buildPreview(),
        ] else ...[
          _buildUploadZone(),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _urlCtrl,
                  style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Or paste a public URL here…',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    suffixIcon: _isUploading
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(width: 16, height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent)),
                          )
                        : IconButton(
                            icon: const Icon(Icons.upload, size: 18),
                            color: AppColors.accent,
                            onPressed: _useUrl,
                            tooltip: 'Upload to S3',
                          ),
                  ),
                  onSubmitted: (_) => _useUrl(),
                ),
              ),
            ],
          ),
        ],

        if (_error != null) ...[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, size: 14, color: AppColors.error),
                const SizedBox(width: 6),
                Expanded(child: Text(_error!, style: const TextStyle(fontSize: 11, color: AppColors.error))),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUploadZone() {
    return GestureDetector(
      onTap: _isUploading ? null : _pickFile,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: _isUploading
            ? const Column(children: [
                SizedBox(width: 22, height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent)),
                SizedBox(height: 10),
                Text('Uploading…', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ])
            : Column(children: [
                Icon(
                  widget.type == MediaUploadType.image ? Icons.image_outlined
                    : widget.type == MediaUploadType.video ? Icons.videocam_outlined
                    : Icons.audio_file_outlined,
                  size: 28, color: AppColors.textMuted),
                const SizedBox(height: 8),
                Text('Click to upload ${widget.type.name}',
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(_allowedExtensions.map((e) => '.$e').join('  '),
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ]),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          if (_previewBytes != null && widget.type == MediaUploadType.image)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
              child: Image.memory(_previewBytes!,
                width: double.infinity, height: 160, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(height: 60,
                  child: Center(child: Icon(Icons.broken_image, color: AppColors.textMuted)))),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_previewName ?? 'Media ready',
                        style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                        overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text('Uploaded to S3 (public)',
                        style: TextStyle(fontSize: 10, color: AppColors.success.withOpacity(0.7))),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  color: AppColors.textMuted, onPressed: _clear, tooltip: 'Remove',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
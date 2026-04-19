import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/mare_theme.dart';
import 'media_upload_widget.dart';

class ParameterForm extends StatefulWidget {
  final String modelType;
  final bool isLoading;
  final void Function(Map<String, dynamic> params) onSubmit;

  const ParameterForm({
    super.key,
    required this.modelType,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  State<ParameterForm> createState() => _ParameterFormState();
}

class _ParameterFormState extends State<ParameterForm> {
  final _formKey = GlobalKey<FormState>();
  final _promptCtrl = TextEditingController();
  
  String _aspectRatio = '16:9';
  String _resolution = '720P';
  int _duration = 5;
  String _wanDuration = '5sec';
  String _wanResolution = '720p';
  String? _initImageUrl;
  String? _endImageUrl;

  bool _showRawJson = false;
  final _rawJsonCtrl = TextEditingController();

  @override
  void dispose() {
    _promptCtrl.dispose();
    _rawJsonCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildParams() {
    final p = <String, dynamic>{};
    final prompt = _promptCtrl.text.trim();
    if (prompt.isNotEmpty) p['prompt'] = prompt;

    switch (widget.modelType) {
      case 'seedance':
        if (_initImageUrl != null) p['init_image'] = _initImageUrl;
        if (_endImageUrl != null) p['end_image'] = _endImageUrl;
        p['aspect_ratio'] = _aspectRatio;
        p['resolution'] = _resolution;
        p['duration'] = _duration;
        break;
      case 'wan':
        if (_initImageUrl != null) p['init_image'] = _initImageUrl;
        p['duration'] = int.tryParse(_wanDuration.replaceAll('sec', '')) ?? 5;
        p['resolution'] = _wanResolution;
        break;
    }
    return p;
  }

  void _submit() {
    if (_showRawJson) {
      try {
        final parsed = Map<String, dynamic>.from(jsonDecode(_rawJsonCtrl.text.trim()));
        widget.onSubmit(parsed);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid JSON: $e'), backgroundColor: MareColors.error),
        );
      }
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        widget.onSubmit(_buildParams());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                if (!_showRawJson) {
                  const encoder = JsonEncoder.withIndent('  ');
                  _rawJsonCtrl.text = encoder.convert(_buildParams());
                }
                setState(() => _showRawJson = !_showRawJson);
              },
              icon: Icon(_showRawJson ? Icons.view_list : Icons.code, size: 16, color: MareColors.ink),
              label: Text(_showRawJson ? 'Form view' : 'Raw JSON',
                  style: const TextStyle(fontSize: 12, color: MareColors.ink, fontWeight: FontWeight.w600)),
            ),
          ),

          if (_showRawJson) ...[
            TextFormField(
              controller: _rawJsonCtrl,
              maxLines: 20,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: MareColors.ink),
              decoration: const InputDecoration(labelText: 'JSON payload'),
            ),
          ] else ...[
            TextFormField(
              controller: _promptCtrl,
              maxLines: 3,
              style: const TextStyle(color: MareColors.ink),
              decoration: const InputDecoration(
                labelText: 'Luxury Campaign Prompt',
                hintText: 'A high-end cinematic view of a scalp health ritual...',
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ..._buildModelFields(),
          ],

          const SizedBox(height: 24),

          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: widget.isLoading ? null : _submit,
              icon: widget.isLoading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: MareColors.pearl))
                  : const Icon(Icons.rocket_launch, size: 18),
              label: Text(widget.isLoading ? 'Synthesizing…' : 'Generate Asset'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildModelFields() {
    switch (widget.modelType) {
      case 'seedance': return _seedanceFields();
      case 'wan': return _wanFields();
      default: return [];
    }
  }

  List<Widget> _seedanceFields() {
    return [
      MediaUploadWidget(
        label: 'Start frame image',
        type: MediaUploadType.image,
        onUrlReady: (url) => setState(() => _initImageUrl = url),
      ),
      const SizedBox(height: 14),
      MediaUploadWidget(
        label: 'End frame image',
        type: MediaUploadType.image,
        required: false,
        onUrlReady: (url) => setState(() => _endImageUrl = url),
      ),
      const SizedBox(height: 20),

      _sectionLabel('Output settings'),
      const SizedBox(height: 12),

      _dropdownField<String>(
        label: 'Aspect Ratio',
        value: _aspectRatio,
        items: const ['1:1', '9:16', '16:9', '4:3', '3:4', '21:9'],
        onChanged: (v) => setState(() => _aspectRatio = v!),
      ),
      const SizedBox(height: 12),

      Row(
        children: [
          Expanded(
            child: _dropdownField<String>(
              label: 'Resolution',
              value: _resolution,
              items: const ['480P', '720P'],
              onChanged: (v) => setState(() => _resolution = v!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Duration (sec)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: MareColors.espresso)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MareColors.pearl,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MareColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _duration.toDouble(), min: 4, max: 15, divisions: 11,
                          activeColor: MareColors.ink, inactiveColor: MareColors.border,
                          label: '${_duration}s',
                          onChanged: (v) => setState(() => _duration = v.round()),
                        ),
                      ),
                      Text('${_duration}s',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: MareColors.ink)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),
      _costEstimate(_resolution == '720P' ? 0.23 : 0.10, _duration),
    ];
  }

  List<Widget> _wanFields() {
    return [
      MediaUploadWidget(
        label: 'Input image',
        type: MediaUploadType.image,
        onUrlReady: (url) => setState(() => _initImageUrl = url),
      ),
      const SizedBox(height: 20),

      _sectionLabel('Output settings'),
      const SizedBox(height: 12),

      Row(
        children: [
          Expanded(
            child: _dropdownField<String>(
              label: 'Duration',
              value: _wanDuration,
              items: const ['5sec', '10sec', '15sec'],
              onChanged: (v) => setState(() => _wanDuration = v!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _dropdownField<String>(
              label: 'Resolution',
              value: _wanResolution,
              items: const ['480p', '720p', '1080p'],
              onChanged: (v) => setState(() => _wanResolution = v!),
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),
      Builder(builder: (_) {
        final secs = int.tryParse(_wanDuration.replaceAll('sec', '')) ?? 5;
        final rate = _wanResolution == '1080p' ? 0.15 : 0.10;
        return _costEstimate(rate, secs);
      }),
    ];
  }

  Widget _sectionLabel(String text) {
    return Text(text,
        style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700,
          color: MareColors.ink, letterSpacing: 0.3));
  }

  Widget _dropdownField<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: MareColors.espresso)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: MareColors.pearl,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MareColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor: MareColors.pearl,
              style: const TextStyle(fontSize: 13, color: MareColors.ink, fontWeight: FontWeight.w600),
              icon: const Icon(Icons.arrow_drop_down, color: MareColors.espresso),
              items: items.map((v) => DropdownMenuItem(value: v, child: Text(v.toString()))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _costEstimate(double perSecond, int seconds) {
    final cost = (perSecond * seconds).toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: MareColors.gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MareColors.gold.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.payments_outlined, size: 16, color: MareColors.ink),
          const SizedBox(width: 8),
          Text(
            'Estimated cost: \$$cost  (${seconds}s × \$${perSecond.toStringAsFixed(2)}/sec)',
            style: const TextStyle(fontSize: 12, color: MareColors.ink, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
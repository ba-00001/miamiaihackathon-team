class AiErrorState {
  final bool hasError;
  final String title;
  final String description;
  final List<String> fallbacks;
  AiErrorState({required this.hasError, required this.title, required this.description, required this.fallbacks});
  factory AiErrorState.fromJson(Map<String, dynamic> json) => AiErrorState(
        hasError: json['hasError'] ?? false, title: json['title'] ?? '',
        description: json['description'] ?? '', fallbacks: List<String>.from(json['fallbacks'] ?? []),
      );
}

class CardStat {
  final String label, value;
  CardStat({required this.label, required this.value});
  factory CardStat.fromJson(Map<String, dynamic> json) => CardStat(label: json['label'] ?? '', value: json['value'] ?? '');
}

class ContentAsset {
  final String id, format, title, primaryKeyword, openingHook, callToAction, status;
  final List<String> talkingPoints;
  ContentAsset({required this.id, required this.format, required this.title, required this.primaryKeyword, required this.openingHook, required this.talkingPoints, required this.callToAction, required this.status});
  factory ContentAsset.fromJson(Map<String, dynamic> json) => ContentAsset(
        id: json['id'] ?? '', format: json['format'] ?? '', title: json['title'] ?? '',
        primaryKeyword: json['primaryKeyword'] ?? '', openingHook: json['openingHook'] ?? '',
        talkingPoints: List<String>.from(json['talkingPoints'] ?? []), callToAction: json['callToAction'] ?? '', status: json['status'] ?? '');
}

class ExperienceCard {
  final String title, subtitle, detail;
  final List<String> tags;
  final List<CardStat> stats;
  ExperienceCard({required this.title, required this.subtitle, required this.detail, required this.tags, required this.stats});
  factory ExperienceCard.fromJson(Map<String, dynamic> json) => ExperienceCard(
        title: json['title'] ?? '', subtitle: json['subtitle'] ?? '', detail: json['detail'] ?? '',
        tags: List<String>.from(json['tags'] ?? []),
        stats: (json['stats'] as List?)?.map((e) => CardStat.fromJson(e)).toList() ?? [],
      );
}

class ExperienceSection {
  final String title, subtitle;
  final List<ExperienceCard> cards;
  ExperienceSection({required this.title, required this.subtitle, required this.cards});
  factory ExperienceSection.fromJson(Map<String, dynamic> json) => ExperienceSection(
        title: json['title'] ?? '', subtitle: json['subtitle'] ?? '',
        cards: (json['cards'] as List?)?.map((e) => ExperienceCard.fromJson(e)).toList() ?? [],
      );
}

class GuestExperience {
  final String title, description;
  final List<String> highlights;
  final List<ExperienceSection> sections;
  GuestExperience({required this.title, required this.description, required this.highlights, required this.sections});
  factory GuestExperience.fromJson(Map<String, dynamic> json) => GuestExperience(
        title: json['title'] ?? '', description: json['description'] ?? '',
        highlights: List<String>.from(json['highlights'] ?? []),
        sections: (json['sections'] as List?)?.map((e) => ExperienceSection.fromJson(e)).toList() ?? [],
      );
}

class RoleExperience {
  final String id, title, audience, summary, heroTitle, heroDescription;
  final List<String> quickActions;
  final List<ExperienceSection> sections;
  RoleExperience({required this.id, required this.title, required this.audience, required this.summary, required this.heroTitle, required this.heroDescription, required this.quickActions, required this.sections});
  factory RoleExperience.fromJson(Map<String, dynamic> json) => RoleExperience(
        id: json['id'] ?? '', title: json['title'] ?? '', audience: json['audience'] ?? '',
        summary: json['summary'] ?? '', heroTitle: json['heroTitle'] ?? '', heroDescription: json['heroDescription'] ?? '',
        quickActions: List<String>.from(json['quickActions'] ?? []),
        sections: (json['sections'] as List?)?.map((e) => ExperienceSection.fromJson(e)).toList() ?? [],
      );
}

class StorageProfile {
  final String provider, bucket, region, prefix, mode, fallback;
  StorageProfile({required this.provider, required this.bucket, required this.region, required this.prefix, required this.mode, required this.fallback});
  factory StorageProfile.fromJson(Map<String, dynamic> json) => StorageProfile(
        provider: json['provider'] ?? '', bucket: json['bucket'] ?? '', region: json['region'] ?? '',
        prefix: json['prefix'] ?? '', mode: json['mode'] ?? '', fallback: json['fallback'] ?? '');
}

class MareAppSnapshot {
  final String appName, tagline, updatedAt;
  final GuestExperience guest;
  final List<RoleExperience> roles;
  final StorageProfile storage;
  final AiErrorState aiNotice;
  MareAppSnapshot({required this.appName, required this.tagline, required this.updatedAt, required this.guest, required this.roles, required this.storage, required this.aiNotice});
  factory MareAppSnapshot.fromJson(Map<String, dynamic> json) => MareAppSnapshot(
        appName: json['appName'] ?? '', tagline: json['tagline'] ?? '', updatedAt: json['updatedAt'] ?? '',
        guest: GuestExperience.fromJson(json['guest'] ?? {}),
        roles: (json['roles'] as List?)?.map((e) => RoleExperience.fromJson(e)).toList() ?? [],
        storage: StorageProfile.fromJson(json['storage'] ?? {}),
        aiNotice: AiErrorState.fromJson(json['aiNotice'] ?? {}),
      );
}

class MetricSummary {
  final int luxuryProspects, approvedOutreach, contentAssetsReady;
  final String retailLiftPotential;
  MetricSummary({required this.luxuryProspects, required this.approvedOutreach, required this.contentAssetsReady, required this.retailLiftPotential});
  factory MetricSummary.fromJson(Map<String, dynamic> json) => MetricSummary(
        luxuryProspects: json['luxuryProspects'] ?? 0, approvedOutreach: json['approvedOutreach'] ?? 0,
        contentAssetsReady: json['contentAssetsReady'] ?? 0, retailLiftPotential: json['retailLiftPotential'] ?? '');
}

class ProspectSignal {
  final String id, name, cityState, revenueBand, aestheticSignal, socialHook;
  final int locations;
  final double fitScore;
  final List<String> reasons;
  ProspectSignal({required this.id, required this.name, required this.cityState, required this.revenueBand, required this.aestheticSignal, required this.socialHook, required this.locations, required this.fitScore, required this.reasons});
  factory ProspectSignal.fromJson(Map<String, dynamic> json) => ProspectSignal(
        id: json['id'] ?? '', name: json['name'] ?? '', cityState: json['cityState'] ?? '',
        revenueBand: json['revenueBand'] ?? '', aestheticSignal: json['aestheticSignal'] ?? '',
        socialHook: json['socialHook'] ?? '', locations: json['locations'] ?? 1,
        fitScore: (json['fitScore'] as num?)?.toDouble() ?? 0.0, reasons: List<String>.from(json['reasons'] ?? []));
}

class IncentiveCalculation {
  final double roiMultiplier;
  IncentiveCalculation({required this.roiMultiplier});
  factory IncentiveCalculation.fromJson(Map<String, dynamic> json) => IncentiveCalculation(
        roiMultiplier: (json['roiMultiplier'] ?? json['roi_multiplier'] as num?)?.toDouble() ?? 0.0);
}

class OutreachDraft {
  final String salonId, hook, valueProp, guardrail, fullMessage, status;
  final IncentiveCalculation? incentives;
  OutreachDraft({required this.salonId, required this.hook, required this.valueProp, required this.guardrail, required this.fullMessage, required this.status, this.incentives});
  factory OutreachDraft.fromJson(Map<String, dynamic> json) => OutreachDraft(
        salonId: json['salonId'] ?? json['salon_id'] ?? '', hook: json['hook'] ?? '',
        valueProp: json['valueProp'] ?? json['value_prop'] ?? '', guardrail: json['guardrail'] ?? '',
        fullMessage: json['fullMessage'] ?? json['full_message'] ?? '', status: json['status'] ?? '',
        incentives: json['incentives'] != null ? IncentiveCalculation.fromJson(json['incentives']) : null);
}

class ReviewItem {
  final String id, owner, lane, status, nextAction, fallback;
  ReviewItem({required this.id, required this.owner, required this.lane, required this.status, required this.nextAction, required this.fallback});
  factory ReviewItem.fromJson(Map<String, dynamic> json) => ReviewItem(
        id: json['id'] ?? '', owner: json['owner'] ?? '', lane: json['lane'] ?? '',
        status: json['status'] ?? '', nextAction: json['nextAction'] ?? '', fallback: json['fallback'] ?? '');
}

class GrowthEngineSnapshot {
  final String generatedAt, marketFocus, headline, statusDotColor;
  final MetricSummary metrics;
  final AiErrorState aiError;
  final List<ProspectSignal> prospects;
  final List<OutreachDraft> outreachDrafts;
  final List<ContentAsset> contentAssets;
  final List<ReviewItem> reviewQueue;
  GrowthEngineSnapshot({required this.generatedAt, required this.marketFocus, required this.headline, required this.statusDotColor, required this.metrics, required this.aiError, required this.prospects, required this.outreachDrafts, required this.contentAssets, required this.reviewQueue});
  factory GrowthEngineSnapshot.fromJson(Map<String, dynamic> json) => GrowthEngineSnapshot(
        generatedAt: json['generatedAt'] ?? '', marketFocus: json['marketFocus'] ?? '',
        headline: json['headline'] ?? '', statusDotColor: json['statusDotColor'] ?? '',
        metrics: MetricSummary.fromJson(json['metrics'] ?? {}), aiError: AiErrorState.fromJson(json['aiError'] ?? {}),
        prospects: (json['prospects'] as List?)?.map((e) => ProspectSignal.fromJson(e)).toList() ?? [],
        outreachDrafts: (json['outreachDrafts'] as List?)?.map((e) => OutreachDraft.fromJson(e)).toList() ?? [],
        contentAssets: (json['contentAssets'] as List?)?.map((e) => ContentAsset.fromJson(e)).toList() ?? [],
        reviewQueue: (json['reviewQueue'] as List?)?.map((e) => ReviewItem.fromJson(e)).toList() ?? []);
}
"use client";

import Image from "next/image";
import { startTransition, useEffect, useState } from "react";

import { StatusDot } from "@/components/status-dot";
import type {
  AgentState,
  ContentAsset,
  GrowthEngineSnapshot,
  OutreachDraft,
  ProspectSignal,
  ReviewItem,
} from "@/lib/types";

async function fetchJson<T>(path: string): Promise<T> {
  const response = await fetch(path, { cache: "no-store" });
  if (!response.ok) {
    throw new Error(`Request failed for ${path}`);
  }
  return (await response.json()) as T;
}

function Section({
  title,
  subtitle,
  children,
}: {
  title: string;
  subtitle: string;
  children: React.ReactNode;
}) {
  return (
    <section className="rounded-[2rem] border border-[var(--line)] bg-[var(--card)] p-6 shadow-[0_12px_32px_rgba(94,75,62,0.08)]">
      <h2 className="display-font text-3xl font-semibold">{title}</h2>
      <p className="mt-2 max-w-2xl text-sm leading-6 text-[var(--muted)]">{subtitle}</p>
      <div className="mt-5">{children}</div>
    </section>
  );
}

function Pill({
  children,
  tone = "default",
}: {
  children: React.ReactNode;
  tone?: "default" | "sage" | "rose" | "gold";
}) {
  const classes = {
    default: "bg-[#f4ebde]",
    sage: "bg-[var(--sage)]",
    rose: "bg-[var(--rose)]",
    gold: "bg-[#fff0b8]",
  };

  return (
    <span className={`rounded-full px-4 py-2 text-sm text-[var(--foreground)] ${classes[tone]}`}>
      {children}
    </span>
  );
}

function ProspectCard({ prospect }: { prospect: ProspectSignal }) {
  return (
    <article className="rounded-[1.5rem] border border-[var(--line)] bg-white/70 p-5">
      <div className="flex items-start justify-between gap-4">
        <div>
          <h3 className="text-lg font-semibold">{prospect.name}</h3>
          <p className="mt-1 text-sm text-[var(--muted)]">
            {prospect.cityState} • {prospect.revenueBand} • {prospect.locations} location(s)
          </p>
        </div>
        <div className="flex items-center gap-2 text-sm font-semibold">
          <StatusDot size={14} />
          {prospect.fitScore} fit
        </div>
      </div>
      <p className="mt-4 text-sm leading-6">{prospect.socialHook}</p>
      <div className="mt-4 flex flex-wrap gap-2">
        {prospect.reasons.map((reason) => (
          <Pill key={reason}>{reason}</Pill>
        ))}
      </div>
    </article>
  );
}

function OutreachCard({ draft }: { draft: OutreachDraft }) {
  return (
    <article className="rounded-[1.5rem] border border-[var(--line)] bg-white/70 p-5">
      <h3 className="text-lg font-semibold">{draft.salonName}</h3>
      <p className="mt-1 text-sm text-[var(--muted)]">
        {draft.channel} • {draft.subjectLine}
      </p>
      <p className="mt-4 text-sm leading-6">{draft.hook}</p>
      <p className="mt-3 text-sm leading-6 text-[var(--muted)]">{draft.body}</p>
      <div className="mt-4 space-y-2 text-sm leading-6">
        <p>
          <span className="font-semibold">Postcard:</span> {draft.postcardConcept}
        </p>
        <p>
          <span className="font-semibold">Guardrail:</span> {draft.guardrail}
        </p>
      </div>
    </article>
  );
}

function ContentCard({ asset }: { asset: ContentAsset }) {
  return (
    <article className="rounded-[1.5rem] border border-[var(--line)] bg-white/70 p-5">
      <div className="flex flex-wrap gap-2">
        <Pill tone="sage">{asset.format}</Pill>
        <Pill tone="gold">{asset.status}</Pill>
      </div>
      <h3 className="mt-4 text-lg font-semibold">{asset.title}</h3>
      <p className="mt-2 text-sm text-[var(--muted)]">
        Primary keyword: {asset.primaryKeyword}
      </p>
      <p className="mt-4 text-sm leading-6">{asset.openingHook}</p>
      <ul className="mt-4 space-y-2 text-sm leading-6 text-[var(--muted)]">
        {asset.talkingPoints.map((point) => (
          <li key={point} className="flex gap-3">
            <span className="pt-2">
              <StatusDot size={8} />
            </span>
            <span>{point}</span>
          </li>
        ))}
      </ul>
      <p className="mt-4 text-sm leading-6">
        <span className="font-semibold">CTA:</span> {asset.callToAction}
      </p>
    </article>
  );
}

function ReviewCard({ item }: { item: ReviewItem }) {
  return (
    <article className="rounded-[1.5rem] border border-[var(--line)] bg-white/70 p-5">
      <div className="flex items-start justify-between gap-4">
        <h3 className="text-lg font-semibold">{item.lane}</h3>
        <Pill tone={item.status === "Approved" ? "sage" : "gold"}>{item.status}</Pill>
      </div>
      <div className="mt-4 space-y-2 text-sm leading-6">
        <p>
          <span className="font-semibold">Owner:</span> {item.owner}
        </p>
        <p>
          <span className="font-semibold">Next:</span> {item.nextAction}
        </p>
        <p>
          <span className="font-semibold">Fallback:</span> {item.fallback}
        </p>
      </div>
    </article>
  );
}

export function MareDashboard() {
  const [snapshot, setSnapshot] = useState<GrowthEngineSnapshot | null>(null);
  const [agent, setAgent] = useState<AgentState | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function load() {
      setLoading(true);
      setError(null);

      try {
        const [snapshotData, agentData] = await Promise.all([
          fetchJson<GrowthEngineSnapshot>("/api/snapshot"),
          fetchJson<AgentState>("/api/agent"),
        ]);

        if (!active) {
          return;
        }

        startTransition(() => {
          setSnapshot(snapshotData);
          setAgent(agentData);
        });
      } catch (loadError) {
        if (active) {
          setError(
            loadError instanceof Error
              ? loadError.message
              : "The dashboard could not sync.",
          );
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    void load();

    return () => {
      active = false;
    };
  }, []);

  if (loading) {
    return (
      <main className="flex min-h-screen items-center justify-center px-6">
        <div className="flex items-center gap-3 rounded-full border border-[var(--line)] bg-[var(--card)] px-6 py-4 text-sm">
          <StatusDot />
          Loading the MaRe growth engine...
        </div>
      </main>
    );
  }

  if (error || !snapshot || !agent) {
    return (
      <main className="flex min-h-screen items-center justify-center px-6">
        <div className="max-w-xl rounded-[2rem] border border-[var(--line)] bg-[var(--card)] p-8 text-center shadow-[0_12px_32px_rgba(94,75,62,0.08)]">
          <div className="flex justify-center">
            <StatusDot size={20} />
          </div>
          <h1 className="display-font mt-5 text-4xl font-semibold">
            AI sync paused
          </h1>
          <p className="mt-4 text-sm leading-6 text-[var(--muted)]">
            {error ??
              "The web demo could not load. Fallback mode should keep cached strategy visible and preserve the yellow dot for the developer."}
          </p>
        </div>
      </main>
    );
  }

  const metrics = [
    ["Luxury prospects", String(snapshot.metrics.luxuryProspects)],
    ["Approved outreach", String(snapshot.metrics.approvedOutreach)],
    ["Content assets ready", String(snapshot.metrics.contentAssetsReady)],
    ["Retail lift target", snapshot.metrics.retailLiftPotential],
  ];

  return (
    <main className="px-5 py-6 md:px-8 lg:px-12">
      <div className="mx-auto flex max-w-7xl flex-col gap-5">
        <section className="overflow-hidden rounded-[2.5rem] border border-[var(--line)] bg-[linear-gradient(135deg,#fffaf2_0%,#f5eadb_100%)] p-8 shadow-[0_20px_40px_rgba(94,75,62,0.08)]">
          <div className="grid items-center gap-8 lg:grid-cols-[1.2fr_0.8fr]">
            <div>
              <div className="flex items-center gap-3 text-sm font-semibold uppercase tracking-[0.24em] text-[var(--muted)]">
                <StatusDot />
                Luxury-grade AI growth system
              </div>
              <h1 className="display-font mt-5 text-5xl font-semibold leading-tight md:text-7xl">
                {snapshot.headline}
              </h1>
              <p className="mt-5 max-w-3xl text-base leading-8 text-[var(--muted)]">
                Turn boutique proof into nationwide expansion by combining revenue-ranked salon discovery, brand-safe outreach, and scalable luxury content creation.
              </p>
              <div className="mt-6 flex flex-wrap gap-3">
                <Pill tone="sage">{snapshot.marketFocus}</Pill>
                <Pill tone="rose">Human approval required before send</Pill>
                <Pill tone="gold">Updated {snapshot.generatedAt.slice(0, 10)}</Pill>
              </div>
              <div className="mt-6 rounded-[1.5rem] border border-[var(--line)] bg-white/60 p-4 text-sm leading-6">
                <p className="font-semibold">AI agent state</p>
                <p className="mt-1 text-[var(--muted)]">
                  {agent.status} • {agent.tone}
                </p>
                <p className="mt-3">{agent.nextAction}</p>
                <p className="mt-3 text-[var(--muted)]">{agent.fallbackMessage}</p>
              </div>
            </div>
            <div className="relative">
              <div className="absolute -left-5 top-8 hidden h-24 w-24 rounded-full bg-[var(--gold)]/50 blur-2xl lg:block" />
              <Image
                src="/images/mare-hero-web.svg"
                alt="Luxury growth dashboard illustration"
                width={900}
                height={680}
                className="w-full rounded-[2rem] border border-[var(--line)] bg-white/60"
                priority
              />
            </div>
          </div>
        </section>

        <section className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
          {metrics.map(([label, value]) => (
            <div
              key={label}
              className="rounded-[2rem] border border-[var(--line)] bg-[var(--card)] p-6 shadow-[0_12px_28px_rgba(94,75,62,0.06)]"
            >
              <p className="text-sm text-[var(--muted)]">{label}</p>
              <p className="display-font mt-4 text-4xl font-semibold">{value}</p>
            </div>
          ))}
        </section>

        <Section
          title="Global Prospector"
          subtitle="Rank high-revenue salons using aesthetic signals, location density, and retail readiness."
        >
          <div className="grid gap-4 lg:grid-cols-3">
            {snapshot.prospects.map((prospect) => (
              <ProspectCard key={prospect.id} prospect={prospect} />
            ))}
          </div>
        </Section>

        <div className="grid gap-5 xl:grid-cols-2">
          <Section
            title="Luxury Outreach"
            subtitle="Human-in-the-loop drafts that sound like salon insiders, not automation."
          >
            <div className="space-y-4">
              {snapshot.outreachDrafts.map((draft) => (
                <OutreachCard key={draft.salonName} draft={draft} />
              ))}
            </div>
          </Section>

          <Section
            title="Creative Engine"
            subtitle="AI-search-ready content built around scalp wellness, luxury rituals, and conversion."
          >
            <div className="space-y-4">
              {snapshot.contentAssets.map((asset) => (
                <ContentCard key={asset.id} asset={asset} />
              ))}
            </div>
          </Section>
        </div>

        <div className="grid gap-5 xl:grid-cols-[1.05fr_0.95fr]">
          <Section
            title="AI Watchtower"
            subtitle="Errors surface as guided AI incidents instead of silent failures."
          >
            <div className="rounded-[1.5rem] border border-[#f0d5a4] bg-[#fff7eb] p-5">
              <div className="flex items-center gap-3">
                <StatusDot />
                <h3 className="text-lg font-semibold">{snapshot.aiError.title}</h3>
              </div>
              <p className="mt-4 text-sm leading-6">{snapshot.aiError.description}</p>
              <div className="mt-4 space-y-3 text-sm leading-6 text-[var(--muted)]">
                {snapshot.aiError.fallbacks.map((fallback) => (
                  <p key={fallback}>
                    <span className="font-semibold text-[var(--foreground)]">
                      Fallback:
                    </span>{" "}
                    {fallback}
                  </p>
                ))}
              </div>
            </div>
          </Section>

          <Section
            title="Approval Queue"
            subtitle="Every risky action has a clear owner, next action, and fallback lane."
          >
            <div className="space-y-4">
              {snapshot.reviewQueue.map((item) => (
                <ReviewCard key={item.id} item={item} />
              ))}
            </div>
          </Section>
        </div>

        <Section
          title="Developer Marker"
          subtitle="The yellow circle is the visual cue that this is the MaRe demo environment."
        >
          <div className="flex flex-col gap-5 md:flex-row md:items-center md:justify-between">
            <div className="flex max-w-3xl items-start gap-3 text-sm leading-6 text-[var(--muted)]">
              <div className="pt-2">
                <StatusDot size={18} />
              </div>
              <p>
                Whenever you see the yellow dot, you are looking at live AI-assisted
                or mock AI-controlled surfaces that need brand review before being
                treated as production-safe output.
              </p>
            </div>
            <Image
              src="/images/growth-flow-web.svg"
              alt="Flow illustration for the MaRe demo"
              width={320}
              height={220}
              className="w-full max-w-[220px]"
            />
          </div>
        </Section>
      </div>
    </main>
  );
}

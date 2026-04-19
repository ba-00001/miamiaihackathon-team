type StatusDotProps = {
  size?: number;
};

export function StatusDot({ size = 12 }: StatusDotProps) {
  return (
    <span
      aria-hidden
      className="inline-block rounded-full bg-[var(--gold)]"
      style={{ width: size, height: size }}
    />
  );
}

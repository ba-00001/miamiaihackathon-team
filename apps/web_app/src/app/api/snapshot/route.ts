import { NextResponse } from "next/server";

import { growthEngineSnapshot } from "@/lib/mock-data";

export async function GET() {
  return NextResponse.json(growthEngineSnapshot);
}

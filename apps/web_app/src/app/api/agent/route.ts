import { NextResponse } from "next/server";

import { runMareAgent } from "@/lib/agent/mare-agent";

export async function GET() {
  return NextResponse.json(runMareAgent());
}

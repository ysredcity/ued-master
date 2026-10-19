#!/usr/bin/env bash
# 打包 skill：bash scripts/pack.sh [版本号]
# 产物：releases/ued-master-<版本>.zip（包内根目录 ued-master/），打包前先跑 tests/check.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SK="$ROOT/skills/ued-master"
VER="${1:-$(sed -n 's/^  version: *//p' "$SK/SKILL.md" | head -1)}"
[ -n "$VER" ] || { echo "无法读取版本号" >&2; exit 1; }

bash "$ROOT/tests/check.sh" >/dev/null || { echo "tests/check.sh 未通过，已停止打包" >&2; bash "$ROOT/tests/check.sh"; exit 1; }

OUT="$ROOT/releases/ued-master-${VER}.zip"
[ -e "$OUT" ] && { echo "已存在 ${OUT}，不覆盖；请先升版本号" >&2; exit 1; }
mkdir -p "$ROOT/releases"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
rsync -a --exclude '.DS_Store' "$SK/" "$TMP/ued-master/"
( cd "$TMP" && zip -qr -X "$OUT" ued-master )

unzip -tq "$OUT" >/dev/null
for f in SKILL.md UPSTREAM.md LICENSE-upstream.txt references/brand-color.md references/web-baseline.md; do
  unzip -l "$OUT" "ued-master/$f" >/dev/null || { echo "包内缺少 $f" >&2; rm -f "$OUT"; exit 1; }
done
echo "已生成 ${OUT}（$(unzip -l "$OUT" | tail -1 | awk '{print $2}') 个文件，$(wc -c < "$OUT" | tr -d ' ') 字节）"
shasum -a 256 "$OUT"

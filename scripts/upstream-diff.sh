#!/usr/bin/env bash
# 对比本仓库复用的上游正文与本机已安装的上游 skill：bash scripts/upstream-diff.sh [上游 SKILL.md 路径]
# 只读，不修改任何文件；有差异时由维护者按 CONTRIBUTING 第三节决定是否同步。
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UP="${1:-$HOME/.agents/skills/redesign-existing-projects/SKILL.md}"
[ -f "$UP" ] || { echo "未找到上游文件：$UP" >&2; exit 1; }
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
python3 - "$UP" "$ROOT/skills/ued-master/SKILL.md" "$TMP" <<'EOF'
import sys, re, pathlib
up, mine, tmp = sys.argv[1:]
b = open(up, encoding='utf-8').read().split('\n---\n', 1)[1].strip('\n') + '\n'
m = re.search(r'<!-- upstream:begin[^\n]*-->\n(.*)<!-- upstream:end -->', open(mine, encoding='utf-8').read(), re.S)
pathlib.Path(tmp, 'upstream.md').write_text(b, encoding='utf-8')
pathlib.Path(tmp, 'ours.md').write_text(m.group(1), encoding='utf-8')
EOF
if diff -u "$TMP/ours.md" "$TMP/upstream.md"; then echo "一致：复用正文与上游相同"; else echo "（以上为差异：- 本仓库 / + 上游）"; fi

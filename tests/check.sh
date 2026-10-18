#!/usr/bin/env bash
# UEDMaster 结构与一致性检查：bash tests/check.sh
# 检查项：skill 结构校验 / 上游正文未被改动 / 版本号一致 / 品牌色值存在 / 用例清单可解析
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SK="$ROOT/skills/ued-master"
PASS=0; FAIL=0
ok(){ echo "  PASS  $1"; PASS=$((PASS+1)); }
ng(){ echo "  FAIL  $1"; FAIL=$((FAIL+1)); }

echo "UEDMaster check"

# 1. skill-creator 的结构校验（可选依赖，缺失时跳过并提示）
QV="${QUICK_VALIDATE:-$HOME/.kiro/skills/skill-creator/scripts/quick_validate.py}"
if [ -f "$QV" ]; then
  if python3 "$QV" "$SK" >/dev/null 2>&1; then ok "quick_validate"; else ng "quick_validate：$(python3 "$QV" "$SK" 2>&1 | tail -1)"; fi
else
  echo "  SKIP  quick_validate（未找到 $QV，可设 QUICK_VALIDATE 指定）"
fi

# 2. 上游正文哈希与 UPSTREAM.md 记录一致
REGION_SHA="$(python3 - "$SK/SKILL.md" <<'EOF'
import sys, hashlib, re
t = open(sys.argv[1], encoding='utf-8').read()
m = re.search(r'<!-- upstream:begin[^\n]*-->\n(.*)<!-- upstream:end -->', t, re.S)
print(hashlib.sha256(m.group(1).encode()).hexdigest() if m else 'missing')
EOF
)"
REC_SHA="$(grep -o '复用正文 SHA-256 | `[0-9a-f]*`' "$SK/UPSTREAM.md" | grep -o '[0-9a-f]\{64\}')"
[ "$REGION_SHA" = "$REC_SHA" ] && ok "上游正文未改动（${REGION_SHA}）" || ng "上游正文哈希不一致：实际 $REGION_SHA / 记录 $REC_SHA"

# 3. 版本号：SKILL.md metadata.version 与 CHANGELOG 最新版本一致
V_SKILL="$(sed -n 's/^  version: *//p' "$SK/SKILL.md" | head -1)"
V_LOG="$(grep -o '^## \[[0-9][0-9.]*\]' "$ROOT/CHANGELOG.md" | head -1 | tr -d '#[] ')"
[ -n "$V_SKILL" ] && [ "$V_SKILL" = "$V_LOG" ] && ok "版本一致 $V_SKILL" || ng "版本不一致：SKILL $V_SKILL / CHANGELOG $V_LOG"

# 4. 品牌色只定义两个值，且都出现在 SKILL.md
for c in '#009689' '#00786F'; do grep -q "$c" "$SK/SKILL.md" && ok "品牌色 $c" || ng "缺少品牌色 $c"; done

# 5. 必需文件
for f in SKILL.md UPSTREAM.md LICENSE-upstream.txt references/brand-color.md; do
  [ -f "$SK/$f" ] && ok "文件 $f" || ng "缺少 $f"
done

# 6. 用例清单
python3 -c "import json,sys; d=json.load(open('$ROOT/tests/cases.json')); import os; assert d['cases'] and all({'id','mode','prompt'}<=set(c) and (c['input'] is None or os.path.exists('$ROOT/'+c['input'])) for c in d['cases'])" 2>/dev/null \
  && ok "tests/cases.json" || ng "tests/cases.json 格式错误"

echo "结果：$PASS 通过，$FAIL 失败"
[ "$FAIL" -eq 0 ]

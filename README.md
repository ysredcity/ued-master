# UEDMaster

新产品 demo 原型的生成与视觉优化 skill。面向产品还没有成熟设计系统的阶段：直接根据需求生成可交互 demo，或把已生成的 demo 升级到可评审、可演示的品质。

设计取向是**少规则**：设计系统没建立时，过多的规则会限制模型的判断。UEDMaster 只提供一份通用设计审计清单，加上一组海信青绿强调色。

## 内容

- **通用设计审计**：逐字复用 [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) 的 redesign skill（MIT），覆盖排版、色彩、布局、交互状态、文案、组件、图标、代码质量等。来源与版本见 `skills/ued-master/UPSTREAM.md`。
- **两种用法**：从需求生成 demo（审计清单作生成后的自检），或优化已有 demo（Scan → Diagnose → Fix）。两种都要求浏览器截图自检、迭代到没有明显可提升之处。
- **品牌强调色**：只定义两个值。

| 色值 | 用途 |
|---|---|
| `#009689`（Tailwind teal-600） | 选中指示、图标、进度条、大块色面 |
| `#00786F`（Tailwind teal-700） | 链接文字、白字主按钮 |

强调色需要克制使用，不要满屏青绿。海信原色 `#00AAA6` 白底对比度只有 2.88:1，因此不直接使用。

## 使用

把 `skills/ued-master/` 放进所用工具的 skills 目录即可，例如 Kiro 的 `~/.kiro/skills/ued-master`。也可以用打包产物：

```bash
bash scripts/pack.sh          # 生成 releases/ued-master-<版本>.zip
```

调用示例：「根据这个需求做个 demo 原型」「这个原型 UI 效果差，帮我优化」。已有成熟设计系统的项目，优先用对应设计系统的 skill。

## 仓库结构

```
skills/ued-master/        skill 本体（随包分发）
  SKILL.md                入口：UEDMaster 增补 + 上游正文（标记区内逐字复用）
  UPSTREAM.md             上游来源、版本与正文哈希
  LICENSE-upstream.txt    上游 MIT 许可
  references/brand-color.md  品牌色取值理由
tests/                    一致性检查、用例清单、用例材料与产出（本地专用，不入库）
scripts/                  pack.sh 打包 · upstream-diff.sh 对比上游
docs/plans/               设计记录
releases/                 本地 ZIP（不入库）
```

维护规则见 [CONTRIBUTING.md](CONTRIBUTING.md)，版本变化见 [CHANGELOG.md](CHANGELOG.md)。

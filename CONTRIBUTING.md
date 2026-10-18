# 贡献与维护规则（CONTRIBUTING）

## 一、单一事实源

| 事项 | 事实源 |
|---|---|
| skill 行为 | `skills/ued-master/SKILL.md` |
| 上游来源与正文哈希 | `skills/ued-master/UPSTREAM.md` |
| 版本号 | `SKILL.md` 的 `metadata.version` |
| 维护上下文（状态、结论、待办） | `PROJECT_CONTEXT.md` |
| 面向使用者的变化 | `CHANGELOG.md` |
| 测试用例 | `tests/cases.json`（本地维护，不入库） |

## 二、少规则原则

UEDMaster 面向没有设计系统的阶段。新增规则前先问：这条规则是底线（对比度、功能保真、可访问性），还是一种风格偏好？风格偏好不进 skill。

- 新增内容写在 `SKILL.md` 上游标记区**之前**，保持简短。
- 解释性内容放 `references/`，SKILL.md 只留执行所需的一两句和链接。
- 色值只有 `#009689` / `#00786F` 两个，增加色值需在 `PROJECT_CONTEXT.md` 记录理由。

## 三、上游正文

- 标记区 `<!-- upstream:begin -->` … `<!-- upstream:end -->` 内**不改字句**。需要和上游不同的做法，在标记区之前用 UEDMaster 增补说明覆盖关系（如「这两个值替代了下方『挑一个强调色』」）。
- 同步上游：
  1. `bash scripts/upstream-diff.sh` 查看差异；
  2. 确认接受后，用上游新正文替换标记区内容；
  3. 更新 `UPSTREAM.md` 的 skillFolderHash、正文 SHA-256 和日期；
  4. 跑 `bash tests/check.sh`，记 CHANGELOG（通常为 y 位升级）。
- 上游许可为 MIT，`LICENSE-upstream.txt` 必须随包分发。

## 四、改动顺序

1. 改 `skills/ued-master/`。
2. `bash tests/check.sh` 全部通过。
3. 行为有变化时，用 `tests/cases.json` 至少跑一个相关用例（新会话、截图存档到 `tests/outputs/`）。
4. 更新 `PROJECT_CONTEXT.md`（状态 / 结论 / 文件地图 / 待办 + 变更日志一行）。
5. 面向使用者的变化写进 `CHANGELOG.md`；发布时把 `[Unreleased]` 归档为新版本，同步 `metadata.version`。

## 五、打包

`bash scripts/pack.sh`：先跑检查，再生成 `releases/ued-master-<版本>.zip`。同版本已存在时拒绝覆盖。`releases/` 不入库。

## 六、入库边界与协作

- 不入库：`PROJECT_CONTEXT.md`（维护台账）、`tests/`（check.sh、cases.json、用例材料与产出都在本地维护，样本可能含业务数据）、`releases/`、`.ued-master/`（运行时截图等临时文件）。
- `tests/check.sh` 与 `tests/cases.json` 虽不入库，仍是本地维护的事实源，改动 skill 后照常按本文件约定执行检查与用例，不因不入库而降低要求。
- 不替用户 `git commit` / `git push`。

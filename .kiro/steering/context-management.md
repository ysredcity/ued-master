# 上下文管理（UEDMaster）

`PROJECT_CONTEXT.md` 是本仓库跨会话的单一事实源。

- 会话开始先读下方注入的台账；与用户当前指令冲突时以用户为准，完成后更新台账。
- 完成里程碑、做出影响后续的决策、增删重要文件、明确或放弃待办时，主动更新台账（对应小节 + 变更日志一行 + 顶部日期）。
- skill 行为规则只写在 `skills/ued-master/SKILL.md`，不在 steering 里重复。
- 不替用户 `git commit` / `git push`。

#[[file:PROJECT_CONTEXT.md]]

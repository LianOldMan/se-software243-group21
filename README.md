# 校园二手书交易平台｜软件工程导论实验

**班级**：软件243班　**组号**：第21组　**小组**：3人

> 用于《软件工程导论实验》的课程模拟项目，包含实验一需求分析、后续数据库设计和软件设计。仅使用虚构书籍与交易情境，不包含真实支付/物流，不在此公开个人学号和联系方式。

## 项目范围

- 四项核心业务：发布书籍、检索与查看书籍、下单预留、取消订单。
- 业务角色：卖家、买家（可由同一预置账号兼任）。
- 下单只表示预留，同一本书同一时刻最多一个有效订单；只有订单买家本人能取消；取消后保留历史，仅在没有其他有效订单（包括新有效订单）时恢复可售；旧订单请求不得影响新预留。
- 不包含注册/找回密码、支付/退款、物流、交易完成、评价和推荐。

## 小组分工

| 成员 | 账号（以实际 GitHub 协作者列表为准） | 实验一主责 | Issues |
|---|---|---|---|
| A（组长） | `LianOldMan` | 发布书籍（UC-01）、系统概述、版本整合 | [#1](https://github.com/LianOldMan/se-software243-group21/issues/1)、[#6](https://github.com/LianOldMan/se-software243-group21/issues/6) |
| B | 3366731 | 检索与查看（UC-02/03）、下单（UC-04） | [#2](https://github.com/LianOldMan/se-software243-group21/issues/2)、[#3](https://github.com/LianOldMan/se-software243-group21/issues/3) |
| C | Elyeye1111 | 取消订单（UC-05）、NFR/待确认规则 | [#4](https://github.com/LianOldMan/se-software243-group21/issues/4)、[#5](https://github.com/LianOldMan/se-software243-group21/issues/5) |

小组 Projects 看板：[软件243班第21组](https://github.com/users/LianOldMan/projects/1)

## 成果入口（按仓库实际已有文件及本次整合版维护）

| 目录 / 文件 | 内容 |
|---|---|
| [requirements/requirements.md](requirements/requirements.md) | 实验一需求规格整合稿（当前 v0.5.4：依据 B/C 对 v0.5.3 的意见完成追踪与验收描述精修；B/C 均已确认 v0.5.4 差异通过，#6 组内交叉检查可结项；非最终 lab1） |
| [requirements/软件243_21组_实验一_完整用例图_v0.1.drawio](requirements/软件243_21组_实验一_完整用例图_v0.1.drawio) | 完整 UML 用例图可编辑源文件 |
| [requirements/软件243_21组_实验一_完整用例图_v0.1.png](requirements/软件243_21组_实验一_完整用例图_v0.1.png) | 完整 UML 用例图图片 |
| [requirements/检索查看与下单分析_v0.1.md](requirements/检索查看与下单分析_v0.1.md) | B 的个人分析稿（文件名 v0.1；B 本人提交至文内 v0.3、组长委托 AI 辅助修订 v0.4；C 已在 #2 对 v0.4 真实复核并确认四处修改通过；§10.1 非阻断文字问题已清理） |
| [requirements/取消订单与NFR分析_v0.2.md](requirements/取消订单与NFR分析_v0.2.md) | C 的当前个人稿；UC-05、NFR 均已获 B 二次复核内容通过（#4/#5 已关闭），另有非阻断性编辑建议 |
| [requirements/UC-01发布书籍详细用例初稿.md](requirements/UC-01发布书籍详细用例初稿.md) | A 的个人详细用例 v0.2（C 已在 #1 二次复核通过） |
| [records/实验一_需求审查与规则确认_待填写.md](records/实验一_需求审查与规则确认_待填写.md) | 实际组内检查、规则讨论、互评和贡献记录 |
| [records/issue-6-integration-review.md](records/issue-6-integration-review.md) | #6 七项检查、真实成员证据及 AI 辅助检查边界 |

`database/`、`design/` 为后续实验计划目录，当前 main 尚无对应成果。

## 阶段状态与提交记录

- 实验一第 1 次课：仓库与看板、Issue、需求初稿和完整用例图已建立；实际完成的步骤以 GitHub 历史记录为准。
- 实验一第 2 次课：共享需求已修订至 v0.5.4，仍为 8 FR、5 UC、3 NFR；完整图继续使用 v0.1 drawio/PNG。B、C 已分别对 v0.5.3 在 #6 留下实际检查“内容通过”及建议，v0.5.4 针对这些建议补全追踪与验收描述；**B/C 均已对 v0.5.4 差异确认通过**，仍需对最终报告和正式跨组互评独立留证，正式跨组互评、报告及最终版本登记待完成。
- #1～#6 的 GitHub Issues 现均为 Closed。#2 C 已在 [复核评论](https://github.com/LianOldMan/se-software243-group21/issues/2#issuecomment-6625594696) 确认 B 个人稿 v0.4 的四处修订通过，C 本人关闭了 #2，记录已同步 7/7；#6 B/C 对共享 v0.5.4 的复核已通过。共享稿仍保留 AC-05-4 与其他编辑建议，需在最终 lab1 报告前修订并按新版本记录真实检查。详见 [实时证据与待办](records/issue-6-integration-review.md)。
- `lab1` 最终提交页面链接：**待人工核验、正式互评及修订完成后，填入全组《互评与提交记录》**；链接包含完整SHA，无需另抄哈希。
- `lab2` / `lab3`：**待后续实验填写**。

**注意**：仓库本次核查仍为 public，未更改可见性。仓库既有材料记载指导书要求私有仓库、课程账号加入仓库并拥有看板 Read 权限；相关操作由组长另行授权和核实。所有工作记录以真实提交与检查为准，不虚构评审、贡献或 AI 使用情况。

## 实验一新版提交约定（材料包v1.4 / 指导书v1.7，2026-11-02）

当前共享需求v0.5.4沿用组长于2026-11-02转述全组意见确认的R-01～R-05；以人性化、使用顺心为方向。交互细节、NFR量化指标及Q-01～08已进一步获全组采纳并同步至v0.5；B/C 对 v0.5.3 的交叉检查已完成；B/C 均已完成 v0.5.4 差异复核并表示通过；正式组间互评、个人报告及 lab1 最终登记仍待完成。所有运行测试尚未实施。旧版个人分析和AI预审作为过程材料保留，共享需求以 `requirements/requirements.md` 当前版本为准。

截止：下次实验课开始前（第3次课，数据库设计第一次课）。组长提交一个小组ZIP，仅包含三份个人Word报告和全组一份互评与提交记录Word。每份个人报告均包含完整用例图和三个详细用例；无需另交PDF、绘图源文件、单独图片、用例工作表或截图包。现有源文件可以保留。

先提交脱敏共享最终需求，再将仓库链接及含完整SHA的最终提交页面链接填入互评记录；完整身份信息报告走课程渠道，报告图文须与所登记版本一致。个人Issue及贡献链接放本人报告。

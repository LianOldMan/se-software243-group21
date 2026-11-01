# 校园二手书交易平台｜软件工程导论实验

**班级**：软件243班　**组号**：第21组　**小组**：3人

> 用于《软件工程导论实验》的课程模拟项目，包含实验一需求分析、后续数据库设计和软件设计。仅使用虚构书籍与交易情境，不包含真实支付/物流，不在此公开个人学号和联系方式。

## 项目范围

- 四项核心业务：发布书籍、检索与查看书籍、下单预留、取消订单。
- 业务角色：卖家、买家（可由同一预置账号兼任）。
- 下单只表示预留，同一本书同一时刻最多一个有效订单；只有订单买家本人能取消；取消后保留历史、书籍恢复可售。
- 不包含注册/找回密码、支付/退款、物流、交易完成、评价和推荐。

## 小组分工

| 成员 | 账号（以实际 GitHub 协作者列表为准） | 实验一主责 | Issues |
|---|---|---|---|
| A（组长） | `LianOldMan` | 发布书籍（UC-01）、系统概述、版本整合 | [#1](https://github.com/LianOldMan/se-software243-group21/issues/1)、[#6](https://github.com/LianOldMan/se-software243-group21/issues/6) |
| B | 3366731 | 检索与查看（UC-02/03）、下单（UC-04） | [#2](https://github.com/LianOldMan/se-software243-group21/issues/2)、[#3](https://github.com/LianOldMan/se-software243-group21/issues/3) |
| C | Elyele1111 | 取消订单（UC-05）、NFR/待确认规则 | [#4](https://github.com/LianOldMan/se-software243-group21/issues/4)、[#5](https://github.com/LianOldMan/se-software243-group21/issues/5) |

小组 Projects 看板：[软件243班第21组](https://github.com/users/LianOldMan/projects/1)

## 成果入口（按仓库实际已有文件及本次整合版维护）

| 目录 / 文件 | 内容 |
|---|---|
| `requirements/requirements.md` | 实验一需求规格整合稿（当前 v0.2 待组内确认） |
| `requirements/软件243_21组_实验一_完整用例图_v0.1.drawio` | 完整 UML 用例图可编辑源文件 |
| `requirements/软件243_21组_实验一_完整用例图_v0.1.png` | 完整 UML 用例图图片 |
| `requirements/检索查看与下单分析_v0.1.md` | B 的个人需求分析稿 |
| `requirements/取消订单与NFR分析_v0.1.md` | C 的个人需求分析稿（如仍在根目录，请先移动） |
| `requirements/UC-01_发布书籍_详细用例_v0.1.md` | A 的个人详细用例稿（上传后按实际路径核对） |
| `records/实验一_需求审查与规则确认_待填写.md` | 实际组内检查、规则讨论、互评和贡献记录 |
| `database/` | 实验二成果，尚未开始时保留占位说明 |
| `design/` | 实验三成果，尚未开始时保留占位说明 |

## 阶段状态与提交记录

- 实验一第 1 次课：仓库与看板、Issue、需求初稿和完整用例图已建立；实际完成的步骤以 GitHub 历史记录为准。
- 实验一第 2 次课：需求 v0.2 待组内审核；后续需真实阶段互评、修改并形成最终报告。
- `lab1` 最终完整 commit SHA：**待最终提交后填写**。
- `lab2` / `lab3`：**待后续实验填写**。

**注意**：指导书要求私有仓库、课程账号加入仓库并拥有看板 Read 权限。所有工作记录以真实提交与检查为准，不虚构评审、贡献或 AI 使用情况。

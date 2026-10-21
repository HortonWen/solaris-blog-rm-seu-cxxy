# 天钺 Solaris · RoboMaster 技术博客

东南大学成贤学院（SEU-CXXY）RoboMaster 战队 **天钺（Solaris）** 的技术博客，部署于 GitHub Pages：

**在线地址：https://hortonwen.github.io/solaris-blog-rm-seu-cxxy/**

## 内容

- **培训笔记**：整理自同济大学（SuperPower）RoboMaster 战队公开的招新培训视频与课件（B 站空间：https://space.bilibili.com/651837546），按机械 / 电控 / 硬件 / 视觉四组整理，附完整配图与推荐学习路径；
- **战队沉淀**：备赛过程中的踩坑记录、代码片段与经验总结（持续更新）。

## 技术栈

本站基于开源主题 [Shirone](https://github.com/LyraVoid/Shirone)（Astro 7 + Svelte 5 + Material 3 Expressive）构建。

## 目录结构（与文章相关部分）

```
src/content/posts/               # 全部文章（每篇一个目录）
├── tongji-rm25-training-overview/      # 总索引（置顶）
├── tongji-rm25-training-mechanical/    # 机械组培训笔记
├── tongji-rm25-training-electronic/    # 电控组培训笔记
├── tongji-rm25-training-hardware/      # 硬件组培训笔记
└── tongji-rm25-training-vision/        # 视觉组培训笔记
src/config/                      # 站点配置（标题/资料/导航/功能开关）
public/                          # 静态资源（favicon、logo 等）
```

## 新增一篇文章

1. 在 `src/content/posts/` 下新建目录 `<slug>/`，其中放 `index.md`；
2. 文章开头写 frontmatter：

```yaml
---
title: "文章标题"
published: 2026-10-21
description: "文章摘要"
tags: ["RoboMaster", "机械组"]
category: "机械组"
draft: false
---
```

3. 图片放在 `<slug>/images/` 下，正文用相对路径引用：`![描述](./images/xxx.png)`（**注意：文件名请使用 ASCII 字符**，中文文件名在 Windows 构建时会解析失败）；
4. 本地预览：`pnpm dev`，构建：`pnpm build`。

## 构建与部署

环境要求：Node.js ≥ 22.12、pnpm 11.x（仓库已通过 corepack 固定版本）。

```powershell
corepack enable
pnpm install
pnpm build          # 产物输出到 dist/
pnpm preview        # 本地预览
```

**部署到 GitHub Pages**（gh-pages 分支，需设置环境变量 `GITHUB_TOKEN`，即带 repo 权限的 Personal Access Token）：

```powershell
./deploy.ps1
```

或者手动执行：构建后将 `dist/` 内容提交到 `gh-pages` 分支并推送，GitHub Pages 已配置为从该分支发布。

## 来源与版权

- 培训笔记整理自同济大学（SuperPower）RoboMaster 战队公开的招新培训课件与视频，原始视频发布在 B 站空间：https://space.bilibili.com/651837546；
- 课件与视频版权归原作者及同济大学战队所有，本仓库笔记仅作战队学习交流使用；
- 主题源码（Shirone）遵循 MIT 许可；本仓库内容遵循 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)。

import type { ProfileConfig } from "@/types/config";
import { withUserConfig } from "../utils/config-overlay.ts";

/**
 * 博主资料：头像 / 名称 / 简介 / 社交链接（侧栏 Profile 卡片、页脚、RSS 作者等消费）。
 * 类型见 src/types/config.ts。
 */
export const profileConfig: ProfileConfig = withUserConfig("profile", {
	avatar: "/logo/icon.webp", // Relative to the /src directory. Relative to the /public directory if it starts with '/'
	name: "天钺 Solaris",
	bio: "东南大学成贤学院（SEU-CXXY）RoboMaster 战队技术博客。机械、电控、硬件、视觉四组的学习笔记与项目沉淀。",
	links: [
		{
			name: "GitHub",
			icon: "fa7-brands:github", // Visit https://icones.js.org/ for icon codes
			// You will need to install the corresponding icon set if it's not already included
			// `pnpm add @iconify-json/<icon-set-name>`
			url: "https://github.com/HortonWen/solaris-blog-rm-seu-cxxy",
		},
		{
			name: "RoboMaster",
			icon: "material-symbols:precision-manufacturing-rounded",
			url: "https://www.robomaster.com/",
		},
	],
});

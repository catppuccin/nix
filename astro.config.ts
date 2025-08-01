import { defineConfig } from "astro/config";
import catppuccin from "@catppuccin/starlight";
import starlight from "@astrojs/starlight";

import { optionsData } from "./docs/data/options";

const starlightTitle = "catppuccin/nix";

const moduleTypeToNiceLabel = (type: string) => {
  switch (type) {
    case "nixos":
      return "NixOS";
    case "home":
      return "home-manager";
    default:
      return type;
  }
};

const rollingVersion = "main";
const latestStableVersion = "25.05";

export default defineConfig({
  site: process.env.URL || "https://nix.catppuccin.com",

  srcDir: "./docs",

  integrations: [
    starlight({
      title: starlightTitle,

      logo: {
        src: "./assets/logo.png",
      },

      editLink: {
        baseUrl:
          "https://github.com/catppuccin/nix/edit/main/",
      },

      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/catppuccin/nix",
        },
        {
          icon: "discord",
          label: "Discord",
          href: "https://discord.com/servers/907385605422448742",
        },
      ],

      sidebar: [
        {
          label: starlightTitle,
          slug: "",
        },
        {
          label: "Getting Started",
          autogenerate: { directory: "Getting Started" },
        },
        {
          label: "Options List",
          items: Object.entries(optionsData).map(([version, modules]) => {
            const versionGroup = {
              label: version,
              collapsed: version != rollingVersion,
              items: Object.entries(modules).map(([type, options]) => {
                return {
                  label: moduleTypeToNiceLabel(type),
                  collapsed: true,
                  items: Object.keys(options).map((module) => {
                    return {
                      label: module,
                      link: `/options/${version}/${type}/${module}`,
                    };
                  }),
                };
              }),
            };

            // Apply "new" badge to latest stable release
            return version == latestStableVersion ? { ...versionGroup, badge: "New" } : versionGroup;
          }),
        },
        {
          label: "Changelog",
          link: "/changelog",
        },
        "contributing",
      ],

      favicon: "./favicon.png",

      plugins: [catppuccin()],
    }),
  ],
});

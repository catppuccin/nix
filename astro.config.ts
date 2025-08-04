import { defineConfig } from "astro/config";
import catppuccin from "@catppuccin/starlight";
import starlight from "@astrojs/starlight";
import astroExpressiveCode from "astro-expressive-code";

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
        baseUrl: "https://github.com/catppuccin/nix/edit/main/",
      },

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
            return version == latestStableVersion
              ? { ...versionGroup, badge: "New" }
              : versionGroup;
          }),
        },
        {
          label: "Frequently Asked Questions",
          link: "/faq",
        },
        {
          label: "Changelog",
          link: "/changelog",
        },
        "contributing",
      ],

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

      // Catppuccin-ified code blocks!
      // Sourced from https://github.com/catppuccin/starlight/blob/e8e4bbf83541e6dc95c89b17df844b3c2c472103/apps/docs/astro.config.ts#L23-L36
      // TODO(@getchoo): Stop vendoring this if/when we can
      expressiveCode: {
        themes: ["catppuccin-mocha", "catppuccin-latte"],
        styleOverrides: {
          textMarkers: {
            insBackground:
              "color-mix(in oklab, var(--sl-color-green-high) 25%, var(--sl-color-gray-6));",
            insBorderColor: "var(--sl-color-gray-5)",
            delBackground:
              "color-mix(in oklab, var(--sl-color-red-high) 25%, var(--sl-color-gray-6));",
            delBorderColor: "var(--sl-color-gray-5)",
          },
          codeBackground: "var(--sl-color-gray-6)",
        },
      },

      favicon: "./favicon.png",

      plugins: [catppuccin()],
    }),
  ],
});

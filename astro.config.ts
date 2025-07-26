import { defineConfig } from "astro/config";
import catppuccin from "@catppuccin/starlight";
import starlight from "@astrojs/starlight";

export default defineConfig({
	site: process.env.URL || "https://nix.catppuccin.com",
	integrations: [
		starlight({
			title: "catppuccin/nix",
			editLink: {
				baseUrl: "https://github.com/catppuccin/nix/edit/site/src/content/docs/"
			},
			logo: {
				src: './src/assets/logo.png'
			},
			plugins: [catppuccin()]
		}),
	],
});

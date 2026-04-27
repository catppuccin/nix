{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "wlogout";

  whiskersTemplates = [
    "templates/wlogout.tera"
    "templates/icons/wleave/hibernate.tera"
    "templates/icons/wleave/lock.tera"
    "templates/icons/wleave/logout.tera"
    "templates/icons/wleave/reboot.tera"
    "templates/icons/wleave/shutdown.tera"
    "templates/icons/wleave/suspend.tera"
    "templates/icons/wlogout/hibernate.tera"
    "templates/icons/wlogout/lock.tera"
    "templates/icons/wlogout/logout.tera"
    "templates/icons/wlogout/reboot.tera"
    "templates/icons/wlogout/shutdown.tera"
    "templates/icons/wlogout/suspend.tera"
  ];

  installTargets = [
    "themes"
    "icons"
  ];
}

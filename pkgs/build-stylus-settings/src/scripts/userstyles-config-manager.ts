import { z } from 'zod';

const UserstyleSettingSchema = z.union([
  z.string(), z.number(), z.boolean()
]);

const UserstyleSettingsSchema = z.record(UserstyleSettingSchema);

const UserstyleConfigSchema = z.record(z.object({
  enable: z.boolean().optional(),
  settings: UserstyleSettingsSchema.optional(),
  inclusions: z.array(z.string()).optional(),
  exclusions: z.array(z.string()).optional()
}));

const UserstylesConfigSchema = z.object({
  defaultSettings: UserstyleSettingsSchema.optional(),
  userstyles: UserstyleConfigSchema.optional()
});

type UserstyleSetting = z.infer<typeof UserstyleSettingSchema>;
type UserstyleConfig = z.infer<typeof UserstyleConfigSchema>;
type UserstylesConfig = z.infer<typeof UserstylesConfigSchema>;
type UserstyleProperty = keyof UserstyleConfig[string];

export class UserstylesConfigManager {
  private readonly config: UserstylesConfig;

  constructor(rawConfig: any) {
    const config = UserstylesConfigSchema.parse(rawConfig);

    // Normalize userstyle keys to lowercase
    const lowercaseUserstyles: UserstyleConfig = {};
    for (const key in config.userstyles) {
      lowercaseUserstyles[key.toLowerCase()] = config.userstyles[key];
    }
    this.config = {
      ...config,
      userstyles: lowercaseUserstyles
    };
  }

  public isEnabled(userstyleName: string) {
    const key = userstyleName.toLowerCase();
    const enabled = this.config.userstyles?.[key]?.enable;
    // We do want to return true for undefined values
    return enabled !== false;
  }

  public getProperty(userstyleName: string, property: UserstyleProperty) {
    const key = userstyleName.toLowerCase();
    return this.config.userstyles?.[key]?.[property];
  }

  public getSetting(userstyleName: string, setting: string, fallback: UserstyleSetting | undefined): UserstyleSetting {
    const key = userstyleName.toLowerCase();
    const value = this.config.userstyles?.[key]?.settings?.[setting] // from userstyle settings
      ?? this.config.defaultSettings?.[setting]; // from default settings
    if (value !== undefined) return value;
    if (fallback !== undefined) return fallback;
    throw new Error(`Could not find value for "${userstyleName}"."${setting}"`);
  }
}

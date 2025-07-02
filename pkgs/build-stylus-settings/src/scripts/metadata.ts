import { z } from 'zod';
import usercssMeta from 'usercss-meta';

// The format that the script expects metadata to be in
const metadataSchema = z.object({
  name: z.string().nonempty(),
  description: z.string().optional(),
  author: z.string().optional(),
  vars: z.record(z.object({
    name: z.string().nonempty(),
    default: z.union([z.string().nonempty(), z.number()]).optional()
  })).optional(),
  url: z.string().optional(),
}).catchall(z.unknown());

type Metadata = z.infer<typeof metadataSchema>;

export function parseMeta(usersyle: string) {
  const { metadata } = usercssMeta.parse(usersyle);
  return metadataSchema.parse(metadata);
}

export function stringifyMeta(metadata: Metadata) {
  return usercssMeta.stringify(metadata as unknown as usercssMeta.Metadata, {});
}


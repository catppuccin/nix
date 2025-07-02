import postcss from 'postcss';

/*
  This entire file, along with the preprocessing steps in main.ts
  could probably be replaced by stylus/src/js/usercss-compiler.js:
  https://github.com/openstyles/stylus/blob/e9eb9fcea9c336dd1cec9c2c8c8e3b0f05d7b733/src/js/usercss-compiler.js#L111
*/

type SectionMatchType = 'domains' | 'regexps' | 'urlPrefixes';

type Section = {
  code: string,
  start: number,
} & Partial<Record<SectionMatchType, string[]>>;

export function generateStylusSections(css: string) {
  const cssRoot = postcss.parse(css);
  const sections: Section[] = []

  cssRoot.walkAtRules('-moz-document', (rule: postcss.AtRule) => {
    const content = rule.nodes?.map(n => n.toString()).join('\n') ?? '';

    const section: Section = {
      code: content,
      start: sections.map(s => s.code).join('\n').length
    };

    const matchTypeMapping: Record<string, SectionMatchType> = {
      domain: "domains",
      regexp: "regexps",
      "url-prefix": "urlPrefixes"
    };

    const conditions = rule.params?.split(', ') ?? [];
    conditions.forEach(condition => {
      // match condition name and argument
      // e.g. for domain("docs.github.com"):
      // match[0] domain("docs.github.com")
      // match[1] domain
      // match[2] docs.github.com
      const match = condition.match(/^([\w-]+)\("(.+)"\)$/);
      if (!match) throw new Error(`Could not parse condition name from '${condition}'`);

      const conditionName = match[1];
      const conditionArgument = match[2].replace(/\\\\/g, "\\"); // Remove extra level of escaping

      if (!(conditionName in matchTypeMapping)) {
        throw new Error(`Unknown condition name '${conditionName}'`);
      }

      const stylusRule = matchTypeMapping[conditionName];

      if (!Array.isArray(section[stylusRule])) section[stylusRule] = [];
      section[stylusRule].push(conditionArgument);
    })

    sections.push(section);
    rule.remove();
  });

  cssRoot.walkComments(comment => { comment.remove() });

  const unhandledCss = cssRoot.toString().trim();
  if (unhandledCss) throw new Error(`Unhandled CSS: ${unhandledCss}`);

  return sections;
}

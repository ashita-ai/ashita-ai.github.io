# Agent Brief: Ashita Blog

Artifact maturity: public writing candidate unless draft/research files say otherwise.

## Scope
This repo owns Evan's public blog and project pages.

## Voice and positioning
- Declarative, evidence-first, short paragraphs.
- No emojis.
- Prefer periods, commas, colons, and parentheses over em-dashes.
- Verify citations before using them.
- Keep company/product primitives as examples or hypotheses unless publicly accepted.
- Current safer public umbrella: "Generation got cheap. Verification did not."

## Required workflow for writing agents
1. Read `CLAUDE.md` and this file.
2. Check `git status --short` and current branch.
3. For posts, verify:
   - frontmatter date/title/layout/category;
   - internal links use `/blog/slug/`;
   - every citation supports the claim;
   - the post includes `What I am still figuring out`;
   - closing section after `---` circles back to the opening.
4. Run the local build/check command if dependencies are available. If not, say exactly what was not run.
5. Do not publish or strengthen claims from unaccepted Ardent/product vocabulary.

## Hard rules
- No fabricated citations.
- No unverified quotes.
- No secrets or private/company-sensitive details.
- No AI co-author commit trailers.

## Current watchpoint
The verification essay may use Ardent/database work as an example, but the thesis should remain broader than Ardent and should not imply Ardent has accepted a specific product primitive.

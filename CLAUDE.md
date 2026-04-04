# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this repository.

## Project

my-ppm — Personal PPM package repository for ArnaudKleinveld. Contains config overrides and custom packages that take precedence over upstream ppm sources (pde-ppm, pdt-ppm) via PPM's "first occurrence wins" rule.

## PPM Package Structure

Each package lives under `packages/<name>/`:

```
packages/<name>/
  package.yml     # metadata: version, author, depends
  install.sh      # optional: pre/post_install hooks, OS-specific install
  home/           # optional: stow target → $HOME (symlinked by GNU Stow)
```

Config files go in `home/.config/<tool>/` and get symlinked to `~/.config/<tool>/` on install.

## Source Precedence

This repo is registered in `~/.config/ppm/sources.list`. Repos are processed in order — first match wins. This repo should appear in the list so its packages override pde-ppm/pdt-ppm defaults where needed.

## Current Packages

- **ghostty** — Overrides pde-ppm ghostty config. Uses `bell-features = system` (audible system bell) instead of the default visual bell icon in tabs.

## Environment

- **Node.js:** Managed exclusively by mise. nvm and homebrew node were removed to avoid ABI/version conflicts.
- **Shell:** zsh with Powerlevel10k, managed by pde-ppm/zsh package.

## Decisions & Discoveries

- **2026-04-04:** Removed nvm loader from `~/.zshrc` and uninstalled homebrew `node` — three competing Node.js sources (nvm v24.10.0, mise v25.6.1, brew v25.8.1) caused MODULE_VERSION mismatches when compiling native addons like `better-sqlite3`. mise is the single source now.
- **2026-04-04:** After `ppm update`, dangling symlink `~/.config/zsh/nfs.zsh` caused Powerlevel10k instant prompt warnings. `ppm install pde-ppm/zsh` did not clean it up — had to remove manually. Watch for stale symlinks after upstream package changes.

## Working Practice: Continuous Context

Keep CLAUDE.md as the living source of truth. When discoveries are made during a session (e.g., environment issues, configuration decisions, package changes), immediately update:

1. **CLAUDE.md** — for facts and decisions that future sessions need
2. **Git** — commit changes so context is preserved across machines

This ensures any new Claude Code session can pick up full context from a cold start without relying on conversation history.

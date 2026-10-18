---
name: "deploy-wp-artifacts-tmd-rnt"
description: "Deploy TMD and RNT WordPress themes/plugins to G12 production (or local) via the TMD release-toolkit deploy scripts and the RNT Ansible artifact playbook. Use for dry-runs, real deploys, and verification of tmd_core, tmd4, rnt_theme, rnt_core."
version: 1
created: "2026-09-12"
updated: "2026-09-12"
---
## When to Use
Use when deploying or validating deployment of any of the four WordPress consumer repos: tmd_core (plugin), tmd4 (theme) via the shared TMD toolkit deploy scripts, or rnt_core (plugin), rnt_theme (theme) via the Ansible artifact playbook. Trigger words: deploy, dry-run, release to production, push artifact to G12, verify deployment. Always dry-run/ansible --check first; only real-deploy after explicit user approval.

## Procedure
1. REPO PATHS: tmd_core=/Users/danieldekay/Dokumente/projects/programmieren/tmd_core, tmd4=/Users/danieldekay/Dokumente/projects/programmieren/tmd4, rnt_theme=/Users/danieldekay/Dokumente/projects/programmieren/rnt_theme, rnt_core=/Users/danieldekay/Dokumente/projects/programmieren/rnt_core. Ansible repo=/Users/danieldekay/Dokumente/projects/servers/ansible (read AGENTS.md + .github/skills/g12-ops/SKILL.md first for auth canon).
2. TMD (tmd_core, tmd4) — dry-run first: cd <repo-root> && printf 'n\n2\n1\ny\n' | ./deploy/scripts/deploy.sh --dry-run. Input sequence is menu answers: [commit dirty?=n][target=2 latest-tag][env=1 production][confirm=y]. If the working tree is CLEAN (no git status output), omit the leading 'n' (use '2\n1\ny\n') or the 'n' is consumed as the target choice and the run fails. Expect: git archive of latest tag, composer install in temp package, rsync --dry-run --itemize-changes to tangoverse-g12:/tmp/tmd_core-deploy (or /tmp/tmd4-deploy), end with 'Dry run complete. Skipping remote container activation.' and exit 0.
3. TMD real deploy (only after explicit approval): same command WITHOUT --dry-run. Flow: rsync package to /tmp/<slug>-deploy on tangoverse-g12, then ssh + docker exec tmd-wordpress: backup existing dir to <path>.prev, swap, chown www-data, wp cache flush, version-header grep back. Verification: exit 0 + version grep line + site https://www.tangomarathons.com/ + wp-admin. The .prev dir is the rollback point.
4. RNT (rnt_theme, rnt_core) — ansible --check first: cd /Users/danieldekay/Dokumente/projects/servers/ansible && bash scripts/run-ansible.sh playbooks/g12/wordpress-artifact-deploy.yml -i inventories/netcup/hosts.yml --check -e 'artifact_local_path=<abs zip>' -e 'artifact_type=theme|plugin' -e 'artifact_slug=rnt_theme|rnt_core' -e 'artifact_activate=true'. Real artifacts: /Users/danieldekay/Dokumente/projects/programmieren/rnt_theme/releases/rnt_theme-v2.4.6.zip, rnt_core/releases/rnt_core-v1.2.6.zip. Expected: validate asserts pass, 'Ensure remote artifact staging directory exists' ok, WP-CLI install/verify tasks SKIPPED (check mode), recap ok=9 changed=1 unreachable=0 failed=0, exit 0.
5. RNT real deploy (only after explicit approval): same command without --check. Flow: copy zip to /tmp/rnt-wordpress-artifacts, docker compose run wpcli plugin/theme install --force --activate, then is-installed + is-active asserts, cache flush, removes remote zip. Verify recap failed=0 and the site.
6. Post-deploy verification for all: site URL (https://www.tangomarathons.com/ for TMD production), wp-admin login, and build metadata: TMD packages stamp build-metadata.php (version/git_hash/built_at); RNT deployment summary lists artifact/type/slug/target service dir /opt/services/rnt-wordpress. Do not infer deployed version from local .git.

## Pitfalls
- INVENTORY TRAP: G12 production host rs1000-g12 lives in inventories/netcup/hosts.yml. inventories/prod/hosts.yml is the debbie HOMELAB — never run these playbooks against prod inventory.
- AUTH: run-ansible.sh is the ONLY playbook entry point (sources Keychain SA token ansible-op-svc-token). Raw `uv run ansible-playbook` fails the vault password script (get-vault-password.sh needs personal op session or sourced token). Validate SA first: `source scripts/load-op-token.sh && op read 'op://Infrastructure/KEY Ansible - vault-encryption/password' >/dev/null && echo SA_READ_OK`. op whoami is NOT proof of auth. Personal `op signin` does not persist across shell invocations.
- TMD dry-run intentionally stops BEFORE container activation — it does not prove the docker cp/swap/activation works. Only a real deploy does.
- TMD consumers still pin the OLD shared toolkit via TMD_RELEASE_TOOLKIT_ROOT defaulting to ~/coding/tmd-release-toolkit (the generalized wp-release-toolkit at ~/Dokumente/projects/programmieren/wp-release-toolkit exists but consumers are NOT migrated to WP_RELEASE_TOOLKIT_ROOT yet).
- deploy scripts may prompt to commit dirty changes (answer n to continue dirty; git archive uses the ref so dirtiness does not affect package content).
- RNT deploy-auto.sh in rnt_theme/rnt_core is LEGACY (netcup-webserver-shared git-pull, interactive, no dry-run, no auto mode). Production was cut over to the G12 Ansible artifact playbook — do not use deploy-auto.sh for production.
- TMD_RELEASE_AUTO / RNT_RELEASE_AUTO: RNT release.sh honors RNT_RELEASE_AUTO=true + --dry-run; TMD release.sh defines TMD_RELEASE_AUTO but it is never consumed (release still prompts).
- Never export/print secrets (tokens, vault password). Never ask the user for passwords — service account is read-only and suffices for deploys.
- Real deploys are state-changing: modify wp-content on prod and activate plugins/themes. Always dry-run/--check first and get explicit user approval before a real deploy; rely on .prev backups (TMD) / wp-cli transactional install (RNT) for rollback.

## Verification
1. TMD dry-run: exit code 0 AND final line 'Dry run complete. Skipping remote container activation.' and rsync itemize output present.
2. TMD real deploy: exit 0, version header grep echoed from container, site + wp-admin reachable (HTTP non-500).
3. RNT --check: PLAY RECAP shows unreachable=0 failed=0 and WP-CLI tasks reported as skipped.
4. RNT real deploy: PLAY RECAP failed=0 unreachable=0; is-installed and is-active tasks ok; remote zip removed.
5. SSH reachability before TMD runs: ssh -o ConnectTimeout=10 tangoverse-g12 'docker ps --format "{{.Names}}" | grep tmd-wordpress' returns the container (Up/healthy).
6. Local sanity before any run: bash -n on the deploy script(s) and --help must both pass.
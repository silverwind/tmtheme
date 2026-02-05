node_modules: pnpm-lock.yaml
	pnpm install
	@touch node_modules

.PHONY: deps
deps: node_modules

.PHONY: build
build: node_modules
	pnpm exec @vscode/vsce package

.PHONY: publish
publish: node_modules
	pnpm exec @vscode/vsce publish
	rm -f *.vsix

.PHONY: update
update: node_modules
	pnpm exec updates -u
	rm pnpm-lock.yaml
	pnpm install
	@touch node_modules

.PHONY: patch
patch: node_modules
	pnpm exec versions -c 'make --no-print-directory build' patch package.json
	@$(MAKE) --no-print-directory publish

.PHONY: minor
minor: node_modules
	pnpm exec versions -c 'make --no-print-directory build' minor package.json
	@$(MAKE) --no-print-directory publish

.PHONY: major
major: node_modules
	pnpm exec versions -c 'make --no-print-directory build' major package.json
	@$(MAKE) --no-print-directory publish

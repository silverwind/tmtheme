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
	pnpm publish --no-git-checks

.PHONY: update
update: update-js update-actions

.PHONY: update-js
update-js: node_modules
	pnpm exec updates -u -f package.json
	rm -rf node_modules pnpm-lock.yaml
	pnpm install
	@touch node_modules

.PHONY: patch minor major
patch minor major: node_modules
	pnpm exec versions -R -c 'make --no-print-directory build' $@ package.json

.PHONY: update-actions
update-actions: node_modules
	pnpm exec updates -u -M actions

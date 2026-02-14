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
update: node_modules
	pnpm exec updates -u
	rm pnpm-lock.yaml
	pnpm install
	@touch node_modules

.PHONY: patch
patch: node_modules
	pnpm exec versions -c 'make --no-print-directory build' patch package.json
	git push -u --tags origin master

.PHONY: minor
minor: node_modules
	pnpm exec versions -c 'make --no-print-directory build' minor package.json
	git push -u --tags origin master

.PHONY: major
major: node_modules
	pnpm exec versions -c 'make --no-print-directory build' major package.json
	git push -u --tags origin master

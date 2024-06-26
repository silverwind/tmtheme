node_modules: package-lock.json
	npm install --no-save
	@touch node_modules

.PHONY: deps
deps: node_modules

.PHONY: build
build: node_modules
	npx @vscode/vsce package

.PHONY: publish
publish: node_modules
	npx @vscode/vsce publish
	rm -f *.vsix

.PHONY: update
update: node_modules
	npx updates -u
	rm package-lock.json
	npm install
	@touch node_modules

.PHONY: patch
patch: node_modules
	npx versions -c 'make --no-print-directory build' patch package.json package-lock.json
	@$(MAKE) --no-print-directory publish

.PHONY: minor
minor: node_modules
	npx versions -c 'make --no-print-directory build' minor package.json package-lock.json
	@$(MAKE) --no-print-directory publish

.PHONY: major
major: node_modules
	npx versions -c 'make --no-print-directory build' major package.json package-lock.json
	@$(MAKE) --no-print-directory publish

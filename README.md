# Kai Hendry's Homebrew tap

## Install Annotate

```sh
brew install kaihendry/tap/annotate
```

[Annotate](https://github.com/kaihendry/annotate) draws boxes, arrows, and text
on screenshots. The formula builds from a checksummed source release using
Apple's Command Line Tools, which Homebrew normally installs during setup.
It installs both the `annotate` command and `Annotate.app`; no `sudo` is needed.

```sh
annotate                 # load a screenshot from the clipboard
annotate screenshot.png  # open an existing image
```

For Finder and Spotlight, optionally link the app into your Applications folder:

```sh
mkdir -p ~/Applications
ln -s "$(brew --prefix kaihendry/tap/annotate)/Annotate.app" ~/Applications/Annotate.app
```

Use `brew upgrade kaihendry/tap/annotate` to update and
`brew uninstall kaihendry/tap/annotate` to remove it. If you created the optional
Applications link, remove that link when uninstalling.

## Maintenance

Publish a new Annotate version tag, then update the formula's `url` and `sha256`:

```sh
curl -fL https://github.com/kaihendry/annotate/archive/refs/tags/vVERSION.tar.gz -o /tmp/annotate.tar.gz
shasum -a 256 /tmp/annotate.tar.gz
```

Validate with `brew audit --strict kaihendry/tap/annotate`,
`brew install --build-from-source kaihendry/tap/annotate` (or `brew reinstall`
if already installed), and `brew test kaihendry/tap/annotate`.
CI checks source builds and PNG exports on Apple Silicon and Intel Macs.

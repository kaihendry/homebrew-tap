# Kai Hendry's Homebrew tap

## Install Annotate

```sh
brew install kaihendry/tap/annotate
```

[Annotate](https://github.com/kaihendry/annotate) draws boxes, arrows, and text
on screenshots. The formula builds from a checksummed source release using
Apple's Command Line Tools, which Homebrew normally installs during setup.
It installs both the `annotate-screenshot` command and `Annotate.app`; no `sudo`
is needed. The command name avoids a collision with the `annotate` utility
provided by Homebrew's `gd` package.

```sh
annotate-screenshot                 # load a screenshot from the clipboard
annotate-screenshot screenshot.png  # open an existing image
```

For Finder and Spotlight, optionally link the app into your Applications folder:

```sh
mkdir -p ~/Applications
ln -s "$(brew --prefix kaihendry/tap/annotate)/Annotate.app" ~/Applications/Annotate.app
```

Use `brew upgrade kaihendry/tap/annotate` to update and
`brew uninstall kaihendry/tap/annotate` to remove it. If you created the optional
Applications link, remove that link when uninstalling.

## Install Keypress

```sh
brew install kaihendry/tap/keypress
keypress
```

[Keypress](https://github.com/kaihendry/keypress) is a menu bar activity counter with
recent APM, a task stopwatch, keyboard actions, clicks, scroll strokes, and observed gestures, with a Fitts's-law
pointing-difficulty estimate. It builds from a checksummed source release using
Apple's Swift 6+ toolchain. Enable Accessibility and Input Monitoring on first use.

```sh
mkdir -p ~/Applications
ln -s "$(brew --prefix kaihendry/tap/keypress)/Keypress.app" ~/Applications/Keypress.app
```

Update with `brew upgrade kaihendry/tap/keypress`. Updates do not restart the app:
choose **Quit** in its panel, then run `keypress` again. Quitting clears session
totals. The panel shows the running Git revision; `keypress --version` shows the
installed revision. Remove it with `brew uninstall kaihendry/tap/keypress` and
remove the optional Applications link if you created it.

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

For Keypress, tag a clean commit, create a source archive with
`git archive --format=tar.gz --prefix=keypress-VERSION/ -o keypress-VERSION.tar.gz vVERSION`,
and attach it to the GitHub release. Update the formula's URL, SHA-256, and expected
Git revision. The archive embeds the commit through `.git_archival.txt`.
Validate with `brew audit --strict kaihendry/tap/keypress`,
`brew install --build-from-source kaihendry/tap/keypress`, and
`brew test kaihendry/tap/keypress`.

# gentoo-overlay

Personal Gentoo overlay.

## Packages

| Package | Notes |
| --- | --- |
| gui-wm/wlmaker-0.8.1 | Wayland Maker, a Wayland compositor inspired by Window Maker (wlroots 0.18-0.20) |

## Installing on Gentoo

All commands run as root.

### 1. Add the overlay

Using `eselect-repository` (recommended):

```
emerge --ask --noreplace app-eselect/eselect-repository dev-vcs/git
eselect repository add gentoo-overlay git https://github.com/pedro-pereira-dev/gentoo-overlay.git
emerge --sync gentoo-overlay
```

Or manually, without `eselect-repository`:

```
cat > /etc/portage/repos.conf/gentoo-overlay.conf <<'EOF'
[gentoo-overlay]
location = /var/db/repos/gentoo-overlay
sync-type = git
sync-uri = https://github.com/pedro-pereira-dev/gentoo-overlay.git
auto-sync = yes
EOF
emerge --sync gentoo-overlay
```

### 2. Accept the testing keyword

The ebuild is keyworded `~amd64`:

```
mkdir -p /etc/portage/package.accept_keywords
echo "gui-wm/wlmaker ~amd64" > /etc/portage/package.accept_keywords/wlmaker
```

### 3. Optional: set USE flags

| Flag | Effect |
| --- | --- |
| `xwayland` | Run X11 clients (pulls in `x11-base/xwayland` and `wlroots[X]`) |
| `doc` | Build API documentation with doxygen and plantuml |
| `debug` | Build with debugging information |
| `test` | Run the test suite (with `FEATURES=test`) |

```
mkdir -p /etc/portage/package.use
echo "gui-wm/wlmaker xwayland" > /etc/portage/package.use/wlmaker
```

### 4. Install

```
emerge --ask gui-wm/wlmaker
```

### 5. Run

A `wlmaker` entry is installed to `/usr/share/wayland-sessions/`, so display
managers list it as a session. From a TTY, run `wlmaker`. Default configuration
is in `/etc/xdg/wlmaker`.

## Updating

```
emerge --sync gentoo-overlay
emerge --ask --update gui-wm/wlmaker
```

## Development

```
pkgdev manifest gui-wm/wlmaker
pkgcheck scan
```

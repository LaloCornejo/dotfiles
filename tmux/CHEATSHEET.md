# Tmux Keybindings Cheat Sheet

**Prefix Key:** `Ctrl-A`

## 🚀 Session Management

| Key | Action |
|-----|--------|
| `Ctrl-A + o` | Open sessionx (fuzzy session picker) |
| `Ctrl-A + C-c` | Create new session |
| `Ctrl-A + C-f` | Find and switch to session |
| `Ctrl-A + s` | List all sessions |
| `Ctrl-A + d` | Detach from session |
| `Ctrl-A + $` | Rename current session |

### SessionX Bindings (within sessionx)
| Key | Action |
|-----|--------|
| `Ctrl-n` | Create new window |
| `Ctrl-x` | Kill session |
| `Ctrl-c` | Open configuration path |
| `Ctrl-t` | Tree mode |
| `Ctrl-y` | Zoxide new window |
| `Ctrl-r` | Rename session |

## 🪟 Window Management

| Key | Action |
|-----|--------|
| `Ctrl-A + c` | Create new window (in current path) |
| `Ctrl-A + &` | Kill current window |
| `Ctrl-A + ,` | Rename window |
| `Ctrl-A + n` | Next window |
| `Ctrl-A + p` | Previous window |
| `Ctrl-A + Ctrl-h` | Previous window (repeat) |
| `Ctrl-A + Ctrl-l` | Next window (repeat) |
| `Ctrl-A + 0-9` | Switch to window by number |
| `Ctrl-A + w` | List all windows |

## 📋 Pane Management

| Key | Action |
|-----|--------|
| `Ctrl-A + \|` | Split horizontally (in current path) |
| `Ctrl-A + -` | Split vertically (in current path) |
| `Ctrl-A + x` | Kill current pane |
| `Ctrl-A + z` | Toggle pane zoom |
| `Ctrl-A + !` | Break pane into new window |
| `Ctrl-A + {` | Move pane left |
| `Ctrl-A + }` | Move pane right |

### Pane Navigation
| Key | Action |
|-----|--------|
| `Ctrl-A + h` | Move to left pane |
| `Ctrl-A + j` | Move to down pane |
| `Ctrl-A + k` | Move to up pane |
| `Ctrl-A + l` | Move to right pane |
| `Ctrl-A + ;` | Move to last active pane |
| `Ctrl-A + o` | Rotate through panes |

### Vim Navigator (if nvim open)
| Key | Action |
|-----|--------|
| `Ctrl-h` | Navigate left (vim/tmux) |
| `Ctrl-j` | Navigate down (vim/tmux) |
| `Ctrl-k` | Navigate up (vim/tmux) |
| `Ctrl-l` | Navigate right (vim/tmux) |

### Pane Resizing
| Key | Action |
|-----|--------|
| `Ctrl-A + H` | Resize left (repeatable) |
| `Ctrl-A + J` | Resize down (repeatable) |
| `Ctrl-A + K` | Resize up (repeatable) |
| `Ctrl-A + L` | Resize right (repeatable) |

## 📋 Copy Mode & Selection

| Key | Action |
|-----|--------|
| `Ctrl-A + [` | Enter copy mode |
| `Ctrl-A + ]` | Paste last copied text |
| `q` | Exit copy mode |

### In Copy Mode (Vi-style)
| Key | Action |
|-----|--------|
| `v` | Start visual selection |
| `V` | Start line selection |
| `y` | Copy selection to clipboard |
| `r` | Toggle rectangle selection |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `Space` | Start selection |
| `Enter` | Copy selection |

## 🔍 Search & Navigation Plugins

| Key | Action |
|-----|--------|
| `Ctrl-A + F` | Tmux-thumbs (hint mode for copying) |
| `Ctrl-A + Tab` | Extrakto (extract URLs, paths, etc.) |
| `Ctrl-A + u` | Open URLs with fzf |
| `Ctrl-A + Ctrl-f` | Tmux-fzf (fuzzy finder) |

### Tmux-thumbs (hint mode)
| Key | Action |
|-----|--------|
| `a-z` | Copy hinted text |
| `Shift + a-z` | Copy and paste hinted text |
| `Ctrl-c` | Exit hint mode |

### Extrakto
| Key | Action |
|-----|--------|
| `Enter` | Copy selected item |
| `Tab` | Insert selected item |
| `Ctrl-o` | Open selected item |

## 🎯 Floax (Floating Terminal)

| Key | Action |
|-----|--------|
| `Ctrl-A + p` | Toggle floating terminal |

## 🔧 System & Utility

| Key | Action |
|-----|--------|
| `Ctrl-A + r` | Reload tmux config |
| `Ctrl-A + ?` | Show all keybindings |
| `Ctrl-A + t` | Show time |
| `Ctrl-A + Ctrl-k` | Clear screen and history |
| `Ctrl-A + y` | Toggle synchronize panes |
| `Ctrl-A + I` | Install plugins (TPM) |
| `Ctrl-A + U` | Update plugins (TPM) |

## 📊 Status Bar Info

The status bar shows:
- **Left:** Session name with icon
- **Center:** Window list with current window highlighted
- **Right:** Prefix highlight, time, current path

## 🎵 Music & Weather (if configured)

The status bar may also display:
- Current playing music (Apple Music)
- Weather information
- CPU usage
- Battery status

## 💡 Tips

1. **Session Workflow:** Use `Ctrl-A + o` to quickly switch between projects
2. **Pane Management:** Use `|` and `-` for intuitive splits
3. **Copy Mode:** Enter with `[`, select with `v`, copy with `y`
4. **Search:** Use thumbs (`F`) for quick text copying
5. **URLs:** Use `Ctrl-A + u` to quickly open URLs
6. **Floating Terminal:** Use `p` for temporary commands
7. **Vim Integration:** Seamless navigation between vim and tmux panes

## 🔄 Session Restoration

Sessions are automatically saved every 15 minutes and restored on tmux start thanks to tmux-continuum.

---

*Prefix: Ctrl-A | Copy to clipboard: y | Reload config: Ctrl-A + r*
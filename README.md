# Gitleaks Pre-commit Hook

A production-grade Git pre-commit hook that automatically scans staged changes for secrets using [gitleaks](https://github.com/gitleaks/gitleaks). It is designed to be "drop-in" and self-installing.

## Features

- **Automated Installation**: If `gitleaks` is not found, the hook downloads and installs the correct binary for your OS/Arch (Linux/macOS/Windows) into the repo's `.git/hooks/bin/` directory. No global installation or `sudo` required.
- **Configurable**: Can be enabled/disabled per-repo via standard `git config`.
- **Zero-Dependency Setup**: Just run the setup script.

## 🚀 Installation

1. Clone this repository.
2. Run the setup script:

```bash
./setup.sh
```

This ensures the script is executable and links it to `.git/hooks/pre-commit`.

## ⚙️ Configuration

You can toggle the hook on or off using `git config`. This is useful for CI environments or emergency bypasses without editing the hook script.

**Disable:**
```bash
git config hooks.gitleaks.enable false
```

**Enable:**
```bash
git config hooks.gitleaks.enable true
```

*(Default is enabled if the config is unset)*

## 🧪 Testing

To verify the hook works, attempt to commit a known secret pattern.

1. Create a test file with a fake Telegram Bot Token:
   ```bash
   echo "TELEGRAM_TOKEN=123456789:ABCDefGhIjKlMnOpQrStUvWxYz123456789" > secret.txt # gitleaks:allow
   ```

2. Stage the file:
   ```bash
   git add secret.txt
   ```

3. Attempt to commit:
   ```bash
   git commit -m "Test secret"
   ```

**Expected Result:**
The commit should assume **FAILED**, and you should see an output similar to:

```text
Runing Gitleaks...
...
❌ SECURITY CHECKS FAILED
Gitleaks detected secrets in your staged changes.
```

## 💻 Supported OS

The auto-installer supports:
- **macOS** (x64, arm64)
- **Linux** (x64, arm64)
- **Windows** (via Git Bash / MinGW)

*Binaries are fetched directly from official [Gitleaks Releases](https://github.com/gitleaks/gitleaks/releases).*

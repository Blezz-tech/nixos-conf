# nixos-conf


# ГЛАВНОЕ

ИСПОЛЬЗОВАТЬ ВЕРСИЮ 24.05

а потом последовательно обновлять, исправляя изменения конфигурации

## Временно отключено

1. cataclysm-dda
2. easyocr

## add to main contig

```
tesseract
kdePackages.qrca
```

```nix
services.displayManager = {
  defaultSession = "plasma";
  sddm.wayland.enable = true;
  sddm.enable = true;
  # plasma-login-manager.enable = true;
  autoLogin = {
    enable = false;
    user = "jenya";
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # libinput.enable = true;
};
```

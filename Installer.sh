#!/bin/bash

set -e

echo "[1/6] Gerekli paketler kuruluyor..."
sudo apt update && sudo apt install -y \
  git build-essential meson cmake ninja-build \
  wlroots-dev libwayland-dev libxkbcommon-dev libseat-dev libdrm-dev \
  libinput-dev libxcb-dri3-dev libvulkan-dev libudev-dev libgbm-dev \
  libgles2-mesa-dev libevdev-dev libx11-xcb-dev libxcb-ewmh-dev \
  pkg-config libpixman-1-dev libegl1-mesa-dev libxcb-composite0-dev \
  libxcb-xfixes0-dev libxcb-image0-dev libxcb-randr0-dev libxcb-render0-dev \
  libxcb-shape0-dev libxcb-util0-dev libxcb-icccm4-dev libxcb-keysyms1-dev \
  libxcb-xkb-dev libxkbcommon-x11-dev libxcb-glx0-dev wayland-protocols \
  libpam0g-dev libxcb-cursor-dev libconfig++-dev libxcb-xtest0-dev

echo "[2/6] Hyprland kaynak kodları indiriliyor..."
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland

echo "[3/6] Meson ile yapılandırılıyor (C++20)..."
meson setup build -Dcpp_std=c++20

echo "[4/6] Derleniyor..."
cd build
ninja

echo "[5/6] Kuruluyor..."
sudo ninja install

echo "[6/6] Config dosyası kopyalanıyor..."
mkdir -p ~/.config/hypr
cp /usr/local/share/hyprland/hyprland.conf.example ~/.config/hypr/hyprland.conf

echo "✅ Hyprland kurulumu tamamlandı!"
echo "➡️ Giriş ekranında Hyprland oturumu seçerek giriş yapabilirsin."

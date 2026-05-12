sudo pacman -Sy --needed git base-devel less rustup
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S --needed sway swaybg swaylock swayidle swaync swayosd eww wofi waybar nautilus kitty spotify-player grim swappy ly
yay -S --needed pavucontrol nm-applet
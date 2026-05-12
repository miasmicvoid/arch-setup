sudo pacman -Sy --needed git base-devel less
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S --needed sway swaybg swaylock swayidle swaync swayosd eww wofi waybar nautilus kitty spotify-player grim swappy 

# Inscribe thy configuration codex to decree what provisions shall be established 
# across thy realm. Counsel may be sought upon the configuration.nix(5) parchment, 
# and within the grand NixOS tome (which thou mayst summon by the decree ‘nixos-help’).


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  #DISABLE WIFI POWER SAVING
  networking.networkmanager.wifi.powersave = false;
   
  #ADD INDIAN MIRROR
/**
  nix.settings = {
  substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store" # Excellent Asian mirror
    "https://cache.nixos.org/"                      # Global fallback
  ];
  # This ensures NixOS trusts the keys from the main cache
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
};

**/
  # fast uh download speed

    nix.settings = {
  # Drastically speeds up multi-file downloads
  http-connections = 128;
  max-substitution-jobs = 128;
};




boot.kernelModules = [ "uinput" "ip_tables" "iptable_filter" "iptable_nat" "tun" ];
services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660"
  '';

  #INTEL
   
   hardware.graphics = {
  enable = true;
  # This is the crucial part for Intel hardware acceleration
  extraPackages = with pkgs; [
    intel-media-driver 
    intel-vaapi-driver 
    libvdpau-va-gl     
  ];
};





  # --- Audio & Sound Fortress ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };
  
  # Ensure the old PulseAudio service is disabled (they conflict)
  services.pulseaudio.enable = false;

hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true; # Enables battery info & advanced features
      # Manually force the controller to support both A2DP and Headset roles
      Enable = "Source,Sink,Media,Socket";
    };
  };
};
















  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };


  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = false;
 
  # Enable the Gnome Desktop Enviourment.
  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;
 







#NIRI

programs.niri.enable = true;
# Ensure Electron/Ozone apps default to Wayland natively
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

environment.sessionVariables = {
  GTK_USE_PORTAL = "1";
  GDK_BACKEND = "wayland";
};



#COSMIC 



  # Enable the COSMIC login manager (Greeter)
  services.displayManager.cosmic-greeter.enable = false;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = false;


#LXQT


services.xserver.desktopManager.lxqt.enable = false;
services.xserver.desktopManager.cde.enable = false;


#LIGHTDM

services.xserver.displayManager.lightdm.enable = false;



  #Pantheon


 # Enable the X11 windowing system.
 services.xserver.enable = true;

 # Enable the Pantheon Desktop Environment.
 services.desktopManager.pantheon.enable = false;
 services.xserver.displayManager.lightdm.greeters.pantheon.enable = false;
/**
# Enable automatic login to the Pantheon session
services.displayManager.autoLogin = {
  enable = true;
  user = "pratham"; # Put your username here
};

**/

















  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #FLATPACK
   
  # Enable Flatpak support for Discover
  services.flatpak.enable = true;

## also use flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo



    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pratham = {
    isNormalUser = true;
    description = "Prathamesh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  


    vlc
   #gimp
    fortune
    discord
    element-desktop
    fastfetch
    aria2
    libva-vdpau-driver
    libvdpau-va-gl
    intel-media-driver
    intel-vaapi-driver
    google-chrome
    wget
    prismlauncher
    jetbrains.idea
    bluej
    cloudflare-warp
    waydroid
    #for waydoid
    iptables
    #byeeee
    #for niri
    xwayland-satellite
    alacritty
    fuzzel
    bibata-cursors
    brightnessctl
    swaybg
    nautilus
    glib
    adwaita-icon-theme
    qview
    overskride
    pavucontrol
    bemoji
    wtype
    
    mission-center











  ];




  # Allow system to locate cursor themes in /run/current-system/sw/share/icons
  environment.sessionVariables = {
    XCURSOR_PATH = [
      "$HOME/.icons"
      "$HOME/.nix-profile/share/icons"
      "/run/current-system/sw/share/icons"
    ];
  };


programs.dconf.enable = true;

# 1.1.1.1

services.cloudflare-warp.enable = true;




#WAYDROID MODULE






networking.nftables.enable = true;
networking.firewall = {
  enable = true;
  trustedInterfaces = [ "waydroid0" ];
};

virtualisation.waydroid.enable = true;

















#PICKUP LINES


  # Add this to your configuration.nix
programs.bash.shellAliases = {

  update = "sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";


  # Clean up the "Ghost" generations
  garbage  = "sudo nix-collect-garbage -d  && sudo nix-store --optimise";
 
  #ARIA
  aria = "aria2c -x 16 -s 64 -j 64 -k 1M";
  
  #REBUILD
  jadhav = "sudo nixos-rebuild switch --log-format bar-with-logs";

  #CONFIG

  sharanya = "sudo nano /etc/nixos/configuration.nix";
  
  #WARP CLI

  warp = "warp-cli";

  #NIRI
  
  ni = "sudo nano ~/.config/niri/config.kdl";

 #nmtui

  wifi = "nmtui";

 #net speed boost

  connect = "warp-cli connect && warp-cli mode warp+dot";


  disconnect = "warp-cli disconnect";

  #CHANNEL?

  channel = "sudo nix-channel --list";

  #github bacup

  backup = "sudo systemctl start daily-config-backup.service";

  backuplog = "systemctl status daily-config-backup.service";

  #sleep

  suspend = "systemctl suspend";

};











#NIRIS
xdg.portal = {
  enable = true;
  configPackages = [ pkgs.niri ];
  
  extraPortals = [
    pkgs.xdg-desktop-portal-gtk  # We keep this one
    # REMOVE pkgs.xdg-desktop-portal-gnome if it's there
  ];
  
  config = {
    common = {
      # Use GTK for everything, including the FileChooser
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      "default" = [ "gtk" ];
    };
  };
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

 




   #BACKUP


 




systemd.services.daily-config-backup = {
    description = "Backup NixOS and Niri configurations to GitHub";
    after = [ "network-online.target" "local-fs.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    
    path = [ pkgs.git pkgs.openssh pkgs.coreutils ]; 

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    script = ''
      REPO_DIR="/var/backup/git-configs"
      GITHUB_URL="git@github.com:PROBRO2600/Nixos.git"
      
      echo "Starting config backup to GitHub..."
      export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new"

      # 1. If it's a completely fresh run, clone the repo instead of initializing blank
      if [ ! -d "$REPO_DIR/.git" ]; then
        echo "Workspace empty or broken. Cloning fresh repository from GitHub..."
        rm -rf "$REPO_DIR" # Clean up any partial un-tracked folders
        git clone "$GITHUB_URL" "$REPO_DIR"
      fi

      cd "$REPO_DIR"
      
      # Configure user identity for this workspace
      git config user.name "NixOS Backup Daemon"
      git config user.email "backup-daemon@localhost"

      # Create folders inside the repo if they don't exist yet
      mkdir -p "nixos"
      mkdir -p "niri"

      # 2. Pull down any remote updates before making modifications
      echo "Syncing latest history from GitHub..."
      git pull origin main --no-rebase -X theirs --no-edit || true

      # 3. Copy your live system files into the repo folder
      cp -r /etc/nixos/* "nixos/"
      cp /home/pratham/.config/niri/config.kdl "niri/"

      # 4. Stage, commit, and push
      git add .
      
      if ! git diff-index --quiet HEAD --; then
        git commit -m "Automated backup: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Pushing changes to GitHub..."
        git push origin main
      else
        echo "No changes detected. Skipping push."
      fi
    '';
  };































 # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}

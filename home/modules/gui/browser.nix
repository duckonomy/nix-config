{ pkgs, ... }:
{
  programs = {
    firefox = {
      enable = true;
    };

    chromium = {
      enable = true;
      package = pkgs.google-chrome;
      commandLineArgs = [
        "--password-store=gnome-libsecret"
        "--ozone-platform=wayland"
        "--use-vulkan"
        "--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,WaylandWindowDecorations,AcceleratedVideoDecodeLinuxGL"
        "--ozone-platform-hint=auto"
        "--gtk-version=4"
      ];
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        {
          id = "dcpihecpambacapedldabdbpakmachpb";
          updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        }
        {
          id = "aaaaaaaaaabbbbbbbbbbcccccccccc";
          crxPath = "/home/share/extension.crx";
          version = "1.0";
        }
      ];
    };

    browserpass = {
      enable = true;
      browsers = [
        "chrome"
        "firefox"
      ];
    };
  };
}

{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
  };
}


#   chromium.extensions = {
#   [
#   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
#   {
#     id = "dcpihecpambacapedldabdbpakmachpb";
#     updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
#   }
#   {
#     id = "aaaaaaaaaabbbbbbbbbbcccccccccc";
#     crxPath = "/home/share/extension.crx";
#     version = "1.0";
#   }
# ]

# }

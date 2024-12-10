
  # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp -I/home/duckonomy/.config/xkb /home/duckonomy/layout.xkb $DISPLAY";

  # JUST UNCOMMENT FROM HERE TO  (READBOTTOM)
  # services.xserver = {
  #   enable = true;
  #   desktopManager = {
  #     gnome.enable = true;
  #   };

  #   displayManager = {
  #     gdm.enable = true;
  #   };
  # };

  # COMMENTED: sway probs handles this
  # services.xserver.libinput.touchpad.naturalScrolling = true;
  # services.xserver.libinput.touchpad.accelProfile = "flat";
  # services.xserver.libinput.touchpad.accelSpeed = "0";

  # COMMENTED: sway probs handles this
  # services.xserver.libinput.mouse.accelProfile = "flat";
  # services.xserver.libinput.mouse.accelSpeed = "0";
  # services.xserver.config = ''
  #   Section "InputClass"
  #     Identifier "mouse accel"
  #     Driver "libinput"
  #     MatchIsPointer "on"
  #     Option "AccelProfile" "flat"
  #     Option "AccelSpeed" "0"
  #   EndSection
  # '';

  # COMMENTED: sway probs handles this
  # services.xserver.layout = "kr-better";
  # services.xserver.xkbOptions = "caps:escape, ctrl:swap_lalt_lctl";
  # services.xserver.autoRepeatInterval = 40;
  # services.xserver.autoRepeatDelay = 200;

  # services.xserver.xkbOptions = "custom:rctrl_hanja, custom:rwin_hangul, custom:prsc_hangul, custom:ralt_lalt, custom:nocapsescape, custom:lalt_lctl";
  # services.xserver.exportConfiguration = true;
  # let
  #   compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
  #     ${pkgs.xorg.xkbcomp}/bin/xkbcomp -I/home/duckonomy/.config/xkb ${/home/duckonomy/layout.xkb} $out
  #   '';
  # in
  # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp -I/home/duckonomy/.config/xkb ${compiledLayout} $DISPLAY";


  # COMMENTED: sway probs handles this
  # services.xserver.extraLayouts = {
  #   kr-better = {
  #     description = "Better Korean";
  #     languages = ["eng"];
  #     symbolsFile = builtins.toFile "kr-better" ''
  #     default  alphanumeric_keys
  #     xkb_symbols "kr-better106" {
  #         include "us"
  #         name[Group1]= "Korean (Modified)";
  #         include "kr-better(hw_keys)"

  #         // korean:rwin_hangul
  #         replace key <RWIN> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul ]
  #         };

  #         // korean:rctrl_hanja // Default
  #         replace key <RCTL> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul_Hanja ]
  #         };

  #         // korean:prsc_hangul
  #         replace key <PRSC> { [ Hangul ] };
  #         replace key <TLDE> { [ Escape ] };
  #         replace key <ESC> { [ grave, asciitilde ] };
  #         replace key <MENU> { [ Hangul ] };

  #         // korean:prsc_hangul_lv
  #         replace key <PRSC> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1] = [ Hangul ]
  #         };

  #         // korean:ralt_lalt
  #         replace key <RALT> { [ Alt_L, Meta_L ] };
  #     };

  #     alphanumeric_keys
  #     xkb_symbols "kr-better104" {
  #         include "us"
  #         name[Group1]= "Korean (101/104 key compatible) (modified)";
  #         include "kr-better(ralt_hangul)"
  #         include "kr-better(rctrl_hanja)"

  #         replace key <PRSC> { [ Hangul ] };
  #         replace key <TLDE> { [ Escape ] };
  #         replace key <ESC> { [ grave, asciitilde ] };
  #         replace key <MENU> { [ Hangul ] };
  #     };

  #     partial function_keys
  #     xkb_symbols "hw_keys" {
  #         key <HNGL> { [ Hangul       ] };
  #         key <HJCV> { [ Hangul_Hanja ] };
  #     };

  #     partial function_keys
  #     xkb_symbols "tlde_escape" {
  #         replace key <ESC> {
  #             [ grave, asciitilde ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "escape_tlde" {
  #         replace key <TLDE> {
  #             [ Escape ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "ralt_hangul" {
  #         replace key <RALT> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "rctrl_hangul" {
  #         replace key <RCTL> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "ralt_hanja" {
  #         replace key <RALT> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul_Hanja ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "rctrl_hanja" {
  #         replace key <RCTL> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul_Hanja ]
  #         };
  #     };
  #     '';
  #   };
  # };

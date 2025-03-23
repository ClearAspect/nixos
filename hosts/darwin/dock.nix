{
  config,
  pkgs,
  ...
}: {
  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    {path = "/System/Applications/Launchpad.app/";}
    {path = "/Applications/Safari.app/";}
    {path = "/System/Applications/Messages.app/";}
    {path = "/System/Applications/Mail.app/";}
    {path = "/System/Applications/Photos.app/";}
    {path = "/System/Applications/Facetime.app/";}
    {path = "/System/Applications/Calendar.app/";}
    {path = "/System/Applications/Contacts.app/";}
    {path = "/System/Applications/Reminders.app/";}
    {path = "/System/Applications/Notes.app/";}
    {path = "/System/Applications/Music.app/";}
    {path = "/System/Applications/App Store.app/";}
    {path = "/System/Applications/System Settings.app/";}
    {path = "/Applications/Firefox.app/";}
    {path = "/Applications/Discord.app/";}
    # {path = "/Applications/Kitty.app/";}
    {path = "/Applications/Ghostty.app/";}
  ];
}

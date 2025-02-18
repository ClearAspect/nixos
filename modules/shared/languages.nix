{pkgs}:
with pkgs; [
  # ┏━━━━━━━━━━━┓
  # ┃   C/C++   ┃
  # ┗━━━━━━━━━━━┛
  gcc
  clang-tools # Language server & formatter
  cmake
  gnumake

  # ┏━━━━━━━━━━┓
  # ┃   Java   ┃
  # ┗━━━━━━━━━━┛
  jdt-language-server
  maven
  openjdk

  # ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  # ┃   JavaScript/TypeScript   ┃
  # ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  biome # Language server & Formatter
  nodejs
  typescript-language-server

  # ┏━━━━━━━━━┓
  # ┃   Lua   ┃
  # ┗━━━━━━━━━┛
  lua
  lua-language-server

  # ┏━━━━━━━━━┓
  # ┃   Nix   ┃
  # ┗━━━━━━━━━┛
  alejandra # Formatter
  nixd # Language server

  # ┏━━━━━━━━━━━━┓
  # ┃   Python   ┃
  # ┗━━━━━━━━━━━━┛
  python3
  ruff # LSP & formatter

  # ┏━━━━━━━━━━┓
  # ┃   Rust   ┃
  # ┗━━━━━━━━━━┛
  rustup # Rust toolchain (Contains rustanalyzer, rustfmt, cargo)

  # ┏━━━━━━━━━┓
  # ┃   SQL   ┃
  # ┗━━━━━━━━━┛
  sqls # Language server

  # ┏━━━━━━━━━┓
  # ┃   Zig   ┃
  # ┗━━━━━━━━━┛
  zigpkgs.master
]

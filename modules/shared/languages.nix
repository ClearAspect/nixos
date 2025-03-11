{pkgs}:
with pkgs; [
  # ┏━━━━━━━━━┓
  # ┃   ASM   ┃
  # ┗━━━━━━━━━┛
  asmfmt
  asm-lsp

  # ┏━━━━━━━━━━━┓
  # ┃   C/C++   ┃
  # ┗━━━━━━━━━━━┛
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
  nodePackages.npm
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
  zls # Language Server (Foormatter is included with the compiler)
  zigpkgs.master

  # ┏━━━━━━━━━━━┓
  # ┃   other   ┃
  # ┗━━━━━━━━━━━┛
]

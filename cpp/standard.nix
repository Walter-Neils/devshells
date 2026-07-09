{ pkgs, ... }: {
  packages = with pkgs; [
    gcc13
    gnumake
    cmake
    ninja
    gdb
    valgrind
    clang-tools
  ];

  env = [
    { name = "CXXFLAGS"; value = "-Wall -Wextra -O2 -std=c++20"; }
  ];
}

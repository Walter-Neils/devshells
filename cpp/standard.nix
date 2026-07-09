{ pkgs }:

pkgs.mkShell {
  name = "cpp-dev-shell";

  # Packages required at runtime / development
  buildInputs = with pkgs; [
    # Compiler & Core Toolchain
    gcc13              # or 'llvmPackages_17.clang' if you prefer Clang
    gnumake
    cmake
    ninja

    # Libraries (Add any project dependencies here)
    boost
    gtest              # Google Test framework
  ];

  # Utilities and Quality of Life Tools
  nativeBuildInputs = with pkgs; [
    gdb                # GNU Debugger
    valgrind           # Memory leak detector
    clang-tools        # Includes clang-format and clang-tidy
    cppcheck           # Static analysis tool
  ];

  # Environment variables configuration
  shellHook = ''
    echo "Compiler: $(gcc --version | head -n 1)"
    echo "CMake:    $(cmake --version | head -n 1)"
    
    export CXXFLAGS="-Wall -Wextra -std=c++26"
  '';
}

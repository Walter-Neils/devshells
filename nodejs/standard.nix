{pkgs}:
pkgs.mkShell {
    buildInputs = with pkgs; [
        nodejs
    ];

    shellHook = ''
    echo "nodejs: $(node --version)"
    echo "npm:    $(npm --version)"
    '';
}

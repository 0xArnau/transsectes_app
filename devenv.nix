{ pkgs, ... }:
{
  # Android SDK + Flutter
  android = {
    enable = true;

    # Flutter 3.38.3 uses compileSdk 35
    platforms.version = [ "35" ];
    buildTools.version = [ "35.0.0" ];
    cmdLineTools.version = "13.0";
    tools.version = "26.1.1";

    # ABIs needed for device + emulator
    abis = [ "arm64-v8a" "x86_64" ];

    # NDK version required by Flutter 3.38.3
    ndk = {
      enable = true;
      version = [ "27.0.12077973" ];
    };

    flutter.enable = true;
  };

  # Java 17 (matches build.gradle compileOptions)
  languages.java = {
    enable = true;
    jdk.package = pkgs.jdk17;
  };

  # Kotlin (matches settings.gradle org.jetbrains.kotlin.android)
  languages.kotlin.enable = true;

  enterShell = ''
    echo "=== Development Environment ==="
    echo "Dart version: $(dart --version 2>&1 | head -n1)"
    echo "Flutter version: $(flutter --version | head -n1)"
    echo "Java version: $(java --version | head -n1)"
    echo "Kotlin version: $(kotlinc -version 2>&1 | head -n1)"
    echo "Git version: $(git --version)"
    echo "==============================="
  '';
}

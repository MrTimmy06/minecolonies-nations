# Build the NationCraft fork of MineColonies.
# Run from this folder:  .\nations-build.ps1
# Result: build\libs\minecolonies-<version>.jar  (version is set in gradle.properties: modVersion + modVersionSuffix)
#
# Needs a JDK 21 (not a JRE). Where it is taken from, in this order:
#   1. $env:NATIONS_JDK                          (set it on another PC: $env:NATIONS_JDK = 'D:\jdk-21...')
#   2. C:\Users\tursu\Tools\jdk-21.0.13.1+2      (the main PC)
# Gradle is forbidden to download its own JDK. Extra arguments go to Gradle, e.g. .\nations-build.ps1 --info
# On Linux/macOS: JAVA_HOME=/path/to/jdk-21 ./gradlew assemble -Porg.gradle.java.installations.auto-download=false
#
# No $ErrorActionPreference = 'Stop' here: in Windows PowerShell 5.1 every stderr line of a native
# program (Gradle prints warnings there) becomes an error record and would abort the build.

$jdk = $env:NATIONS_JDK
if (-not $jdk) { $jdk = 'C:\Users\tursu\Tools\jdk-21.0.13.1+2' }
if (-not (Test-Path (Join-Path $jdk 'bin\javac.exe'))) {
  Write-Host "JDK 21 not found at: $jdk"
  Write-Host "Download Temurin JDK 21 (zip) from adoptium.net, unpack it and set:  `$env:NATIONS_JDK = '<folder>'"
  exit 1
}
$env:JAVA_HOME = $jdk
& "$PSScriptRoot\gradlew.bat" assemble "-Porg.gradle.java.installations.auto-download=false" @args
exit $LASTEXITCODE

# Build the NationCraft fork of MineColonies.
# Run from this folder:  .\nations-build.ps1
# Result: build\libs\minecolonies-<version>.jar  (version is set in gradle.properties: modVersion + modVersionSuffix)
#
# Uses JDK 21 from C:\Users\tursu\Tools (the system Java on this PC is 17) and forbids Gradle
# from downloading its own JDK. Extra arguments are passed to Gradle, e.g. .\nations-build.ps1 --info

# No $ErrorActionPreference = 'Stop' here: in Windows PowerShell 5.1 every stderr line of a native
# program (Gradle prints warnings there) becomes an error record and would abort the build.
$env:JAVA_HOME = 'C:\Users\tursu\Tools\jdk-21.0.13.1+2'
& "$PSScriptRoot\gradlew.bat" assemble "-Porg.gradle.java.installations.auto-download=false" @args
exit $LASTEXITCODE

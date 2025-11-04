@ECHO OFF

IF NOT "" == "%JAVA_HOME%" (
  SET "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
) ELSE (
  SET "JAVA_EXE=java"
)

SET "WRAPPER_JAR=%~dp0gradle\wrapper\gradle-wrapper.jar"

IF NOT EXIST "%WRAPPER_JAR%" (
  powershell -NoLogo -NoProfile -Command ^
    "$props = Get-Content '%~dp0gradle\wrapper\gradle-wrapper.properties' | Where-Object { \$_ -match '^distributionUrl=' };" ^
    "if (-not $props) { Write-Error 'distributionUrl not found in gradle-wrapper.properties'; exit 1 }" ^
    "$url = $props.Split('=')[1];" ^
    "$version = [regex]::Match($url, 'gradle-([0-9.]+)').Groups[1].Value;" ^
    "if (-not $version) { Write-Error \"Unable to determine Gradle version from $url\"; exit 1 }" ^
    "$wrapperUrl = \"https://services.gradle.org/distributions/gradle-$version-wrapper.jar\";" ^
    "Invoke-WebRequest $wrapperUrl -OutFile '%WRAPPER_JAR%'"
  IF NOT EXIST "%WRAPPER_JAR%" (
    ECHO ERROR: Failed to download Gradle wrapper jar.
    EXIT /B 1
  )
)

IF EXIST "%JAVA_EXE%" (
  "%JAVA_EXE%" -classpath "%WRAPPER_JAR%" org.gradle.wrapper.GradleWrapperMain %*
) ELSE (
  ECHO ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
  EXIT /B 1
)

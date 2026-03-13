# Run InTimePro Flutter app without puro interference
$flutterRoot = "C:\Users\KalyansingChanda\.puro\envs\stable\flutter"
$cache = "$flutterRoot\bin\cache"
$shared = "C:\Users\KalyansingChanda\.puro\shared\caches\e4b8dca3f1b4ede4c30371002441c88c12187ed6"

# Ensure flutter_web_sdk is a real directory (not a symlink/junction)
$webSdk = "$cache\flutter_web_sdk"
if ((Get-Item $webSdk -ErrorAction SilentlyContinue).LinkType) {
    Write-Host "Fixing flutter_web_sdk symlink..."
    cmd /c "rmdir `"$webSdk`""
    New-Item -ItemType Directory $webSdk | Out-Null
    Copy-Item -Path "$shared\flutter_web_sdk\*" -Destination $webSdk -Recurse -Force
    Write-Host "Fixed."
}

$dartExe = "$cache\dart-sdk\bin\dart.exe"
$flutterScript = "$flutterRoot\packages\flutter_tools\bin\flutter_tools.dart"
$pkgConfig = "$flutterRoot\packages\flutter_tools\.dart_tool\package_config.json"
$env:FLUTTER_ROOT = $flutterRoot

Set-Location "C:\Users\KalyansingChanda\Documents\intimeproapp"

$device = if ($args.Count -gt 0) { $args[0] } else { "chrome" }
Write-Host "Running on: $device"
& $dartExe run --packages=$pkgConfig $flutterScript run -d $device

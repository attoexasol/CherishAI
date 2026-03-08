# Script to fix missing namespace in Flutter plugin build.gradle files
# Required for Android Gradle Plugin 8.0+

$pubCache = "$env:LOCALAPPDATA\Pub\Cache\hosted\pub.dev"
$fixedCount = 0
$skippedCount = 0

Write-Host "Scanning Flutter plugins for missing namespaces..." -ForegroundColor Cyan

Get-ChildItem -Path $pubCache -Directory | ForEach-Object {
    $pluginDir = $_.FullName
    $buildGradle = Join-Path $pluginDir "android\build.gradle"
    $manifest = Join-Path $pluginDir "android\src\main\AndroidManifest.xml"
    
    if (Test-Path $buildGradle -PathType Leaf) {
        $content = Get-Content $buildGradle -Raw
        
        # Check if namespace is already present
        if ($content -notmatch "namespace\s*=") {
            # Try to get package name from AndroidManifest.xml
            $packageName = $null
            if (Test-Path $manifest -PathType Leaf) {
                $manifestContent = Get-Content $manifest -Raw
                if ($manifestContent -match 'package="([^"]+)"') {
                    $packageName = $matches[1]
                }
            }
            
            if ($packageName) {
                # Add namespace to build.gradle
                $newContent = $content -replace '(android\s*\{)', "`$1`n    namespace = '$packageName'"
                Set-Content -Path $buildGradle -Value $newContent -NoNewline
                Write-Host "Fixed: $($_.Name)" -ForegroundColor Green
                $fixedCount++
            } else {
                Write-Host "Skipped: $($_.Name) (no package found in manifest)" -ForegroundColor Yellow
                $skippedCount++
            }
        } else {
            $skippedCount++
        }
    }
}

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Fixed: $fixedCount plugins" -ForegroundColor Green
Write-Host "  Skipped: $skippedCount plugins (already have namespace or no manifest)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Done! You can now run 'flutter run' again." -ForegroundColor Green

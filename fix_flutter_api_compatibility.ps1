# Script to fix Flutter API compatibility issues for Flutter 2.10.5
# Fixes MediaQuery.paddingOf/sizeOf and Color.withValues

$files = Get-ChildItem -Path lib -Filter *.dart -Recurse
$fixedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Fix MediaQuery.paddingOf(context) -> MediaQuery.of(context).padding
    $content = $content -replace 'MediaQuery\.paddingOf\(([^)]+)\)', 'MediaQuery.of($1).padding'
    
    # Fix MediaQuery.sizeOf(context) -> MediaQuery.of(context).size
    $content = $content -replace 'MediaQuery\.sizeOf\(([^)]+)\)', 'MediaQuery.of($1).size'
    
    # Fix Color.withValues(alpha: x) -> Color.withOpacity(x / 255.0)
    # But first, let's use a simpler approach: withAlpha
    $content = $content -replace '\.withValues\(alpha:\s*([^)]+)\)', '.withAlpha((($1 * 255).toInt()))'
    
    # Fix WidgetsBinding.instance.addPostFrameCallback -> WidgetsBinding.instance?.addPostFrameCallback
    $content = $content -replace 'WidgetsBinding\.instance\.addPostFrameCallback', 'WidgetsBinding.instance?.addPostFrameCallback'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
        $fixedCount++
    }
}

Write-Host ""
Write-Host "Fixed $fixedCount files" -ForegroundColor Cyan

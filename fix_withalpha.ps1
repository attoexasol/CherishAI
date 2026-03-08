# Fix withAlpha(((x * 255).toInt())) to withOpacity(x)

$files = Get-ChildItem -Path lib -Filter *.dart -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Fix .withAlpha(((x * 255).toInt())) -> .withOpacity(x)
    $content = $content -replace '\.withAlpha\(\(\(\(([0-9.]+)\s*\*\s*255\)\.toInt\(\)\)\)\)', '.withOpacity($1)'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "Done fixing withAlpha calls" -ForegroundColor Cyan

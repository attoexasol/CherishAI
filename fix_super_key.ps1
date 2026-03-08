# Script to fix super.key syntax to be compatible with Dart 2.16
# Replaces {super.key} with {Key? key}) : super(key: key)

$files = Get-ChildItem -Path lib -Filter *.dart -Recurse

$fixedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Fix: const ClassName({super.key});
    $content = $content -replace 'const\s+(\w+)\s*\(\s*\{\s*super\.key\s*\}\s*\);', 'const $1({Key? key}) : super(key: key);'
    
    # Fix: ClassName({super.key});
    $content = $content -replace '(\w+)\s*\(\s*\{\s*super\.key\s*\}\s*\);', '$1({Key? key}) : super(key: key);'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Fixed: $($file.FullName)" -ForegroundColor Green
        $fixedCount++
    }
}

Write-Host ""
Write-Host "Fixed $fixedCount files" -ForegroundColor Cyan
Write-Host "Note: You may need to add 'import ''package:flutter/material.dart'';' if Key is not imported" -ForegroundColor Yellow

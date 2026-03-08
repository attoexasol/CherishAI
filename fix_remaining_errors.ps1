# Fix remaining Flutter 2.10.5 compatibility issues

# Fix 1: Remove withNoTextScaling (not available in Flutter 2.10.5)
$files = @(
    "lib\presentation\edit_loved_one\views\edit_loved_one_screen.dart",
    "lib\presentation\events\views\all_upcoming_events_screen.dart"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($content) {
            $originalContent = $content
            # Remove MediaQuery.withNoTextScaling wrapper, keep child
            $content = $content -replace 'MediaQuery\.withNoTextScaling\(\s*\n\s*child:\s*', ''
            $content = $content -replace 'MediaQuery\.withNoTextScaling\(', ''
            # Remove closing parenthesis for withNoTextScaling
            $content = $content -replace '\)\s*\)\s*;', ');'
            $content = $content -replace '\)\s*\)\s*,', '),'
            $content = $content -replace '\)\s*\)\s*\)', '))'
            
            if ($content -ne $originalContent) {
                Set-Content -Path $file -Value $content -NoNewline
                Write-Host "Fixed: $file" -ForegroundColor Green
            }
        }
    }
}

# Fix 2: Remove foregroundColor parameter (not available in Flutter 2.10.5)
$files2 = @(
    "lib\presentation\old_messages\views\old_messages_screen.dart"
)

foreach ($file in $files2) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $originalContent = $content
        # Remove foregroundColor parameter
        $content = $content -replace ',\s*foregroundColor:\s*[^,)]+', ''
        $content = $content -replace 'foregroundColor:\s*[^,)]+\s*,', ''
        
        if ($content -ne $originalContent) {
            Set-Content -Path $file -Value $content -NoNewline
            Write-Host "Fixed: $file" -ForegroundColor Green
        }
    }
}

# Fix 3: Remove fill parameter (not available in Flutter 2.10.5)
$files3 = @(
    "lib\presentation\splash\views\splash_screen.dart",
    "lib\presentation\onboarding\views\onboarding_intro_screen.dart"
)

foreach ($file in $files3) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $originalContent = $content
        # Remove fill parameter
        $content = $content -replace ',\s*fill:\s*[^,)]+', ''
        $content = $content -replace 'fill:\s*[^,)]+\s*,', ''
        
        if ($content -ne $originalContent) {
            Set-Content -Path $file -Value $content -NoNewline
            Write-Host "Fixed: $file" -ForegroundColor Green
        }
    }
}

Write-Host "Done fixing remaining errors" -ForegroundColor Cyan

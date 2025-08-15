$outputFile = "Index.md"

Remove-Item $outputFile -ErrorAction Ignore

# Include ReadMe.md from current directory if it exists
if (Test-Path ".\ReadMe.md") {
    Add-Content $outputFile "## Root"
    Add-Content $outputFile ""
    Add-Content $outputFile ("[ReadMe.md]({0})" -f ("ReadMe.md"))
    Add-Content $outputFile ""  # Blank line
}

foreach ($dir in "inventory", "blueprints") {
    Add-Content $outputFile "## $dir"
    Add-Content $outputFile ""

    Get-ChildItem -Path ".\$dir" -Recurse -File |
        Sort-Object Name |
        ForEach-Object {
            Add-Content $outputFile ("[{0}]({1})" -f $_.Name,
                ($_.FullName.Substring((Get-Location).Path.Length + 1) -replace "\\","/")
            )
            Add-Content $outputFile ""  # Blank line between rows
        }
}

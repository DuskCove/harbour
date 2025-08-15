$baseUrl = ""
$outputFile = "links.md"

Remove-Item $outputFile -ErrorAction Ignore

foreach ($dir in "inventory", "blueprints") {
    Add-Content $outputFile "## $dir"
    Add-Content $outputFile ""

    Get-ChildItem -Path ".\$dir" -Recurse -File |
        Sort-Object Name |
        ForEach-Object {
            Add-Content $outputFile ("[{0}]({1}{2})" -f $_.Name,
                $baseUrl,
                ($_.FullName.Substring((Get-Location).Path.Length + 1) -replace "\\","/")
            )
            Add-Content $outputFile ""  # Blank line between rows
        }
}
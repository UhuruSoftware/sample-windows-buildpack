$port = $env:PORT
$path = $env:HOMEPATH

Write-Host "Starting a web server on port $port ..."

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:$port/")

$listener.Start()

Write-Host 'Listening ...'
while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $currentTime = date
    
    $filename = [System.IO.Path]::GetFileName($request.RawUrl)

    Write-Host "[${currentTime}] /${filename}"

    if ($filename -eq '') { $filename = 'index.html' }

    $filename = Join-Path $path $filename

    if ((Test-Path $filename) -ne $true)
    {
        $response.StatusCode = [System.Net.HttpStatusCode]::NotFound
        $msg = [System.Text.ASCIIEncoding]::ASCII.GetBytes('<h1>Not Found</h1>')
    }
    else
    {
        $msg = Get-Content $filename -Encoding byte
    }

    $response.ContentLength64 = $msg.Length

    try
    {
        $stream = $response.OutputStream
        $stream.Write($msg, 0, $msg.Length)
    } 
    finally 
    {
        $stream.Dispose()
    }
}

Write-Host 'There must have been an error and the listener stopped listening.'
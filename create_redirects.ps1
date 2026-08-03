$data = @'
turco,https://forseniors.shop/tr/pages/biblia-turco
tcheco,https://forseniors.shop/cs/pages/biblia-tcheco
romeno,https://forseniors.shop/ro/pages/biblia-romeno
estoniano,https://forseniors.shop/et/pages/biblia-estoniano
espanhol,https://forseniors.shop/es/pages/biblia-espanhol
esloveno,https://forseniors.shop/sl/pages/biblia-esloveno
eslovaco,https://forseniors.shop/sk/pages/biblia-eslovaco
polones,https://forseniors.shop/pl/pages/biblia-polones
noruegues,https://forseniors.shop/no/pages/biblia-noruegues
hungaro,https://forseniors.shop/hu/pages/biblia-hungaro
holandes,https://forseniors.shop/nl/pages/biblia-holandes
finlandes,https://forseniors.shop/fi/pages/biblia-finlandes
croata,https://forseniors.shop/hr/pages/biblia-croata
bulgaro,https://forseniors.shop/bg/pages/biblia-bulgaro
grego,https://forseniors.shop/el/pages/biblia-grego
'@

$data -split "`n" | ForEach-Object {
    if ([string]::IsNullOrWhiteSpace($_)) { return }
    $parts = $_.Trim().Split(',')
    $lang = $parts[0]
    $url = $parts[1]
    $dir = Join-Path (Get-Location) $lang
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    
    $html = @"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Redirecionando...</title>
    <script>
        var dest = "$url";
        window.location.replace(dest + window.location.search);
    </script>
</head>
<body>
    Se você não for redirecionado automaticamente, <a href="$url" id="fallback-link">clique aqui</a>.
    <script>
        document.getElementById('fallback-link').href = dest + window.location.search;
    </script>
</body>
</html>
"@
    [System.IO.File]::WriteAllText((Join-Path $dir "index.html"), $html, [System.Text.Encoding]::UTF8)
}

git add .
git commit -m "Adiciona novos idiomas para redirecionamento"
git push

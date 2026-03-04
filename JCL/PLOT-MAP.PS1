# PLOT-MAP.PS1 - Generador de Mapa Galáctico para Proyecto VIA
$reportPath = "REPORTS/DM-CANDIDATES.TXT"
$outputPath = "REPORTS/GALAXY-MAP.svg"

# Leer solo las líneas de datos (saltando encabezados)
$data = Get-Content $reportPath | Where-Object { $_ -match "^\s+\d" }

$svgHeader = @"
<svg width="800" height="400" viewBox="0 0 800 400" xmlns="http://www.w3.org/2000/svg" style="background-color: #050510;">
  <line x1="0" y1="200" x2="800" y2="200" stroke="#444" stroke-dasharray="5,5" />
  <text x="10" y="190" fill="#666" font-family="Arial" font-size="12">Plano Galáctico (B=0)</text>
  <text x="400" y="20" fill="white" font-family="Arial" font-size="16" text-anchor="middle">MAPA DE CANDIDATOS - PROYECTO VIA (COBOL)</text>
"@

$svgContent = ""
foreach ($line in $data) {
    # Extraer Energía, L y B usando posiciones fijas o split
    $parts = $line.Trim() -split "\s+"
    if ($parts.Count -ge 3) {
        $energy = [double]$parts[0]
        $l = [double]$parts[1]
        $b = [double]$parts[2]

        # Mapeo de coordenadas a píxeles (Longitud 0-360 -> 0-800, Latitud -90 a 90 -> 400-0)
        $x = ($l / 360) * 800
        $y = 200 - ($b * 2) # Escala para que se vea mejor el eje vertical

        # Dibujar el punto (el tamaño depende de la energía)
        $size = [math]::Max(3, ($energy / 200))
        $svgContent += "  <circle cx='$x' cy='$y' r='$size' fill='red' opacity='0.8'>`n"
        $svgContent += "    <title>Energía: $energy GeV | L: $l B: $b</title>`n"
        $svgContent += "  </circle>`n"
        $svgContent += "  <text x='$($x+10)' y='$y' fill='yellow' font-family='Arial' font-size='10'>$energy GeV</text>`n"
    }
}

$svgFooter = "</svg>"
$svgHeader + $svgContent + $svgFooter | Out-File -FilePath $outputPath -Encoding utf8
Write-Host "--- MAPA GENERADO EXITOSAMENTE EN $outputPath ---" -ForegroundColor Cyan
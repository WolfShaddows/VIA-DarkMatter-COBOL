# PLOT-MAP.PS1 - Generador de Mapa Galáctico Profesional (Proyecto VIA)
$reportPath = "REPORTS/DM-CANDIDATES.TXT"
$outputPath = "REPORTS/GALAXY-MAP.svg"

if (-not (Test-Path $reportPath)) { 
    Write-Host "ERROR: No se encuentra el reporte de candidatos." -ForegroundColor Red; exit 
}

$data = Get-Content $reportPath | Where-Object { $_ -match "^\s+\d" }

$svgHeader = @"
<svg width="800" height="400" viewBox="0 0 800 400" xmlns="http://www.w3.org/2000/svg" style="background-color: #020205;">
  <line x1="0" y1="200" x2="800" y2="200" stroke="#222" stroke-width="1" />
  <line x1="400" y1="0" x2="400" y2="400" stroke="#222" stroke-width="1" />
  
  <text x="10" y="215" fill="#444" font-family="Consolas" font-size="10">Ecuador Galáctico (b=0)</text>
  <text x="405" y="390" fill="#444" font-family="Consolas" font-size="10">Meridiano Central (l=0)</text>
  
  <text x="400" y="30" fill="#00AAFF" font-family="Consolas" font-size="18" text-anchor="middle" font-weight="bold">V.I.A. - GAMMA-RAY CANDIDATE MAP</text>
  <text x="400" y="50" fill="#666" font-family="Consolas" font-size="10" text-anchor="middle">PROCESSED BY GnuCOBOL ENGINE (HAVERSINE VERIFIED)</text>
"@

$svgContent = ""
foreach ($line in $data) {
    $parts = $line.Trim() -split "\s+"
    if ($parts.Count -ge 3) {
        $energy = [double]$parts[0]
        $l = [double]$parts[1]
        $b = [double]$parts[2]

        # Ajuste para centrar L=0 en el medio (400px)
        # Si L > 180, lo restamos para que mapee correctamente
        $l_adj = if ($l -gt 180) { $l - 360 } else { $l }
        $x = 400 - ($l_adj * (800 / 360))
        $y = 200 - ($b * (400 / 180))

        # Color basado en energía (Más azul/blanco = más energético)
        $color = if ($energy -gt 800) { "#FFFFFF" } else { "#FF3300" }
        $size = [math]::Log10($energy) * 2

        $svgContent += "  <circle cx='$x' cy='$y' r='$size' fill='$color' opacity='0.9' stroke='yellow' stroke-width='0.5'>`n"
        $svgContent += "    <title>Source: $energy GeV | l:$l b:$b</title>`n"
        $svgContent += "  </circle>`n"
        $svgContent += "  <text x='$($x + 5)' y='$($y - 5)' fill='white' font-family='Consolas' font-size='9'>$energy GeV</text>`n"
    }
}

$svgFooter = @"
  <rect x="620" y="310" width="160" height="75" fill="rgba(10,10,30,0.8)" stroke="#00AAFF" stroke-width="0.5" />
  <text x="630" y="325" fill="#00AAFF" font-family="Consolas" font-size="10" font-weight="bold">ESCALA DE ENERGÍA</text>
  
  <circle cx="635" cy="340" r="2" fill="#FF3300" />
  <text x="650" y="343" fill="#AAA" font-family="Consolas" font-size="9">&lt; 500 GeV (Base)</text>
  
  <circle cx="635" cy="355" r="4" fill="#FF3300" stroke="yellow" stroke-width="0.5" />
  <text x="650" y="358" fill="#AAA" font-family="Consolas" font-size="9">500 - 800 GeV</text>
  
  <circle cx="635" cy="370" r="6" fill="#FFFFFF" stroke="yellow" stroke-width="0.5" />
  <text x="650" y="373" fill="#FFF" font-family="Consolas" font-size="9">&gt; 800 GeV (Crítico)</text>

  <text x="10" y="375" fill="#00AAFF" font-family="Consolas" font-size="10" font-weight="bold">Wolfshadows-dev</text>
  <text x="10" y="388" fill="#666" font-family="Consolas" font-size="9">IBM Z Advocate | Open Mainframe Project Contributor</text>
</svg>
"@

$svgHeader + $svgContent + $svgFooter | Out-File -FilePath $outputPath -Encoding utf8
Write-Host "--- MAPA GENERADO: $outputPath ---" -ForegroundColor Green
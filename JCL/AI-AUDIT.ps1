# AI-AUDIT-V3.ps1 - Auditoría de Precisión con IBM Granite
$reportFile = "REPORTS/DM-CANDIDATES.TXT"
$model = "granite-code:8b"

if (-not (Test-Path $reportFile)) { 
    Write-Host "ERROR: Reporte no encontrado." -ForegroundColor Red; exit 
}

# Extraemos solo las líneas con datos reales
$data = Get-Content $reportFile | Where-Object { $_ -match "\d" -and $_ -notmatch "ENERGY" }

Write-Host "`n--- INICIANDO AUDITORÍA DE PRECISIÓN (IBM GRANITE) ---" -ForegroundColor Cyan

foreach ($line in $data) {
    # Limpieza y split de columnas (asumiendo formato: Energia L B Status)
    $cols = $line.Trim() -split '\s+'
    if ($cols.Count -lt 3) { continue }

    $ene = $cols[0]
    $lon = $cols[1]
    $lat = $cols[2]

    $prompt = @"
Sos un Astrofísico Senior de IBM Research. Analizá técnicamente este evento detectado:
- ENERGÍA: $ene GeV
- LONGITUD GALÁCTICA (L): $lon
- LATITUD GALÁCTICA (B): $lat

CRITERIOS DE EVALUACIÓN:
1. Si |B| > 15, la señal está limpia de ruido del disco galáctico.
2. Energías > 500 GeV son anomalías de alta prioridad para Materia Oscura.
3. El centro galáctico está cerca de L=0, B=0.

Proporcioná:
A) Análisis de probabilidad de Materia Oscura.
B) Nivel de Confianza Científica (1-100%).
C) Conclusión técnica en 2 líneas.
"@

    Write-Host "`n[AUDITANDO FOTÓN]: $ene GeV..." -ForegroundColor Yellow
    $analysis = ollama run $model $prompt
    
    Write-Host ">> VERDICTO DE GRANITE:" -ForegroundColor Green
    Write-Host $analysis
    Write-Host "----------------------------------------------------"
}
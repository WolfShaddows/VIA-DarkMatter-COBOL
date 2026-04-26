# JCL/TRIPLE-ENGINE-AUDIT.ps1
Write-Host "--- INICIANDO TRIPLE MOTOR V.I.A. (COBOL + QISKIT + GRANITE) ---" -ForegroundColor Cyan

# 1. EJECUCIÓN CUÁNTICA
Write-Host "[STEP 1] Ejecutando Validación Cuántica en Qiskit Aer..." -ForegroundColor Yellow
$qResults = python JCL/QUANTUM-CORE.py

# 2. AUDITORÍA COGNITIVA CON GRANITE
foreach ($res in $qResults) {
    if ($res -match "EVENT:(?<ene>.*)\|Q-PROB:(?<prob>.*)%") {
        $ene = $Matches['ene']
        $prob = $Matches['prob']

        $prompt = @"
Sos un sistema de auditoría de IBM Z. Analizá este evento astrofísico con datos híbridos:
- DATOS COBOL (Energía): $ene GeV
- VALIDACIÓN CUÁNTICA (Qiskit): $prob% de probabilidad de anomalía.

Analizá la correlación: Si la probabilidad cuántica es > 90%, es un evento de Materia Oscura de alta fidelidad. 
Da un veredicto técnico final y un nivel de confianza.
"@

        Write-Host "`n[AUDITANDO]: Fotón $ene GeV con $prob% Quantum Probability" -ForegroundColor Green
        ollama run granite-code:8b $prompt
        Write-Host "----------------------------------------------------"
    }
}
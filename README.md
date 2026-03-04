# PROYECTO VIA - Análisis de Rayos Gamma y Materia Oscura
Sistema de procesamiento de datos astronómicos de alta energía (GeV) desarrollado en **GnuCOBOL**.

## 1. Descripción
Este sistema procesa eventos de fotones provenientes del Fermi-LAT (Gamma-ray Space Telescope). Realiza la conversión de datos masivos en CSV a un formato binario indexado para identificar anomalías energéticas que no coincidan con el catálogo de fuentes conocidas (4FGL).

## 2. Estructura del Proyecto
* `SRC/`: Código fuente COBOL (.CBL).
* `COPY/`: Copybooks con las estructuras de registro (.CPY).
* `DATA_RAW/`: Datos originales en CSV (Eventos y Catálogo).
* `DATA_PROC/`: Archivos binarios empaquetados y archivos indexados (.DAT, .IDX).
* `REPORTS/`: Resultados del análisis y mapas de candidatos.
* `JCL/`: Scripts de soporte en PowerShell.

## 3. Pipeline de Ejecución
Para procesar la muestra completa, ejecutar en orden:

1.  **PRE-PROC.exe**: Convierte el CSV de eventos a binario `COMP-3`.
2.  **CAT-PROC.exe**: Indexa el catálogo 4FGL para búsquedas rápidas.
3.  **SEARCH-MATCH.exe**: Cruza eventos vs. catálogo usando distancia euclidiana.
4.  **GEN-REPORT.exe**: Genera el listado final de candidatos a Materia Oscura (DM).
5.  **PLOT-MAP.ps1**: Genera la visualización galáctica en formato SVG.

## 4. Hallazgos Significativos
El sistema identificó con éxito anomalías de alta energía, destacando:
* **Evento Maestro**: 972.00 GeV en coordenadas galácticas (343.59, 19.90).
* **Estado**: Sin asociación conocida en el catálogo 4FGL.

## 5. Compilación General
Para reconstruir los ejecutables desde el código fuente:
```powershell
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/PRE-PROC.CBL -o PRE-PROC.exe
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/CAT-PROC.CBL -o CAT-PROC.exe
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/SEARCH-MATCH.CBL -o SEARCH-MATCH.exe
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/GEN-REPORT.CBL -o GEN-REPORT.exe
---
*Desarrollado en 2026 by Wolfshadows-dev para el análisis de física de partículas.*
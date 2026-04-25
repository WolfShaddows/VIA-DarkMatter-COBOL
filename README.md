# V.I.A. - Visual Integration & Astrophysics Pipeline (GnuCOBOL Edition)

**Project Lead:** Wolfshadows-dev  
**Role:** IBM Z Advocate / Researcher  
**Status:** Haversine Precision Verified (v2.0)

---

## 1. Descripción
El proyecto **V.I.A.** es un sistema de procesamiento de datos astronómicos de alta energía diseñado para identificar candidatos a **materia oscura (DM)** mediante el análisis de fotones del telescopio **Fermi-LAT**.  
El núcleo está desarrollado íntegramente en **GnuCOBOL**, optimizado para el procesamiento local de grandes volúmenes de datos bajo estándares de **Sovereign Tech**.

---

## 2. Arquitectura Técnica e Innovación
- **Cálculo Esférico:** Implementación de la **Fórmula del Semiverseno (Haversine)** para distancias angulares en coordenadas galácticas.  
- **Funciones Intrínsecas COBOL:** Uso de `SIN`, `COS`, `ASIN`, `SQRT` para trigonometría esférica.  
- **Eficiencia de Datos:** Formatos binarios empaquetados (`COMP-3`) para optimizar ciclos de CPU en mainframe.  
- **Indexación Dinámica:** Archivos indexados para búsquedas de alta performance.  

---

## 3. Pipeline de Ejecución
1. **PRE-PROC** → Ingesta y conversión de CSV a binario.  
2. **CAT-PROC** → Indexación del catálogo 4FGL.  
3. **SEARCH-MATCH** → Motor de cruce esférico con validación Haversine.  
4. **GEN-REPORT** → Generación de reportes técnicos (`DM-CANDIDATES.TXT`).  
5. **PLOT-MAP** → Visualización SVG centrada en `L=0`.  

---

## 4. Registro de Testeos y Resultados

### Test 1
- **Umbral Energía:** 500 GeV  
- **Radio de Búsqueda (θ):** 0.10°  
- **Hallazgos:** 5 candidatos detectados  

### Test 2
- **Umbral Energía:** 400 GeV  
- **Radio de Búsqueda (θ):** 0.08°  
- **Hallazgos:** Resultados consistentes (5 candidatos)  

---

## 5. Candidatos Identificados (Verified)
- **Evento Maestro:** 972.00 GeV | L: +343.59, B: +19.90  
- **Evento Secundario:** 749.24 GeV | L: +264.35, B: -05.39  
- **Evento de Halo:** 535.20 GeV | L: +031.41, B: -46.01  

---

## 6. Compilación
Para reconstruir los ejecutables desde el código fuente:

```powershell
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/PRE-PROC.CBL -o PRE-PROC.exe
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/CAT-PROC.CBL -o CAT-PROC.exe
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/SEARCH-MATCH.CBL -o SEARCH-MATCH.exe
cobc -x -free -conf="$env:COB_CONFIG_DIR\default.conf" -I "./COPY" SRC/GEN-REPORT.CBL -o GEN-REPORT.exe

*Desarrollado en 2026 por Wolfshadows-dev para el análisis de física de partículas e integración en el ecosistema Open Mainframe.*
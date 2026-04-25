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
```

# 7. Auditoría Cognitiva y Conclusiones de IA (IBM Granite)

En esta fase se integró **IBM Granite-Code-8b** para realizar una auditoría de *segunda opinión* sobre los candidatos detectados por el motor determinista en COBOL.  
El objetivo fue evaluar la viabilidad de los eventos como firmas de **Materia Oscura** frente a ruidos astrofísicos conocidos.

---

## 7.1. Veredicto del Modelo
El análisis de IA arrojó resultados mixtos que subrayan la importancia del juicio humano en la investigación científica:

- **Detección Crítica:** La IA identificó correctamente al **Evento de 972.00 GeV** como anomalía de alta prioridad, validando la necesidad de la precisión matemática de COBOL frente a las dificultades lógicas de la IA con magnitudes.  
- **Evaluación de Probabilidad:** El candidato de **749.24 GeV** recibió un nivel de confianza del **90%** por su proximidad al centro galáctico, sugiriendo una zona de alto interés.  
- **Alucinaciones Técnicas:** Se observaron interpretaciones creativas (ej. *“Láser de Hawking”*), reforzando nuestra postura de que la IA actúa como **generador de hipótesis** y no como juez final.  

---

## 7.2. Implementación y Ejecución Local
Para mantener la **Soberanía Tecnológica**, se recomienda el uso de **IBM Granite** ejecutado localmente mediante **Ollama**, garantizando que los datos de investigación no abandonen el entorno del mainframe/estación de trabajo.

### Requisito de Modelo
Instalar específicamente la versión utilizada en este estudio por su equilibrio entre razonamiento lógico y eficiencia:

```powershell
ollama pull granite-code:8b
```

## Orden de Ejecución de la Auditoría

Una vez generado el reporte por el motor COBOL, ejecutar el *puente cognitivo* mediante PowerShell:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\JCL\AI-AUDIT.ps1
```

## Agradecimientos

- A **IBM Z** y la comunidad **IBM Z Advocates** por proveer el ecosistema de innovación para el *Open Mainframe Project*.  
- A la iniciativa de **Sovereign Tech** por impulsar el desarrollo de herramientas locales y privadas.
- A **Fermi-LAT** (NASA/DOE) por el acceso público a los datos de la misión espacial, permitiendo la investigación independiente de alta energía.  
 
---


© 2026 **Wolfshadows-dev**   

Este software se distribuye *“tal cual”*, diseñado para la investigación independiente en astrofísica y la promoción de lenguajes de alto rendimiento en entornos modernos de IA.

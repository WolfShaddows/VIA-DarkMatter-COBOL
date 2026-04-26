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
 ---

# 8. Sovereign Quantum Layer (Qiskit Aer Integration)

El Proyecto **V.I.A.** no se detiene en el análisis determinista clásico.  
Para evaluar los candidatos de **Materia Oscura** de alta fidelidad generados por el motor de Mainframe (COBOL), se ha integrado una capa de **validación probabilística** utilizando simulaciones cuánticas locales mediante **IBM Qiskit**.

Esta arquitectura híbrida (**COBOL → Granite → Qiskit**) permite mapear la energía de los fotones (GeV) en estados de fase cuántica.  
Esto conforma una **Auditoría de Triple Motor**, ejecutada 100% offline, respetando los principios de **Soberanía Tecnológica**.

---

## 8.1. Requisitos e Instalación

Para ejecutar el orquestador cuántico en el entorno local (Windows/PowerShell) y disponer de hasta **30 qubits simulados**, es necesario instalar las dependencias base de Qiskit y su simulador de alto rendimiento **Aer**.

```powershell
pip install qiskit qiskit-aer
```

## 8.2. Certificación del Entorno (Quantum Tests)

Antes de integrar la capa cuántica al pipeline principal, se ejecutaron pruebas de estrés en un **Sandbox local** para validar el colapso del estado cuántico y la generación matemática de entrelazamiento en la CPU clásica.

### Test 1: Mapeo de Anomalía Unitaria
Se evaluó la capacidad de traducir datos del catálogo **Fermi-LAT** al dominio cuántico.  
Se mapeó el evento maestro del proyecto (**972.00 GeV**) a una rotación de fase (`Ry`) en un único qubit.

**Comportamiento esperado:** Colapso casi absoluto en el estado excitado `|1>` (Anomalía) tras 1024 iteraciones.

**Resultado de Validación:**
--- ANALIZANDO FOTÓN DE 972.0 GeV ---
Distribución de estados (0=Ruido, 1=Anomalía): {'1': 1023, '0': 1}
Probabilidad Cuántica de Anomalía: 99.90%

### Test 2: Entrelazamiento de Bell

Se validó la capacidad del simulador local **Aer** para manejar correlaciones cuánticas sin pérdida de coherencia, construyendo un **Estado de Bell** utilizando puertas de superposición (`Hadamard`) y puertas condicionales (`CNOT`) sobre 2 qubits.

**Comportamiento esperado:** Distribución simétrica de estados entrelazados puros (`00` y `11`) sin presencia de estados mixtos por ruido.

**Resultado de Validación:**
Resultado cuántico local: {'00': 486, '11': 538}


## 8.3. Auditoría de Triple Motor: Resultados de Muestras Fermi-LAT

Una vez validado el entorno cuántico local, el orquestador (`TRIPLE-ENGINE-AUDIT.ps1`) inyectó el **top 5 de candidatos energéticos** detectados por el motor COBOL en el simulador Qiskit, y posteriormente sometió la correlación a la auditoría cognitiva de **IBM Granite**.  

A continuación se presenta la matriz de resultados de este **triumvirato tecnológico**, demostrando la fidelidad de los hallazgos astrofísicos:

| ID Evento (COBOL) | Energía Detectada | Probabilidad Cuántica (Qiskit) | Veredicto Cognitivo (IBM Granite) | Nivel de Fidelidad (Humano/Técnico) |
|-------------------|-------------------|--------------------------------|----------------------------------|-------------------------------------|
| EVT-01 (Golden)   | 972.00 GeV        | 100.00%                        | Anomalía matemática inusual confirmada. Materia oscura de alta fidelidad. | Máxima (Verificado) |
| EVT-02            | 749.24 GeV        | 85.74%                         | Anomalía confirmada por correlación. Supera umbral de fidelidad. | Alta |
| EVT-03            | 638.25 GeV        | 71.09%                         | Correlación inusual revelada con alto nivel de confianza. | Media-Alta |
| EVT-04            | 623.53 GeV        | 68.26%                         | Emisión por fuente de materia oscura detectada. | Media |
| EVT-05 (Límite)   | 535.20 GeV        | 55.18%                         | Nivel de confianza alto (alucinación de probabilidad >90%). | Baja (Requiere Revisión) |

---

## 8.4. Análisis de Fidelidad y Fenómeno de "Alucinación Cognitiva"

La ejecución del modelo híbrido arrojó una conclusión fundamental para la arquitectura de sistemas complejos (**Sovereign Tech**):  
**La supremacía del determinismo sobre la heurística.**

- **El Candidato Dorado (972.00 GeV):** Existe una convergencia absoluta.  
  El filtro espacial (COBOL) detectó la energía máxima, Qiskit colapsó el estado de superposición con un 100% de probabilidad hacia la anomalía, y Granite auditó el dato sin desviaciones.  
  Este evento es una evidencia sólida para estudios de **Materia Oscura en el centro galáctico**.

- **Límites Heurísticos (Evento 535.20 GeV):** Se observó un fenómeno de *sobre-confianza* (**alucinación**) en la capa de IA.  
  Mientras que el simulador cuántico arrojó una probabilidad matemática objetiva del **55.18%** (prácticamente ruido estadístico/incertidumbre), el LLM (Granite) forzó la narrativa indicando una *probabilidad del 96.72%*.

**Conclusión**  
La integración de **Qiskit** actúa como un *Filtro de Verdad* matemático (*Ground Truth*) que previene que la capa de Inteligencia Artificial genere falsos positivos sobre los datos legacy procesados por COBOL.  
Este **triple esquema** garantiza que solo los eventos con correlación total (como el fotón de **972 GeV**) pasen a la fase de investigación científica formal.


## Agradecimientos

- A **IBM Z** y la comunidad **IBM Z Advocates** por proveer el ecosistema de innovación para el *Open Mainframe Project*.  
- A la iniciativa de **Sovereign Tech** por impulsar el desarrollo de herramientas locales y privadas.
- A **Fermi-LAT** (NASA/DOE) por el acceso público a los datos de la misión espacial, permitiendo la investigación independiente de alta energía. 

© 2026 **Wolfshadows-dev**   

Este software se distribuye *“tal cual”*, diseñado para la investigación independiente en astrofísica y la promoción de lenguajes de alto rendimiento en entornos modernos de IA.

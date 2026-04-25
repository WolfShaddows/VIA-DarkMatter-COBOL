IDENTIFICATION DIVISION.
       PROGRAM-ID. SEARCH-MATCH.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION ALL INTRINSIC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EVENT-FILE ASSIGN TO "DATA_PROC/EVENTS.DAT"
               ORGANIZATION IS SEQUENTIAL.
           SELECT CAT-FILE ASSIGN TO "DATA_PROC/CATALOG.IDX"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS SR-NAME.

       DATA DIVISION.
       FILE SECTION.
       FD  EVENT-FILE.
           COPY "PHOTON-REC.CPY".
       FD  CAT-FILE.
           COPY "SOURCE-REC.CPY".

       WORKING-STORAGE SECTION.
       01  WS-CATALOG-TABLE.
           05  WS-SOURCE-ENTRY OCCURS 10000 TIMES INDEXED BY IDX-CAT.
               10  T-NAME      PIC X(18).
               10  T-L         PIC S9(3)V9(9) COMP-3.
               10  T-B         PIC S9(3)V9(9) COMP-3.

       01  WS-CONSTANTS.
           05  WS-PI           PIC 9V9(18) VALUE 3.141592653589793238.
           05  WS-DEG-TO-RAD   PIC 9V9(18).

       01  WS-VARS.
           05  WS-CAT-SIZE     PIC 9(5) VALUE ZERO.
           05  WS-EOF          PIC X VALUE 'N'.
           05  WS-FOUND-NEAR   PIC X VALUE 'N'.
           
           *> Variables de cálculo Haversine
           05  WS-L1-RAD       PIC S9V9(18) COMP-3.
           05  WS-L2-RAD       PIC S9V9(18) COMP-3.
           05  WS-B1-RAD       PIC S9V9(18) COMP-3.
           05  WS-B2-RAD       PIC S9V9(18) COMP-3.
           05  WS-D-L          PIC S9V9(18) COMP-3.
           05  WS-D-B          PIC S9V9(18) COMP-3.
           05  WS-A            PIC 9V9(18)  COMP-3.
           05  WS-C            PIC 9V9(18)  COMP-3.
           05  WS-DIST-RAD     PIC 9V9(18)  COMP-3.
           
           *> AJUSTE: Umbral de 0.08 grados en radianes para mayor precisión
           05  WS-THRESHOLD    PIC 9V9(18) VALUE 0.001396263401595463.

       PROCEDURE DIVISION.
           COMPUTE WS-DEG-TO-RAD = WS-PI / 180.0
           
           OPEN INPUT EVENT-FILE CAT-FILE
           
           DISPLAY "--- CARGANDO CATALOGO EN MEMORIA ---"
           PERFORM 100-LOAD-CATALOG
           
           *> CAMBIO: Umbral reducido a 400 GeV para segunda corrida controlada
           DISPLAY "--- BUSCANDO EXCESOS (UMBRAL: 400 GeV) ---"
           PERFORM 200-PROCESS-EVENTS UNTIL WS-EOF = 'Y'
           
           CLOSE EVENT-FILE CAT-FILE
           DISPLAY "--- ANALISIS FINALIZADO ---"
           STOP RUN.

       100-LOAD-CATALOG.
           SET IDX-CAT TO 1
           PERFORM UNTIL WS-EOF = 'Y' OR IDX-CAT > 10000
               READ CAT-FILE NEXT AT END MOVE 'Y' TO WS-EOF
                   NOT AT END
                       MOVE SR-NAME TO T-NAME(IDX-CAT)
                       MOVE SR-L-DEG TO T-L(IDX-CAT)
                       MOVE SR-B-DEG TO T-B(IDX-CAT)
                       ADD 1 TO WS-CAT-SIZE
                       SET IDX-CAT UP BY 1
               END-READ
           END-PERFORM
           MOVE 'N' TO WS-EOF.

       200-PROCESS-EVENTS.
           READ EVENT-FILE AT END MOVE 'Y' TO WS-EOF
               NOT AT END
                   IF PH-ENERGY-GEV > 400.0
                       MOVE 'N' TO WS-FOUND-NEAR
                       PERFORM 300-CHECK-PROXIMITY
                       
                       IF WS-FOUND-NEAR = 'N'
                           DISPLAY " "
                           DISPLAY "ALERTA: FOTON SIN ASOCIACION"
                           DISPLAY "  ENERGIA: " PH-ENERGY-GEV " GeV"
                           DISPLAY "  POS: L=" PH-L-DEG " B=" PH-B-DEG
                           DISPLAY "  ESTADO: CANDIDATO MATERIA OSCURA (HAVERSINE VERIFIED)"
                       END-IF
                   END-IF
           END-READ.

       300-CHECK-PROXIMITY.
           PERFORM VARYING IDX-CAT FROM 1 BY 1 
           UNTIL IDX-CAT > WS-CAT-SIZE OR WS-FOUND-NEAR = 'Y'
               
               COMPUTE WS-L1-RAD = PH-L-DEG * WS-DEG-TO-RAD
               COMPUTE WS-B1-RAD = PH-B-DEG * WS-DEG-TO-RAD
               COMPUTE WS-L2-RAD = T-L(IDX-CAT) * WS-DEG-TO-RAD
               COMPUTE WS-B2-RAD = T-B(IDX-CAT) * WS-DEG-TO-RAD
               
               COMPUTE WS-D-L = WS-L2-RAD - WS-L1-RAD
               COMPUTE WS-D-B = WS-B2-RAD - WS-B1-RAD
               
               COMPUTE WS-A = (SIN(WS-D-B / 2.0) ** 2) + 
                               COS(WS-B1-RAD) * COS(WS-B2-RAD) * (SIN(WS-D-L / 2.0) ** 2)
               
               COMPUTE WS-C = 2.0 * ASIN(SQRT(WS-A))
               
               IF WS-C < WS-THRESHOLD
                   MOVE 'Y' TO WS-FOUND-NEAR
               END-IF
           END-PERFORM.
           

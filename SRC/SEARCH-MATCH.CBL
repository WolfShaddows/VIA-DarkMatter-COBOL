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
           05  WS-SOURCE-ENTRY OCCURS 10000 TIMES 
                               INDEXED BY IDX-CAT.
               10  T-NAME      PIC X(18).
               10  T-L         PIC S9(3)V9(9) COMP-3.
               10  T-B         PIC S9(3)V9(9) COMP-3.
       
       01  WS-VARS.
           05  WS-CAT-SIZE     PIC 9(5) VALUE ZERO.
           05  WS-EOF          PIC X VALUE 'N'.
           05  WS-DIFF-L       PIC S9(3)V9(9) USAGE COMP-3.
           05  WS-DIFF-B       PIC S9(3)V9(9) USAGE COMP-3.
           05  WS-DIST-SQ      PIC 9(3)V9(18) USAGE COMP-3.
           05  WS-RADIUS-SQ    PIC 9(1)V9(6) VALUE 0.010000. *> 0.1 grados radio
           05  WS-FOUND-NEAR   PIC X VALUE 'N'.

       PROCEDURE DIVISION.
           OPEN INPUT EVENT-FILE CAT-FILE
           
           DISPLAY "--- CARGANDO CATALOGO EN MEMORIA ---"
           PERFORM 100-LOAD-CATALOG
           
           DISPLAY "--- BUSCANDO EXCESOS (UMBRAL: 500 GeV) ---"
           PERFORM 200-PROCESS-EVENTS UNTIL WS-EOF = 'Y'
           
           CLOSE EVENT-FILE CAT-FILE
           DISPLAY "--- ANALISIS FINALIZADO ---"
           STOP RUN.

       100-LOAD-CATALOG.
           SET IDX-CAT TO 1
           PERFORM UNTIL WS-EOF = 'Y' OR IDX-CAT > 10000
               READ CAT-FILE NEXT
                   AT END MOVE 'Y' TO WS-EOF
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
           READ EVENT-FILE
               AT END MOVE 'Y' TO WS-EOF
               NOT AT END
                   IF PH-ENERGY-GEV > 500.0
                       MOVE 'N' TO WS-FOUND-NEAR
                       PERFORM 300-CHECK-PROXIMITY
                       
                       IF WS-FOUND-NEAR = 'N'
                           DISPLAY " "
                           DISPLAY "ALERTA: FOTON SIN ASOCIACION"
                           DISPLAY "  ENERGIA: " PH-ENERGY-GEV " GeV"
                           DISPLAY "  POS: L=" PH-L-DEG " B=" PH-B-DEG
                           DISPLAY "  ESTADO: CANDIDATO MATERIA OSCURA"
                       END-IF
                   END-IF
           END-READ.

       300-CHECK-PROXIMITY.
           PERFORM VARYING IDX-CAT FROM 1 BY 1 
           UNTIL IDX-CAT > WS-CAT-SIZE OR WS-FOUND-NEAR = 'Y'
               
               COMPUTE WS-DIFF-L = PH-L-DEG - T-L(IDX-CAT)
               COMPUTE WS-DIFF-B = PH-B-DEG - T-B(IDX-CAT)
               
               *> Pitagoras simple d^2 = L^2 + B^2
               COMPUTE WS-DIST-SQ = (WS-DIFF-L * WS-DIFF-L) + 
                                    (WS-DIFF-B * WS-DIFF-B)
               
               IF WS-DIST-SQ < WS-RADIUS-SQ
                   MOVE 'Y' TO WS-FOUND-NEAR
               END-IF
           END-PERFORM.
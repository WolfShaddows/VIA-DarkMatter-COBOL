       IDENTIFICATION DIVISION.
       PROGRAM-ID. AUDIT-REP.
       AUTHOR. NINE-BRO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BIN-FILE ASSIGN TO "DATA_PROC/EVENTS.DAT"
           ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  BIN-FILE.
           COPY "PHOTON-REC.CPY".

       WORKING-STORAGE SECTION.
       01  WS-TOTALS.
           05  WS-COUNT            PIC 9(9) VALUE ZERO.
           05  WS-TOTAL-ENERGY     PIC 9(12)V9(9) VALUE ZERO.
           05  WS-MAX-ENERGY       PIC 9(9)V9(9) VALUE ZERO.
       
       01  WS-FLAGS.
           05  FE-EOF              PIC X VALUE 'N'.
               88 EOF              VALUE 'Y'.

       01  WS-DISPLAY-FIELDS.
           05  D-COUNT             PIC ZZZ,ZZZ,ZZ9.
           05  D-ENERGY            PIC ZZZ,ZZZ,ZZ9.999.

       PROCEDURE DIVISION.
           PERFORM 000-MAIN
           STOP RUN.

       000-MAIN.
           OPEN INPUT BIN-FILE
           
           DISPLAY "--- INICIANDO AUDITORIA DE DATOS BINARIOS ---"
           
           PERFORM 100-READ-AND-SUM UNTIL EOF
           
           PERFORM 200-PRINT-REPORT
           
           CLOSE BIN-FILE.

       100-READ-AND-SUM.
           READ BIN-FILE 
               AT END SET EOF TO TRUE
               NOT AT END
                   ADD 1 TO WS-COUNT
                   ADD PH-ENERGY-GEV TO WS-TOTAL-ENERGY
                   IF PH-ENERGY-GEV > WS-MAX-ENERGY
                       MOVE PH-ENERGY-GEV TO WS-MAX-ENERGY
                   END-IF
           END-READ.

       200-PRINT-REPORT.
           MOVE WS-COUNT TO D-COUNT
           DISPLAY "==========================================="
           DISPLAY " REGISTROS PROCESADOS: " D-COUNT
           
           MOVE WS-MAX-ENERGY TO D-ENERGY
           DISPLAY " ENERGIA MAXIMA DETECTADA (GeV): " D-ENERGY
           
           DISPLAY " ESTADO: VERIFICACION COMPLETA "
           DISPLAY "===========================================".
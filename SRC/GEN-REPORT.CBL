       IDENTIFICATION DIVISION.
       PROGRAM-ID. GEN-REPORT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EVENT-FILE ASSIGN TO "DATA_PROC/EVENTS.DAT"
           ORGANIZATION IS SEQUENTIAL.
           
           SELECT REP-FILE ASSIGN TO "REPORTS/DM-CANDIDATES.TXT"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  EVENT-FILE.
           COPY "PHOTON-REC.CPY".
       FD  REP-FILE.
       01  REP-LINE            PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-EOF              PIC X VALUE 'N'.
       01  WS-HEADER.
           05  FILLER          PIC X(20) VALUE "ENERGY(GeV)".
           05  FILLER          PIC X(15) VALUE "GAL-L".
           05  FILLER          PIC X(15) VALUE "GAL-B".
           05  FILLER          PIC X(20) VALUE "STATUS".
           
       01  WS-DET-LINE.
           05  DET-ENERGY      PIC ZZZ,ZZ9.99.
           05  FILLER          PIC X(8)  VALUE SPACES.
           05  DET-L           PIC ---9.99.
           05  FILLER          PIC X(10) VALUE SPACES.
           05  DET-B           PIC ---9.99.
           05  FILLER          PIC X(10) VALUE SPACES.
           05  DET-STATUS      PIC X(15) VALUE "DM-CANDIDATE".

       PROCEDURE DIVISION.
           OPEN INPUT EVENT-FILE
           OPEN OUTPUT REP-FILE
           
           WRITE REP-LINE FROM "REPORTE DE CANDIDATOS A MATERIA OSCURA - VIA PROYECT"
           WRITE REP-LINE FROM "===================================================="
           WRITE REP-LINE FROM WS-HEADER
           WRITE REP-LINE FROM "----------------------------------------------------"
           
           PERFORM UNTIL WS-EOF = 'Y'
               READ EVENT-FILE
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END
                       *> Aplicamos el filtro de los 3 que quedaron vivos
                       IF PH-ENERGY-GEV > 500.0
                           MOVE PH-ENERGY-GEV TO DET-ENERGY
                           MOVE PH-L-DEG TO DET-L
                           MOVE PH-B-DEG TO DET-B
                           WRITE REP-LINE FROM WS-DET-LINE
                       END-IF
               END-READ
           END-PERFORM
           
           CLOSE EVENT-FILE REP-FILE
           DISPLAY "--- REPORTE GENERADO EN REPORTS/DM-CANDIDATES.TXT ---"
           STOP RUN.
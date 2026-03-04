       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRE-PROC.
       AUTHOR. NINE-BRO.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CSV-FILE ASSIGN TO "DATA_RAW/events_gc_sorted.csv"
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUT-FILE ASSIGN TO "DATA_PROC/EVENTS.DAT"
           ORGANIZATION IS SEQUENTIAL.
           SELECT REJECT-FILE ASSIGN TO "REPORTS/BAD-DATA.LOG"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CSV-FILE.
       01  CSV-RECORD          PIC X(500).
       
       FD  OUT-FILE.
           COPY "PHOTON-REC.CPY".
           
       FD  REJECT-FILE.
       01  REJ-RECORD          PIC X(100).

       WORKING-STORAGE SECTION.
       01  WS-CSV-FIELDS.
           05  WS-ENERGY-STR   PIC X(20).
           05  WS-L-STR        PIC X(20).
           05  WS-B-STR        PIC X(20).
       01  WS-FLAGS.
           05  FE-EOF          PIC X VALUE 'N'.
               88 EOF          VALUE 'Y'.

       PROCEDURE DIVISION.
      *> Punto de entrada principal para satisfacer al linter
           PERFORM 000-MAIN
           STOP RUN.

       000-MAIN.
           OPEN INPUT CSV-FILE
           OPEN OUTPUT OUT-FILE REJECT-FILE
           
           DISPLAY "--- INICIANDO PROCESO DE RAYOS GAMMA ---"
           
           READ CSV-FILE INTO CSV-RECORD
                AT END SET EOF TO TRUE
           END-READ
           
           IF NOT EOF
               DISPLAY "ENCABEZADO SALTADO: " CSV-RECORD(1:40)
               PERFORM 100-PROCESS-RECORDS UNTIL EOF
           ELSE
               DISPLAY "ERROR: EL ARCHIVO ESTA VACIO O MAL FORMATEADO"
           END-IF
           
           CLOSE CSV-FILE OUT-FILE REJECT-FILE
           DISPLAY "--- PROCESO FINALIZADO CON EXITO ---".

       100-PROCESS-RECORDS.
           READ CSV-FILE AT END 
               SET EOF TO TRUE
           NOT AT END
               INITIALIZE OUT-REC-BUFFER
               
               UNSTRING CSV-RECORD DELIMITED BY ","
                   INTO WS-ENERGY-STR, WS-L-STR, WS-B-STR
               
               IF WS-ENERGY-STR NOT = SPACES
                   PERFORM 200-VALIDATE-AND-CONVERT
               END-IF
           END-READ.

       200-VALIDATE-AND-CONVERT.
           MOVE FUNCTION NUMVAL(WS-ENERGY-STR) TO PH-ENERGY-GEV
           MOVE FUNCTION NUMVAL(WS-L-STR)      TO PH-L-DEG
           MOVE FUNCTION NUMVAL(WS-B-STR)      TO PH-B-DEG
           
           MOVE 20260304000000 TO PH-TIMESTAMP
           MOVE "PENDING"      TO PH-AUDIT-STATUS
           
           DISPLAY "PROCESANDO ENERGIA: " WS-ENERGY-STR
           
           WRITE OUT-REC-BUFFER.
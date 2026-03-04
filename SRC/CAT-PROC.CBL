       IDENTIFICATION DIVISION.
       PROGRAM-ID. CAT-PROC.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CAT-CSV ASSIGN TO "DATA_RAW/catalog_sorted.csv"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT CAT-IDX ASSIGN TO "DATA_PROC/CATALOG.IDX"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS RANDOM
           RECORD KEY IS SR-NAME
           FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  CAT-CSV.
       01  CSV-LINE            PIC X(200).

       FD  CAT-IDX.
           COPY "SOURCE-REC.CPY".

       WORKING-STORAGE SECTION.
       01  WS-FIELDS.
           05  WS-NAME         PIC X(18).
           05  WS-L-STR        PIC X(20).
           05  WS-B-STR        PIC X(20).
       01  WS-FS               PIC XX.
       01  WS-EOF              PIC X VALUE 'N'.

       PROCEDURE DIVISION.
           OPEN INPUT CAT-CSV
           OPEN OUTPUT CAT-IDX
           
           DISPLAY "--- INICIANDO INDEXACION DEL CATALOGO ---"
           
           *> Saltar encabezado
           READ CAT-CSV
           
           PERFORM UNTIL WS-EOF = 'Y'
               READ CAT-CSV INTO CSV-LINE
                   AT END 
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       UNSTRING CSV-LINE DELIMITED BY ","
                       INTO WS-NAME, WS-L-STR, WS-B-STR
                       
                       MOVE WS-NAME TO SR-NAME
                       MOVE FUNCTION NUMVAL(WS-L-STR) TO SR-L-DEG
                       MOVE FUNCTION NUMVAL(WS-B-STR) TO SR-B-DEG
                       MOVE "4FGL " TO SR-SOURCE-TYPE
                       
                       WRITE SOURCE-MASTER-RECORD
                           INVALID KEY 
                               DISPLAY "ERROR O DUPLICADO EN: " SR-NAME
                       END-WRITE
               END-READ
           END-PERFORM
           
           CLOSE CAT-CSV CAT-IDX
           DISPLAY "--- CATALOGO INDEXADO CON EXITO ---"
           STOP RUN.
      01  OUT-REC-BUFFER.
           05  PHOTON-EVENT-RECORD.
               10  PH-ENERGY-GEV       PIC S9(9)V9(9)   COMP-3.
               10  PH-L-DEG            PIC S9(3)V9(9)   COMP-3.
               10  PH-B-DEG            PIC S9(3)V9(9)   COMP-3.
               10  PH-TIMESTAMP        PIC 9(14).
               10  PH-AUDIT-STATUS     PIC X(10)       VALUE 'PENDING'.
                   88  PH-INTEGRO      VALUE 'INTEGRO'.
                   88  PH-VIOLATION    VALUE 'FRAUD'.
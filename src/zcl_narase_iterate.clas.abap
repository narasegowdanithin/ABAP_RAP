CLASS zcl_narase_iterate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_narase_iterate IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  CONSTANTS max_count TYPE i Value 20.
  DATA numbers TYPE TABLE OF i.
  DATA output TYPE TABLE OF string.
  DO max_count TIMES.
    CASE sy-index.
        WHEN 1.
        APPEND 0 TO numbers.
        WHEN 2.
        APPEND 1 TO numbers.
        WHEN OTHERS.
        APPEND numbers[ sy-index - 2 ]
        + numbers[ sy-index - 1 ]
        TO numbers.
    ENDCASE.
  ENDDO.


  DATA(counter) = 0.
    LOOP AT numbers INTO DATA(number).
        counter = counter + 1.
        APPEND |{ counter WIDTH = 4 }: { number WIDTH = 2 ALIGN = RIGHT }| TO output.
    ENDLOOP.

    IF output IS INITIAL. "no error so far
            out->write( 'No output' ).
        ENDIF.

        out->write(
        data = output
        name  = |The first { max_count } Fibonacci Numbers| ).
  ENDMETHOD.
ENDCLASS.

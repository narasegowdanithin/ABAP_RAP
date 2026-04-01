CLASS zcl_narase_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_narase_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA number1 TYPE i VALUE -12.
  DATA number2 TYPE i VALUE 6.
  DATA result Type p lengTH 8 DeCIMALS 2.

  result = number1 / number2.

  out->write( |{ number1 } / { number2 } = { result } | ).

  ENDMETHOD.
ENDCLASS.

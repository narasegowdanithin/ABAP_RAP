CLASS zcl_narase_branch_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_NARASE_BRANCH_COMPUTE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**************************

    DATA number1 TYPE i.
    DATA number2 TYPE i.
    DATA op TYPE c LENGTH 1.

    DATA result TYPE p LENGTH 8 DECIMALS 2.

    DATA output TYPE string.


* Input Values
**************************

    "number1 = -8.
    "number2 = 3.

* Calculation
**************************

*    DATA(result) = number1 / number2.

    "result = number1 / number2.

    "DATA(output) = |{ number1 } / { number2 } = { result }|.

    number1 = 123.
    number2 = 13.
    op = '/'.


    CASE op.
        WHEN '+'.
            result = number1 + number2.
        WHEN '-'.
            result = number1 - number2.
        WHEN '*'.
            result = number1 * number2.
        WHEN '/'.
            TRY.
                result = number1 / number2.
                CATCH cx_sy_zerodivide.
                output = |Division by zero is not defined|.
            ENDTRY.
        WHEN OTHERS.
            output = |'{ op }' is not a valid operator!|.
    ENDCASE.

    IF output IS INITIAL. "no error so far
        output = |{ number1 } { op } { number2 } = { result }|.
    ENDIF.


* Output
**************************

    out->write( output ).

  ENDMETHOD.
ENDCLASS.

CLASS lcl_connection DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    CLASS-DATA conn_counter TYPE i.

    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_output.
        APPEND |--------------------------------| TO r_output.
        APPEND |-------Carrier:{ carrier_id } | TO r_output.
        APPEND |--------connection :{ connection_id } | TO r_output.
        APPEND |--------------------------------| TO r_output.
  ENDMETHOD.

  METHOD set_attributes.

    if i_carrier_id IS INITIAL or i_connection_id is INITIAL.
        RAISE EXCEPTION TyPE cx_abap_invalid_value.
    ENDIF.

    carrier_id = i_carrier_id.
    connection_id = i_connection_id.


  ENDMETHOD.

ENDCLASS.

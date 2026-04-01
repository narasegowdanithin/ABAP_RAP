CLASS zcl_narase_constructor_ex11 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_narase_constructor_ex11 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

* First Instance
**********************************************************************
*    connection = NEW #( ).
*    connection->carrier_id = 'LH'.
*    connection->connection_id = '0400'.
*    APPEND connection TO connections.
* Second Instance
**********************************************************************
*    connection = NEW #( ).
*    connection->carrier_id = 'AA'.
*    connection->connection_id = '0017'.
*    APPEND connection TO connections.
* Third Instance
**********************************************************************
*    connection = NEW #( ).
*    connection->carrier_id = 'SQ'.
*    connection->connection_id = '0001'.
*    APPEND connection TO connections.

    out->write( 'No output' ).

* First Instance
**********************************************************************
    TRY.
        connection = NEW #(
        i_carrier_id = 'LH'
        i_connection_id = '0400'
        ).

* connection->set_attributes(
* EXPORTING
* i_carrier_id = 'LH'
* i_connection_id = '0400'
* ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.
* Second instance
*****************
    TRY.
        connection = NEW #(
         i_carrier_id = 'AA'
         i_connection_id = '0017'
         ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

* Third instance
**********************************************************************
    TRY.
        connection = NEW #(
        i_carrier_id = 'SQ'
        i_connection_id = '0001'
        ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.
* Output
**********************************************************************
    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.

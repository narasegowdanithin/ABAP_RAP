*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i READ-ONLY.




*    METHODS set_attributes
*      IMPORTING
*        i_carrier_id    TYPE /dmo/carrier_id
*        i_connection_id TYPE /dmo/connection_id
*      RAISING
*        cx_abap_invalid_value.

    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
      RAISING
        cx_abap_invalid_value.

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

*   DATA airport_from_id TYPE /DMO/AIRPORT_FROM_ID.
*    DATA airport_to_id TYPE /DMO/AIRPORT_TO_ID.

*    DATA carrier_name TYPE /DMO/CARRIER_NAME.

TYPES:
    BeGIN OF st_airport,
    AirportID TYPE /DMO/AIRPORT_ID,
    Name TYPE /DMO/AIRPORT_NAME,
    END OF st_AIRPORT.


TYPES:
    BEGIN OF st_details,
        DepartureAirport TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName TYPE /dmo/carrier_name,

    END of st_details.


TYPES tt_airports TYPE  STANDARD TABLE of st_airport
                       with NON-UNIQUE DEFAULT KEY.

*DATA airport_from_id TYPE /DMO/AIRPORT_FROM_ID.
*DATA airport_to_id TYPE /DMO/AIRPORT_TO_ID.
*DATA carrier_name TYPE /DMO/CARRIER_NAME.

DATA details TYPE st_details.
CLASS-DATA airports TYPE tt_airports.




ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

*    SELECT SINGLE
*    FROM /dmo/connection
*    FIELDS airport_from_id , airport_to_id
*    WHERE carrier_id = @i_carrier_id AND connection_id = @i_connection_id
*    INTO ( @me->airport_from_id, @me->airport_to_id ).

SELECT
FROM /DMO/I_AIRPORT
FIELDS AirportID,Name
INTO TABLE @airports.


SELECT single
FROM /DMO/I_Connection
FIELDS DepartureAirport,DestinationAirport,\_Airline-Name as AirlineName
WHERE AirlineID = @i_carrier_id AND ConnectionID = @i_connection_id
*INTO (@me->airport_from_id, @me->airport_to_id,@me->carrier_name ).\
INTO CORRESPONDING FIELDS OF @details.
*INTO @deatils

    IF sy-subrc <> 0.
 RAISE EXCEPTION TYPE cx_abap_invalid_value.
 ENDIF.


 " Assign values after validation
  me->carrier_id    = i_carrier_id.
  me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.

  ENDMETHOD.

  METHOD get_output.

*   APPEND |------------------------------| TO r_output.
*    APPEND |Carrier:     { carrier_id    }| TO r_output.
*    APPEND |Connection:  { connection_id }| TO r_output.
*    APPEND |AIRport from :     { airport_from_id   }| TO r_output.
*    APPEND |airport to :  { airport_to_id }| TO r_output.
*    APPEND |carrerrie name : { carrier_name }| TO r_output.
DATA(departure) = airports[ airportid = details-departureairport ].
DATA(destination) = airports[ airportid = details-destinationairport ].


    APPEND |--------------------------------| TO r_output.
    APPEND |Carrier: { carrier_id } { details-airlinename }| TO r_output.
    APPEND |Connection: { connection_id }| TO r_output.
*   APPEND |Departure: { details-departureairport }| TO r_output.
*   APPEND |Destination: { details-destinationairport }| TO r_output.
    APPEND |Departure: { details-departureairport } { departure-name }| TO r_output.
    APPEND |Destination: { details-destinationairport } { destination-name }| TO r_output.


  ENDMETHOD.

*  METHOD set_attributes.
*    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.
*
*    carrier_id    = i_carrier_id.
*    connection_id = i_connection_id.
*
*  ENDMETHOD.

ENDCLASS.

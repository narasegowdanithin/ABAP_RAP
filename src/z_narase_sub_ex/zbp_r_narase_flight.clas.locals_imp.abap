CLASS lhc_zr_narase_flight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.




    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Flight
        RESULT result,
      validationPrice FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flight~validationPrice,
      validationCurrencyCode FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flight~validationCurrencyCode.
ENDCLASS.

CLASS lhc_zr_narase_flight IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD validationPrice.
    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    READ ENTITIES OF zr_narase_flight IN LOCAL MODE
         ENTITY Flight
         FIELDS ( Price )
         WITH CORRESPONDING #( keys )
         RESULT DATA(flights).


    LOOP AT flights INTO DATA(flight).
      IF flight-Price < 0.
        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flight.

        reported_record-%tky = flight-%tky.

        reported_record-%msg = new_message( id = 'LRN/S4D400'
                                            number = '101'
                                            severity = if_abap_behv_message=>severity-error ).

        APPEND reported_record TO reported-flight.
      ENDIF.


    ENDLOOP.

  ENDMETHOD.

  METHOD validationCurrencyCode.

    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    DATA exists TYPE abap_bool.

    READ ENTITIES OF zr_narase_flight IN LOCAL MODE
         ENTITY Flight
         FIELDS ( CurrencyCode )
         WITH CORRESPONDING #( keys )
         RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).

      exists = abap_false.

      SELECT SINGLE FROM I_Currency FIELDS Currency
        WHERE Currency = @flight-CurrencyCode
        INTO @DATA(currency).

      IF sy-subrc = 0.
        exists = abap_true.
      ENDIF.

      IF exists = abap_false.
        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flight.

        reported_record-%tky = flight-%tky.

        reported_record-%msg = new_message( id = '/LRN/S4D400'
                                              number = '102'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = flight-currencycode
         ).

        APPEND reported_record TO reported-flight.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

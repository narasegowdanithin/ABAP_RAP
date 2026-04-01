CLASS zcl_narase_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_narase_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA agencies_upd TYPE TABLE FOR UPDATE /dmo/i_agencytp.
 agencies_upd = VALUE #( ( agencyid = '070059' name = 'NARASE EDIT' Street = 'cologne' PostalCode = '56002' ) ).

 MODIFY ENTITIES OF /dmo/i_agencytp
 ENTITY /dmo/agency
 UPDATE FIELDS ( name Street PostalCode )
 WITH agencies_upd.
 COMMIT ENTITIES.
 out->write( `Method execution finished!` ).

  ENDMETHOD.
ENDCLASS.

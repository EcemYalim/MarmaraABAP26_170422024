CLASS zcl_170422024_work_with_intbl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422024_work_with_intbl IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  TYPES: BEGIN OF st_connection,
         carrier_id     TYPE /dmo/carrier_id,
         connection_id  TYPE /dmo/connection_id,
         airport_from_id TYPE /dmo/airport_from_id,
         airport_to_id   TYPE /dmo/airport_to_id,
         carrier_name    TYPE /dmo/carrier_name,
       END OF st_connection.

TYPES tt_connections TYPE SORTED TABLE OF st_connection
       WITH NON-UNIQUE KEY carrier_id connection_id.

DATA connections TYPE tt_connections.
DATA connection  LIKE LINE OF connections.

TYPES: BEGIN OF st_carrier,
         carrier_id   TYPE /dmo/carrier_id,
         currency_code TYPE /dmo/currency_code,
         END OF st_carrier.

DATA carriers TYPE STANDARD TABLE OF st_carrier
      WITH NON-UNIQUE KEY carrier_id.

DATA carrier LIKE LINE OF carriers.

connections = VALUE #(
  ( carrier_id     = 'JL'
    connection_id  = '0408'
    airport_from_id = 'FRA'
    airport_to_id   = 'NRT'
    carrier_name    = 'Japan Airlines' )

  ( carrier_id     = 'AA'
    connection_id  = '0017'
     airport_from_id = 'MIA'
    airport_to_id   = 'HAV'
    carrier_name    = 'American Airlines' )

  ( carrier_id     = 'SQ'
    connection_id  = '0001'
    airport_from_id = 'SFO'
    airport_to_id   = 'SIN'
    carrier_name    = 'Singapore Airlines' )
).

carriers = VALUE #(
  ( carrier_id   = 'SQ'
    currency_code = '' )

  ( carrier_id   = 'JL'
    currency_code = '' )

  ( carrier_id   = 'AA'
    currency_code = '' )
    ).

* Example 1: Table Expression with Key Access
*****************************************************

* with key fields
connection = connections[ carrier_id    = 'SQ'
                          connection_id = '0001' ].

* with non-key fields
connection = connections[ airport_from_id = 'SFO'
                          airport_to_id   = 'SIN' ].
* Example 2: LOOP with key access
*****************************************************

LOOP AT connections INTO connection
     WHERE airport_from_id = 'MIA'.

  out->write(
    data = connection
    name = |This is row number { sy-tabix }| ).

ENDLOOP.


* Example 3: MODIFY TABLE (key access)
*****************************************************

carrier = carriers[ carrier_id = 'JL' ].
carrier-currency_code = 'JPY'.

MODIFY TABLE carriers FROM carrier.
* Example 4: MODIFY (index access)
*****************************************************

carrier-carrier_id   = 'LH'.
carrier-currency_code = 'EUR'.

MODIFY carriers FROM carrier INDEX 1.


* Example 5: MODIFY in a LOOP
*****************************************************

LOOP AT carriers INTO carrier
     WHERE currency_code IS INITIAL.

  carrier-currency_code = 'USD'.

  MODIFY carriers FROM carrier.

ENDLOOP.

  ENDMETHOD.
ENDCLASS.

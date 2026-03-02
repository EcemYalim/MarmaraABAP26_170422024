CLASS zcl_170422024_230226 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422024_230226 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "Print Hello Marmara!
    out->write( 'Hello Marmara!' ).
    "Data Declarations - Variables
    DATA: lv_integer   TYPE i, "i: Integer
          lv_string    TYPE string, "string: String
          lv_character TYPE c LENGTH 7, "c: Character
          lv_date      TYPE d, "d: Date
          lv_packed    TYPE p LENGTH 3 DECIMALS 3. "p: Packed Number LENGTH: Length of Digits Before Decimal Point and Decimal Point
    " DECIMALS: Length of Decimal Places
    "Assigning Values
**********************************************************************
    "Integer Assignments
    lv_integer = 6.
    out->write( |lv_integer = { lv_integer }| ).
    lv_integer = 6 + 3.
    out->write( |lv_integer = { lv_integer }| ).

    "Addition
    lv_integer = 6.
    lv_integer = lv_integer + 3.
    out->write( |lv_integer + 3 = { lv_integer }| ).

    lv_integer = 6.
    lv_integer += 3.
    out->write( |lv_integer + 3 = { lv_integer }| ).

    "Subtraction
    lv_integer = 6.
    lv_integer = lv_integer - 3.
    out->write( |lv_integer - 3 = { lv_integer }| ).

    lv_integer = 6.
    lv_integer -= 3.
    out->write( |lv_integer - 3 = { lv_integer }| ).

    "Multiplication
    lv_integer = 6.
    lv_integer = lv_integer * 2.
    out->write( |lv_integer x 2 = { lv_integer }| ).

    lv_integer = 6.
    lv_integer *= 2.
    out->write( |lv_integer x 2 = { lv_integer }| ).

    "Division
    lv_integer = 6.
    lv_integer = lv_integer / 2.
    out->write( |lv_integer / 2 = { lv_integer }| ).

    lv_integer = 6.
    lv_integer /= 2.
    out->write( |lv_integer / 2 = { lv_integer }| ).

    lv_integer = 1234567891.
    out->write( lv_integer ).
**********************************************************************
    "String Assignments
    lv_string = 'String'.
    out->write( |lv_string = { lv_string }| ).

    lv_string = |String|.
    out->write( |lv_string = { lv_string }| ).

    lv_string = |{ lv_string } & { lv_integer }|.
    out->write( |lv_string & lv_integer = { lv_string }| ).
**********************************************************************
    "Character Assignments
    lv_character = 'Class'.
    out->write( |lv_character = { lv_character }| ).
    lv_character = |Class|.
    out->write( |lv_character = { lv_character }| ).

    lv_integer = 2026.
    lv_character = |Class of { lv_integer }|.
    out->write( |lv_character = { lv_character }| ).

    lv_character = |{ lv_integer }|.
    out->write( |lv_character = { lv_character }| ).
    "Date Assignments
    lv_date = cl_abap_context_info=>get_system_date( ).
    out->write( |lv_date = { lv_date }| ).
    "SAP stores date values in format YYYYMMDD.
    out->write( |lv_date arranged in DD.MM.YYYY format= { lv_date+6(2) }.{ lv_date+4(2) }.{ lv_date(4) }| ).
    out->write( |lv_date arranged in DD.MM.YYYY format= { substring( val = lv_date off = 6 len = 2 ) }.{ substring( val = lv_date off = 4 len = 2 ) }.{ substring( val = lv_date off = 0 len = 4 ) }| ).
**********************************************************************
    "Packed Number Assignments
    lv_packed = 12.
    out->write( |lv_packed = { lv_packed }| ).
    lv_packed = 9 / 8.
    out->write( |lv_packed = { lv_packed }| ).

    lv_integer = 9.
    lv_packed = lv_integer / 8.
    out->write( |lv_packed = { lv_packed }| ).
**********************************************************************

    "Structure Type Declarations
    TYPES: BEGIN OF lty_attendance,
             student_number   TYPE i,
             student_name     TYPE string,
             student_lastname TYPE string,
           END OF lty_attendance.
    "Structure and Internal Table Declarations
    DATA: ls_attendance TYPE lty_attendance,
          lt_attendance TYPE STANDARD TABLE OF lty_attendance.

    "Structure and Internal Table Declarations
    ls_attendance = VALUE #( student_number = 1234567891
    student_name = |Mehmet|
    student_lastname = |Yılmaz| ).
    out->write( |ls_attendance :| ).
    out->write( ls_attendance ).
    APPEND ls_attendance TO lt_attendance.
    out->write( |lt_attendance :| ).
    out->write( lt_attendance ).

    lt_attendance = VALUE #( ( student_number = 1234567891 student_name = |Mehmet| student_lastname = |Yılmaz| )
    ( student_number = 1234567892 student_name = |Burak| student_lastname = |Yıldız| )
    ( student_number = 1234567893 student_name = |Ayşe| student_lastname = |Yalçın| )
    ).
    out->write( |lt_attendance :| ).
    out->write( lt_attendance ).

    lt_attendance = VALUE #( BASE lt_attendance ( student_number = 1234567894 student_name = |Elif| student_lastname = |Yurt| ) ).
    out->write( |lt_attendance :| ).
    out->write( lt_attendance ).

    ls_attendance = VALUE #( student_number = 1234567895
    student_name = |Esma|
    student_lastname = |Yorulmaz| ).
    APPEND ls_attendance TO lt_attendance.
    out->write( |lt_attendance :| ).
    out->write( lt_attendance ).

    APPEND VALUE #( student_number = 1234567895 student_name = |Kerem| student_lastname = |Yıldırım| ) TO lt_attendance.
    out->write( |lt_attendance :| ).
    out->write( lt_attendance ).
  ENDMETHOD.

ENDCLASS.

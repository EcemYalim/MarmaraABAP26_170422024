CLASS zlc_170422024_work_with_intbl3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zlc_170422024_work_with_intbl3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
      " Field definitions
    TYPES: BEGIN OF ty_employee,
             pernr         TYPE i,       " Personnel number (key)
             ad            TYPE string,  " First name
             soyad         TYPE string,  " Last name
             yas           TYPE i,       " Age
             kayit_tarihi  TYPE d,       " Registration date
           END OF ty_employee.

    " Table type definitions

  TYPES: tt_standard TYPE STANDARD TABLE OF ty_employee WITH NON-UNIQUE KEY pernr,
       tt_sorted   TYPE SORTED TABLE OF ty_employee WITH UNIQUE KEY pernr,
       tt_hashed   TYPE HASHED TABLE OF ty_employee WITH UNIQUE KEY pernr.

DATA: lt_standard TYPE tt_standard,
      lt_sorted   TYPE tt_sorted,
      lt_hashed   TYPE tt_hashed.

DATA: ls_employee TYPE ty_employee.

* 1st record
ls_employee-pernr         = 1001.
ls_employee-ad            = 'Ali'.
ls_employee-soyad         = 'Yilmaz'.
ls_employee-yas           = 28.
ls_employee-kayit_tarihi  = '20230115'.

APPEND ls_employee TO lt_standard.
INSERT ls_employee INTO TABLE lt_sorted.
INSERT ls_employee INTO TABLE lt_hashed.

CLEAR ls_employee.
* 2nd record
ls_employee-pernr         = 1002.
ls_employee-ad            = 'Ayse'.
ls_employee-soyad         = 'Demir'.
ls_employee-yas           = 32.
ls_employee-kayit_tarihi  = '20230220'.

APPEND ls_employee TO lt_standard.
INSERT ls_employee INTO TABLE lt_sorted.
INSERT ls_employee INTO TABLE lt_hashed.

CLEAR ls_employee.


* 3rd record
ls_employee-pernr         = 1003.
ls_employee-ad            = 'Mehmet'.
ls_employee-soyad         = 'Kaya'.
ls_employee-yas           = 25.
ls_employee-kayit_tarihi  = '20230310'.

APPEND ls_employee TO lt_standard.
INSERT ls_employee INTO TABLE lt_sorted.
INSERT ls_employee INTO TABLE lt_hashed.

CLEAR ls_employee.
* 4th record
ls_employee-pernr         = 1004.
ls_employee-ad            = 'Zeynep'.
ls_employee-soyad         = 'Celik'.
ls_employee-yas           = 35.
ls_employee-kayit_tarihi  = '20230405'.

APPEND ls_employee TO lt_standard.
INSERT ls_employee INTO TABLE lt_sorted.
INSERT ls_employee INTO TABLE lt_hashed.

CLEAR ls_employee.


* 5th record
ls_employee-pernr         = 1005.
ls_employee-ad            = 'Mustafa'.
ls_employee-soyad         = 'Aydin'.
ls_employee-yas           = 29.
ls_employee-kayit_tarihi  = '20230512'.

APPEND ls_employee TO lt_standard.
INSERT ls_employee INTO TABLE lt_sorted.
INSERT ls_employee INTO TABLE lt_hashed.


CLEAR ls_employee.
* 1-) Linear search on standard table
READ TABLE lt_standard INTO ls_employee WITH KEY pernr = 1003.
IF sy-subrc = 0.
  out->write( |Employee found: { ls_employee-pernr } { ls_employee-ad } { ls_employee-soyad }| ).
ENDIF.

CLEAR ls_employee.


* 2-) Sort standard table by first name for binary search
SORT lt_standard BY ad.

* Binary search by first name
READ TABLE lt_standard INTO ls_employee
     WITH KEY ad = 'Zeynep'
     BINARY SEARCH.

IF sy-subrc = 0.
  out->write( |Employee found: { ls_employee-pernr } { ls_employee-ad } { ls_employee-soyad }| ).
ENDIF.

CLEAR ls_employee.


* 3-) Search on sorted table (automatic binary search)
READ TABLE lt_sorted INTO ls_employee
     WITH TABLE KEY pernr = 1002.
     IF sy-subrc = 0.
  out->write(
    |Employee found: { ls_employee-pernr }|
    && | { ls_employee-ad } { ls_employee-soyad }| ).
ENDIF.

CLEAR ls_employee.

* 4-) Search on hashed table
READ TABLE lt_hashed INTO ls_employee
     WITH TABLE KEY pernr = 1004.

IF sy-subrc = 0.
  out->write(
    |Employee found: { ls_employee-pernr }|
    && | { ls_employee-ad } { ls_employee-soyad }| ).
ENDIF.

CLEAR ls_employee.

  ENDMETHOD.
ENDCLASS.

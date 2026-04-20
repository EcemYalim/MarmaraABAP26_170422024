CLASS zcl_170422024_rest_client_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS gc_base_url TYPE string VALUE 'https://petstore.swagger.io/v2'.
    DATA mv_token TYPE string.

    METHODS run_demo
      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS create_http_client
      IMPORTING iv_url           TYPE string
      RETURNING VALUE(ro_client) TYPE REF TO if_web_http_client
      RAISING   cx_web_http_client_error
                cx_http_dest_provider_error.

    METHODS execute_request
      IMPORTING iv_method      TYPE string
                iv_url         TYPE string
                iv_body        TYPE string OPTIONAL
      RETURNING VALUE(rv_text) TYPE string.

    METHODS build_user_json
      RETURNING VALUE(rv_json) TYPE string.

    METHODS user_create RETURNING VALUE(rv_text) TYPE string.
    METHODS user_get    RETURNING VALUE(rv_text) TYPE string.
    METHODS user_update RETURNING VALUE(rv_text) TYPE string.
    METHODS user_delete RETURNING VALUE(rv_text) TYPE string.

ENDCLASS.



CLASS zcl_170422024_rest_client_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    run_demo( io_out = out ).
  ENDMETHOD.

  METHOD run_demo.

    io_out->write( '--- CREATE USER ---' ).
    io_out->write( user_create( ) ).

    " io_out->write( user_get( ) ).
    " io_out->write( '--- UPDATE USER ---' ).
    " io_out->write( user_update( ) ).
    " io_out->write( '--- DELETE USER ---' ).
    " io_out->write( user_delete( ) ).
  ENDMETHOD.

  METHOD create_http_client.
    TRY.
        ro_client = cl_web_http_client_manager=>create_by_http_destination(
                      cl_http_destination_provider=>create_by_url( iv_url ) ).
      CATCH cx_web_http_client_error INTO DATA(lo_web_http_client_error).
        DATA(lv_text_01) = lo_web_http_client_error->get_text( ).
      CATCH cx_http_dest_provider_error INTO DATA(lo_http_dest_provider_error).
        DATA(lv_text_02) = lo_http_dest_provider_error->get_text( ).
    ENDTRY.
  ENDMETHOD.

  METHOD execute_request.
    TRY.
        DATA(lo_client) = create_http_client( iv_url ).
        DATA(lo_request) = lo_client->get_http_request( ).

        lo_request->set_header_field(
          i_name  = 'Content-Type'
          i_value = 'application/json' ).

        IF iv_body IS NOT INITIAL.
          lo_request->set_text( iv_body ).
        ENDIF.


        DATA(lo_response) = lo_client->execute(
          i_method = COND #(
            WHEN iv_method = 'GET'    THEN if_web_http_client=>get
            WHEN iv_method = 'POST'   THEN if_web_http_client=>post
            WHEN iv_method = 'PUT'    THEN if_web_http_client=>put
            WHEN iv_method = 'DELETE' THEN if_web_http_client=>delete
            ELSE if_web_http_client=>get ) ).


        DATA(ls_status) = lo_response->get_status( ).

        rv_text = |HTTP { ls_status-code } { ls_status-reason } | &&
                  lo_response->get_text( ).

      CATCH cx_root INTO DATA(lx_error).
        rv_text = lx_error->get_text( ).
    ENDTRY.
  ENDMETHOD.

  METHOD user_create.
    rv_text = execute_request(
      iv_method = 'POST'
      iv_url    = gc_base_url && '/user'
      iv_body   = build_user_json( ) ).
  ENDMETHOD.

  METHOD user_get.
    " rv_text = execute_request(
    "  iv_method = 'GET'
    "  iv_url    = gc_base_url && '/user/demo_170422024' ).
  ENDMETHOD.

  METHOD user_update.
    " rv_text = execute_request(
    "  iv_method = 'PUT'
    "  iv_url    = gc_base_url && '/user/demo_170422024'
    "  iv_body   = build_user_json( ) ).
  ENDMETHOD.

  METHOD user_delete.
    " rv_text = execute_request(
    "  iv_method = 'DELETE'
    "  iv_url    = gc_base_url && '/user/demo_170422024' ).
  ENDMETHOD.

  METHOD build_user_json.
    rv_json =
      '{' &&
      '"id": 170422024,' &&
      '"username": "demo_170422024",' &&
      '"firstName": "berfin",' &&
      '"lastName": "petek",' &&
      '"email": "hakan.demo@example.com",' &&
      '"password": "Abc12345!",' &&
      '"phone": "5550001111",' &&
      '"userStatus": 1' &&
      '}'.
  ENDMETHOD.

ENDCLASS.

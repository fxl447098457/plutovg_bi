#pragma once

#ifndef PLUTOVG_H 
#define PLUTOVG_H
#include once "win/windef.bi"
#inclib "plutovg"
#inclib "pthread"
extern "C"

Declare Function plutovg_version() As Long
declare function plutovg_version_string() as const zstring ptr
type plutovg_destroy_func_t as sub(byval closure as any ptr)
Type plutovg_write_func_t As Sub(ByVal closure As Any Ptr, ByVal data_ As Any Ptr, ByVal size As Long)
const PLUTOVG_PI = 3.14159265358979323846f
const PLUTOVG_TWO_PI = 6.28318530717958647693f
const PLUTOVG_HALF_PI = 1.57079632679489661923f
const PLUTOVG_SQRT2 = 1.41421356237309504880f
const PLUTOVG_KAPPA = 0.55228474983079339840f
#define PLUTOVG_DEG2RAD(x) ((x) * (PLUTOVG_PI / 180.0f))
#define PLUTOVG_RAD2DEG(x) ((x) * (180.0f / PLUTOVG_PI))

type plutovg_point
   x as single
   y as single
end type

type plutovg_point_t as plutovg_point

type plutovg_rect
   x as single
   y as single
   w as single
   h as single
end type

type plutovg_rect_t as plutovg_rect

type plutovg_matrix
   a as single
   b as single
   c as single
   d as single
   e as single
   f as single
end type

type plutovg_matrix_t as plutovg_matrix

declare sub plutovg_matrix_init(byval matrix as plutovg_matrix_t ptr, byval a as single, byval b as single, byval c as single, byval d as single, byval e as single, byval f as single)
declare sub plutovg_matrix_init_identity(byval matrix as plutovg_matrix_t ptr)
declare sub plutovg_matrix_init_translate(byval matrix as plutovg_matrix_t ptr, byval tx as single, byval ty as single)
declare sub plutovg_matrix_init_scale(byval matrix as plutovg_matrix_t ptr, byval sx as single, byval sy as single)
declare sub plutovg_matrix_init_rotate(byval matrix as plutovg_matrix_t ptr, byval angle as single)
declare sub plutovg_matrix_init_shear(byval matrix as plutovg_matrix_t ptr, byval shx as single, byval shy as single)
declare sub plutovg_matrix_translate(byval matrix as plutovg_matrix_t ptr, byval tx as single, byval ty as single)
Declare Sub plutovg_matrix_scale(ByVal matrix As plutovg_matrix_t Ptr, ByVal sx As Single, ByVal sy As Single)
Declare Sub plutovg_matrix_rotate(ByVal matrix As plutovg_matrix_t Ptr, ByVal angle As Single)
declare sub plutovg_matrix_shear(byval matrix as plutovg_matrix_t ptr, byval shx as single, byval shy as single)
Declare Sub plutovg_matrix_multiply(ByVal matrix As plutovg_matrix_t Ptr, ByVal Left_ As Const plutovg_matrix_t Ptr, ByVal Right_ As Const plutovg_matrix_t Ptr)
Declare Function plutovg_matrix_invert(ByVal matrix As Const plutovg_matrix_t Ptr, ByVal inverse As plutovg_matrix_t Ptr) As BOOL
declare sub plutovg_matrix_map(byval matrix as const plutovg_matrix_t ptr, byval x as single, byval y as single, byval xx as single ptr, byval yy as single ptr)
declare sub plutovg_matrix_map_point(byval matrix as const plutovg_matrix_t ptr, byval src as const plutovg_point_t ptr, byval dst as plutovg_point_t ptr)
declare sub plutovg_matrix_map_points(byval matrix as const plutovg_matrix_t ptr, byval src as const plutovg_point_t ptr, byval dst as plutovg_point_t ptr, byval count as long)
declare sub plutovg_matrix_map_rect(byval matrix as const plutovg_matrix_t ptr, byval src as const plutovg_rect_t ptr, byval dst as plutovg_rect_t ptr)
Declare Function plutovg_matrix_parse(ByVal matrix As plutovg_matrix_t Ptr, ByVal data_ As Const ZString Ptr, ByVal length As Long) As BOOL
type plutovg_path_t as plutovg_path

Type plutovg_path_command As Long
enum
   PLUTOVG_PATH_COMMAND_MOVE_TO
   PLUTOVG_PATH_COMMAND_LINE_TO
   PLUTOVG_PATH_COMMAND_CUBIC_TO
   PLUTOVG_PATH_COMMAND_CLOSE
end enum

type plutovg_path_command_t as plutovg_path_command

type plutovg_path_element_header
   _command As plutovg_path_command_t
   length As Long
end type

union plutovg_path_element
   header as plutovg_path_element_header
   _point As plutovg_point_t
end union

type plutovg_path_element_t as plutovg_path_element

type plutovg_path_iterator
   elements as const plutovg_path_element_t ptr
   size as long
   index as long
end type

type plutovg_path_iterator_t as plutovg_path_iterator
declare sub plutovg_path_iterator_init(byval it as plutovg_path_iterator_t ptr, byval path as const plutovg_path_t ptr)
declare function plutovg_path_iterator_has_next(byval it as const plutovg_path_iterator_t ptr) as bool
declare function plutovg_path_iterator_next(byval it as plutovg_path_iterator_t ptr, byval points as plutovg_point_t ptr) as plutovg_path_command_t
declare function plutovg_path_create() as plutovg_path_t ptr
declare function plutovg_path_reference(byval path as plutovg_path_t ptr) as plutovg_path_t ptr
declare sub plutovg_path_destroy(byval path as plutovg_path_t ptr)
declare function plutovg_path_get_reference_count(byval path as const plutovg_path_t ptr) as long
declare function plutovg_path_get_elements(byval path as const plutovg_path_t ptr, byval elements as const plutovg_path_element_t ptr ptr) as long
declare sub plutovg_path_move_to(byval path as plutovg_path_t ptr, byval x as single, byval y as single)
declare sub plutovg_path_line_to(byval path as plutovg_path_t ptr, byval x as single, byval y as single)
declare sub plutovg_path_quad_to(byval path as plutovg_path_t ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single)
declare sub plutovg_path_cubic_to(byval path as plutovg_path_t ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval x3 as single, byval y3 as single)
declare sub plutovg_path_arc_to(byval path as plutovg_path_t ptr, byval rx as single, byval ry as single, byval angle as single, byval large_arc_flag as bool, byval sweep_flag as bool, byval x as single, byval y as single)
declare sub plutovg_path_close(byval path as plutovg_path_t ptr)
declare sub plutovg_path_get_current_point(byval path as const plutovg_path_t ptr, byval x as single ptr, byval y as single ptr)
declare sub plutovg_path_reserve(byval path as plutovg_path_t ptr, byval count as long)
declare sub plutovg_path_reset(byval path as plutovg_path_t ptr)
declare sub plutovg_path_add_rect(byval path as plutovg_path_t ptr, byval x as single, byval y as single, byval w as single, byval h as single)
declare sub plutovg_path_add_round_rect(byval path as plutovg_path_t ptr, byval x as single, byval y as single, byval w as single, byval h as single, byval rx as single, byval ry as single)
declare sub plutovg_path_add_ellipse(byval path as plutovg_path_t ptr, byval cx as single, byval cy as single, byval rx as single, byval ry as single)
declare sub plutovg_path_add_circle(byval path as plutovg_path_t ptr, byval cx as single, byval cy as single, byval r as single)
declare sub plutovg_path_add_arc(byval path as plutovg_path_t ptr, byval cx as single, byval cy as single, byval r as single, byval a0 as single, byval a1 as single, byval ccw as bool)
declare sub plutovg_path_add_path(byval path as plutovg_path_t ptr, byval source as const plutovg_path_t ptr, byval matrix as const plutovg_matrix_t ptr)
declare sub plutovg_path_transform(byval path as plutovg_path_t ptr, byval matrix as const plutovg_matrix_t ptr)
Type plutovg_path_traverse_func_t As Sub(ByVal closure As Any Ptr, ByVal command_ As plutovg_path_command_t, ByVal points As Const plutovg_point_t Ptr, ByVal npoints As Long)
declare sub plutovg_path_traverse(byval path as const plutovg_path_t ptr, byval traverse_func as plutovg_path_traverse_func_t, byval closure as any ptr)
declare sub plutovg_path_traverse_flatten(byval path as const plutovg_path_t ptr, byval traverse_func as plutovg_path_traverse_func_t, byval closure as any ptr)
declare sub plutovg_path_traverse_dashed(byval path as const plutovg_path_t ptr, byval offset as single, byval dashes as const single ptr, byval ndashes as long, byval traverse_func as plutovg_path_traverse_func_t, byval closure as any ptr)
Declare Function plutovg_path_clone(ByVal path As Const plutovg_path_t Ptr) As plutovg_path_t Ptr
declare function plutovg_path_clone_flatten(byval path as const plutovg_path_t ptr) as plutovg_path_t ptr
declare function plutovg_path_clone_dashed(byval path as const plutovg_path_t ptr, byval offset as single, byval dashes as const single ptr, byval ndashes as long) as plutovg_path_t ptr
Declare Function plutovg_path_extents(ByVal path As Const plutovg_path_t Ptr, ByVal extents As plutovg_rect_t Ptr, ByVal tight As BOOL) As Single
declare function plutovg_path_length(byval path as const plutovg_path_t ptr) as single
Declare Function plutovg_path_parse(ByVal path As plutovg_path_t Ptr, ByVal data_ As Const ZString Ptr, ByVal length As Long) As BOOL

type plutovg_text_encoding as long
enum
   PLUTOVG_TEXT_ENCODING_UTF8
   PLUTOVG_TEXT_ENCODING_UTF16
   PLUTOVG_TEXT_ENCODING_UTF32
   PLUTOVG_TEXT_ENCODING_LATIN1
end enum

type plutovg_text_encoding_t as plutovg_text_encoding

type plutovg_text_iterator
   text as const any ptr
   length As Long
   _encoding As plutovg_text_encoding_t
   index as long
end type

type plutovg_text_iterator_t as plutovg_text_iterator
type plutovg_codepoint_t as ulong
Declare Sub plutovg_text_iterator_init(ByVal it As plutovg_text_iterator_t Ptr, ByVal text As Const Any Ptr, ByVal length As Long, ByVal encoding_ As plutovg_text_encoding_t)
declare function plutovg_text_iterator_has_next(byval it as const plutovg_text_iterator_t ptr) as bool
declare function plutovg_text_iterator_next(byval it as plutovg_text_iterator_t ptr) as plutovg_codepoint_t
type plutovg_font_face_t as plutovg_font_face
declare function plutovg_font_face_load_from_file(byval filename as const zstring ptr, byval ttcindex as long) as plutovg_font_face_t ptr
Declare Function plutovg_font_face_load_from_data(ByVal data_ As Const Any Ptr, ByVal length As ULong, ByVal ttcindex As Long, ByVal destroy_func As plutovg_destroy_func_t, ByVal closure As Any Ptr) As plutovg_font_face_t Ptr
declare function plutovg_font_face_reference(byval face as plutovg_font_face_t ptr) as plutovg_font_face_t ptr
Declare Sub plutovg_font_face_destroy(ByVal face As plutovg_font_face_t Ptr)
declare function plutovg_font_face_get_reference_count(byval face as const plutovg_font_face_t ptr) as long
declare sub plutovg_font_face_get_metrics(byval face as const plutovg_font_face_t ptr, byval size as single, byval ascent as single ptr, byval descent as single ptr, byval line_gap as single ptr, byval extents as plutovg_rect_t ptr)
declare sub plutovg_font_face_get_glyph_metrics(byval face as plutovg_font_face_t ptr, byval size as single, byval codepoint as plutovg_codepoint_t, byval advance_width as single ptr, byval left_side_bearing as single ptr, byval extents as plutovg_rect_t ptr)
declare function plutovg_font_face_get_glyph_path(byval face as plutovg_font_face_t ptr, byval size as single, byval x as single, byval y as single, byval codepoint as plutovg_codepoint_t, byval path as plutovg_path_t ptr) as single
declare function plutovg_font_face_traverse_glyph_path(byval face as plutovg_font_face_t ptr, byval size as single, byval x as single, byval y as single, byval codepoint as plutovg_codepoint_t, byval traverse_func as plutovg_path_traverse_func_t, byval closure as any ptr) as single
Declare Function plutovg_font_face_text_extents(ByVal face As plutovg_font_face_t Ptr, ByVal SIZE As Single, ByVal text As Const Any Ptr, ByVal length As Long, ByVal encoding_ As plutovg_text_encoding_t, ByVal extents As plutovg_rect_t Ptr) As Single

type plutovg_color
   r as single
   g as single
   b as single
   a as single
end type

type plutovg_color_t as plutovg_color


Declare Sub plutovg_color_init_rgb(ByVal color_ As plutovg_color_t Ptr, ByVal r As Single, ByVal g As Single, ByVal b As Single)
Declare Sub plutovg_color_init_rgba(ByVal color_ As plutovg_color_t Ptr, ByVal r As Single, ByVal g As Single, ByVal b As Single, ByVal a As Single)
Declare Sub plutovg_color_init_rgb8(ByVal color_ As plutovg_color_t Ptr, ByVal r As Long, ByVal g As Long, ByVal b As Long)
Declare Sub plutovg_color_init_rgba8(ByVal color_ As plutovg_color_t Ptr, ByVal r As Long, ByVal g As Long, ByVal b As Long, ByVal a As Long)
Declare Sub plutovg_color_init_rgba32(ByVal color_ As plutovg_color_t Ptr, ByVal value As ULong)
Declare Sub plutovg_color_init_argb32(ByVal color_ As plutovg_color_t Ptr, ByVal value As ULong)
Declare Function plutovg_color_to_rgba32(ByVal color_ As Const plutovg_color_t Ptr) As ULong
Declare Function plutovg_color_to_argb32(ByVal color_ As Const plutovg_color_t Ptr) As ULong
Declare Function plutovg_color_parse(ByVal color_ As plutovg_color_t Ptr, ByVal Data_ As Const ZString Ptr, ByVal length As Long) As Long
Type plutovg_surface_t As plutovg_surface
Declare Function plutovg_surface_create(ByVal width_ As Long, ByVal height As Long) As plutovg_surface_t Ptr
Declare Function plutovg_surface_create_for_data(ByVal data_ As UByte Ptr, ByVal width_ As Long, ByVal height As Long, ByVal stride As Long) As plutovg_surface_t Ptr
declare function plutovg_surface_load_from_image_file(byval filename as const zstring ptr) as plutovg_surface_t ptr
Declare Function plutovg_surface_load_from_image_data(ByVal data_ As Const Any Ptr, ByVal length As Long) As plutovg_surface_t Ptr
Declare Function plutovg_surface_load_from_image_base64(ByVal data_ As Const ZString Ptr, ByVal length As Long) As plutovg_surface_t Ptr
declare function plutovg_surface_reference(byval surface as plutovg_surface_t ptr) as plutovg_surface_t ptr
Declare Sub plutovg_surface_destroy(ByVal surface As plutovg_surface_t Ptr)
declare function plutovg_surface_get_reference_count(byval surface as const plutovg_surface_t ptr) as long
declare function plutovg_surface_get_data(byval surface as const plutovg_surface_t ptr) as ubyte ptr
declare function plutovg_surface_get_width(byval surface as const plutovg_surface_t ptr) as long
Declare Function plutovg_surface_get_height(ByVal surface As Const plutovg_surface_t Ptr) As Long
declare function plutovg_surface_get_stride(byval surface as const plutovg_surface_t ptr) as long
Declare Sub plutovg_surface_clear(ByVal surface As plutovg_surface_t Ptr, ByVal color_ As Const plutovg_color_t Ptr)
declare function plutovg_surface_write_to_png(byval surface as const plutovg_surface_t ptr, byval filename as const zstring ptr) as bool
declare function plutovg_surface_write_to_jpg(byval surface as const plutovg_surface_t ptr, byval filename as const zstring ptr, byval quality as long) as bool
declare function plutovg_surface_write_to_png_stream(byval surface as const plutovg_surface_t ptr, byval write_func as plutovg_write_func_t, byval closure as any ptr) as bool
declare function plutovg_surface_write_to_jpg_stream(byval surface as const plutovg_surface_t ptr, byval write_func as plutovg_write_func_t, byval closure as any ptr, byval quality as long) as bool
Declare Sub plutovg_convert_argb_to_rgba(ByVal dst As UByte Ptr, ByVal src As Const UByte Ptr, ByVal width_ As Long, ByVal height As Long, ByVal stride As Long)
Declare Sub plutovg_convert_rgba_to_argb(ByVal dst As UByte Ptr, ByVal src As Const UByte Ptr, ByVal width_ As Long, ByVal height As Long, ByVal stride As Long)

type plutovg_texture_type_t as long
enum
   PLUTOVG_TEXTURE_TYPE_PLAIN
   PLUTOVG_TEXTURE_TYPE_TILED
end enum

type plutovg_spread_method_t as long
enum
   PLUTOVG_SPREAD_METHOD_PAD
   PLUTOVG_SPREAD_METHOD_REFLECT
   PLUTOVG_SPREAD_METHOD_REPEAT
end enum

type plutovg_gradient_stop_t
   offset as single
   _color As plutovg_color_t
End Type

type plutovg_paint_t as plutovg_paint
declare function plutovg_paint_create_rgb(byval r as single, byval g as single, byval b as single) as plutovg_paint_t ptr
declare function plutovg_paint_create_rgba(byval r as single, byval g as single, byval b as single, byval a as single) as plutovg_paint_t ptr
declare function plutovg_paint_create_color(byval color as const plutovg_color_t ptr) as plutovg_paint_t ptr
declare function plutovg_paint_create_linear_gradient(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval spread as plutovg_spread_method_t, byval stops as const plutovg_gradient_stop_t ptr, byval nstops as long, byval matrix as const plutovg_matrix_t ptr) as plutovg_paint_t ptr
declare function plutovg_paint_create_radial_gradient(byval cx as single, byval cy as single, byval cr as single, byval fx as single, byval fy as single, byval fr as single, byval spread as plutovg_spread_method_t, byval stops as const plutovg_gradient_stop_t ptr, byval nstops as long, byval matrix as const plutovg_matrix_t ptr) as plutovg_paint_t ptr
Declare Function plutovg_paint_create_texture(ByVal surface As plutovg_surface_t Ptr, ByVal type_ As plutovg_texture_type_t, ByVal opacity As Single, ByVal matrix As Const plutovg_matrix_t Ptr) As plutovg_paint_t Ptr
Declare Function plutovg_paint_reference(ByVal Paint As plutovg_paint_t Ptr) As plutovg_paint_t Ptr
Declare Sub plutovg_paint_destroy(ByVal Paint As plutovg_paint_t Ptr)
declare function plutovg_paint_get_reference_count(byval paint_ as const plutovg_paint_t ptr) as long

type plutovg_fill_rule_t as long
enum
   PLUTOVG_FILL_RULE_NON_ZERO
   PLUTOVG_FILL_RULE_EVEN_ODD
end enum

type plutovg_operator_t as long
enum
   PLUTOVG_OPERATOR_CLEAR
   PLUTOVG_OPERATOR_SRC
   PLUTOVG_OPERATOR_DST
   PLUTOVG_OPERATOR_SRC_OVER
   PLUTOVG_OPERATOR_DST_OVER
   PLUTOVG_OPERATOR_SRC_IN
   PLUTOVG_OPERATOR_DST_IN
   PLUTOVG_OPERATOR_SRC_OUT
   PLUTOVG_OPERATOR_DST_OUT
   PLUTOVG_OPERATOR_SRC_ATOP
   PLUTOVG_OPERATOR_DST_ATOP
   PLUTOVG_OPERATOR_XOR
end enum

type plutovg_line_cap_t as long
enum
   PLUTOVG_LINE_CAP_BUTT
   PLUTOVG_LINE_CAP_ROUND
   PLUTOVG_LINE_CAP_SQUARE
end enum

type plutovg_line_join_t as long
enum
   PLUTOVG_LINE_JOIN_MITER
   PLUTOVG_LINE_JOIN_ROUND
   PLUTOVG_LINE_JOIN_BEVEL
end enum

type plutovg_canvas_t as plutovg_canvas
declare function plutovg_canvas_create(byval surface as plutovg_surface_t ptr) as plutovg_canvas_t ptr
declare function plutovg_canvas_reference(byval canvas as plutovg_canvas_t ptr) as plutovg_canvas_t ptr
declare sub plutovg_canvas_destroy(byval canvas as plutovg_canvas_t ptr)
declare function plutovg_canvas_get_reference_count(byval canvas as const plutovg_canvas_t ptr) as long
declare function plutovg_canvas_get_surface(byval canvas as const plutovg_canvas_t ptr) as plutovg_surface_t ptr
Declare Sub plutovg_canvas_save(ByVal canvas As plutovg_canvas_t Ptr)
declare sub plutovg_canvas_restore(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_set_rgb(byval canvas as plutovg_canvas_t ptr, byval r as single, byval g as single, byval b as single)
Declare Sub plutovg_canvas_set_rgba(ByVal canvas As plutovg_canvas_t Ptr, ByVal r As Single, ByVal g As Single, ByVal b As Single, ByVal a As Single)
Declare Sub plutovg_canvas_set_color(ByVal canvas As plutovg_canvas_t Ptr, ByVal color_ As Const plutovg_color_t Ptr)
declare sub plutovg_canvas_set_linear_gradient(byval canvas as plutovg_canvas_t ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval spread as plutovg_spread_method_t, byval stops as const plutovg_gradient_stop_t ptr, byval nstops as long, byval matrix as const plutovg_matrix_t ptr)
declare sub plutovg_canvas_set_radial_gradient(byval canvas as plutovg_canvas_t ptr, byval cx as single, byval cy as single, byval cr as single, byval fx as single, byval fy as single, byval fr as single, byval spread as plutovg_spread_method_t, byval stops as const plutovg_gradient_stop_t ptr, byval nstops as long, byval matrix as const plutovg_matrix_t ptr)
Declare Sub plutovg_canvas_set_texture(ByVal canvas As plutovg_canvas_t Ptr, ByVal surface As plutovg_surface_t Ptr, ByVal type_ As plutovg_texture_type_t, ByVal opacity As Single, ByVal matrix As Const plutovg_matrix_t Ptr)
declare sub plutovg_canvas_set_paint(byval canvas as plutovg_canvas_t ptr, byval paint as plutovg_paint_t ptr)
Declare Function plutovg_canvas_get_paint(ByVal canvas As Const plutovg_canvas_t Ptr, ByVal Color As plutovg_color_t Ptr) As plutovg_paint_t Ptr
declare sub plutovg_canvas_set_font(byval canvas as plutovg_canvas_t ptr, byval face as plutovg_font_face_t ptr, byval size as single)
declare sub plutovg_canvas_set_font_face(byval canvas as plutovg_canvas_t ptr, byval face as plutovg_font_face_t ptr)
declare function plutovg_canvas_get_font_face(byval canvas as const plutovg_canvas_t ptr) as plutovg_font_face_t ptr
declare sub plutovg_canvas_set_font_size(byval canvas as plutovg_canvas_t ptr, byval size as single)
declare function plutovg_canvas_get_font_size(byval canvas as const plutovg_canvas_t ptr) as single
declare sub plutovg_canvas_set_fill_rule(byval canvas as plutovg_canvas_t ptr, byval winding as plutovg_fill_rule_t)
declare function plutovg_canvas_get_fill_rule(byval canvas as const plutovg_canvas_t ptr) as plutovg_fill_rule_t
declare sub plutovg_canvas_set_operator(byval canvas as plutovg_canvas_t ptr, byval op as plutovg_operator_t)
declare function plutovg_canvas_get_operator(byval canvas as const plutovg_canvas_t ptr) as plutovg_operator_t
declare sub plutovg_canvas_set_opacity(byval canvas as plutovg_canvas_t ptr, byval opacity as single)
declare function plutovg_canvas_get_opacity(byval canvas as const plutovg_canvas_t ptr) as single
declare sub plutovg_canvas_set_line_width(byval canvas as plutovg_canvas_t ptr, byval line_width as single)
declare function plutovg_canvas_get_line_width(byval canvas as const plutovg_canvas_t ptr) as single
declare sub plutovg_canvas_set_line_cap(byval canvas as plutovg_canvas_t ptr, byval line_cap as plutovg_line_cap_t)
declare function plutovg_canvas_get_line_cap(byval canvas as const plutovg_canvas_t ptr) as plutovg_line_cap_t
declare sub plutovg_canvas_set_line_join(byval canvas as plutovg_canvas_t ptr, byval line_join as plutovg_line_join_t)
declare function plutovg_canvas_get_line_join(byval canvas as const plutovg_canvas_t ptr) as plutovg_line_join_t
declare sub plutovg_canvas_set_miter_limit(byval canvas as plutovg_canvas_t ptr, byval miter_limit as single)
declare function plutovg_canvas_get_miter_limit(byval canvas as const plutovg_canvas_t ptr) as single
declare sub plutovg_canvas_set_dash(byval canvas as plutovg_canvas_t ptr, byval offset as single, byval dashes as const single ptr, byval ndashes as long)
declare sub plutovg_canvas_set_dash_offset(byval canvas as plutovg_canvas_t ptr, byval offset as single)
declare function plutovg_canvas_get_dash_offset(byval canvas as const plutovg_canvas_t ptr) as single
declare sub plutovg_canvas_set_dash_array(byval canvas as plutovg_canvas_t ptr, byval dashes as const single ptr, byval ndashes as long)
declare function plutovg_canvas_get_dash_array(byval canvas as const plutovg_canvas_t ptr, byval dashes as const single ptr ptr) as long
declare sub plutovg_canvas_translate(byval canvas as plutovg_canvas_t ptr, byval tx as single, byval ty as single)
declare sub plutovg_canvas_scale(byval canvas as plutovg_canvas_t ptr, byval sx as single, byval sy as single)
declare sub plutovg_canvas_shear(byval canvas as plutovg_canvas_t ptr, byval shx as single, byval shy as single)
declare sub plutovg_canvas_rotate(byval canvas as plutovg_canvas_t ptr, byval angle as single)
declare sub plutovg_canvas_transform(byval canvas as plutovg_canvas_t ptr, byval matrix as const plutovg_matrix_t ptr)
declare sub plutovg_canvas_reset_matrix(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_set_matrix(byval canvas as plutovg_canvas_t ptr, byval matrix as const plutovg_matrix_t ptr)
declare sub plutovg_canvas_get_matrix(byval canvas as const plutovg_canvas_t ptr, byval matrix as plutovg_matrix_t ptr)
declare sub plutovg_canvas_map(byval canvas as const plutovg_canvas_t ptr, byval x as single, byval y as single, byval xx as single ptr, byval yy as single ptr)
declare sub plutovg_canvas_map_point(byval canvas as const plutovg_canvas_t ptr, byval src as const plutovg_point_t ptr, byval dst as plutovg_point_t ptr)
declare sub plutovg_canvas_map_rect(byval canvas as const plutovg_canvas_t ptr, byval src as const plutovg_rect_t ptr, byval dst as plutovg_rect_t ptr)
declare sub plutovg_canvas_move_to(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single)
declare sub plutovg_canvas_line_to(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single)
declare sub plutovg_canvas_quad_to(byval canvas as plutovg_canvas_t ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single)
declare sub plutovg_canvas_cubic_to(byval canvas as plutovg_canvas_t ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval x3 as single, byval y3 as single)
declare sub plutovg_canvas_arc_to(byval canvas as plutovg_canvas_t ptr, byval rx as single, byval ry as single, byval angle as single, byval large_arc_flag as bool, byval sweep_flag as bool, byval x as single, byval y as single)
declare sub plutovg_canvas_rect(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single, byval w as single, byval h as single)
declare sub plutovg_canvas_round_rect(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single, byval w as single, byval h as single, byval rx as single, byval ry as single)
declare sub plutovg_canvas_ellipse(byval canvas as plutovg_canvas_t ptr, byval cx as single, byval cy as single, byval rx as single, byval ry as single)
declare sub plutovg_canvas_circle(byval canvas as plutovg_canvas_t ptr, byval cx as single, byval cy as single, byval r as single)
declare sub plutovg_canvas_arc(byval canvas as plutovg_canvas_t ptr, byval cx as single, byval cy as single, byval r as single, byval a0 as single, byval a1 as single, byval ccw as bool)
declare sub plutovg_canvas_add_path(byval canvas as plutovg_canvas_t ptr, byval path as const plutovg_path_t ptr)
declare sub plutovg_canvas_new_path(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_close_path(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_get_current_point(byval canvas as const plutovg_canvas_t ptr, byval x as single ptr, byval y as single ptr)
declare function plutovg_canvas_get_path(byval canvas as const plutovg_canvas_t ptr) as plutovg_path_t ptr
declare sub plutovg_canvas_fill_extents(byval canvas as const plutovg_canvas_t ptr, byval extents as plutovg_rect_t ptr)
declare sub plutovg_canvas_stroke_extents(byval canvas as const plutovg_canvas_t ptr, byval extents as plutovg_rect_t ptr)
declare sub plutovg_canvas_clip_extents(byval canvas as const plutovg_canvas_t ptr, byval extents as plutovg_rect_t ptr)
declare sub plutovg_canvas_fill(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_stroke(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_clip(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_paint(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_fill_preserve(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_stroke_preserve(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_clip_preserve(byval canvas as plutovg_canvas_t ptr)
declare sub plutovg_canvas_fill_rect(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single, byval w as single, byval h as single)
declare sub plutovg_canvas_fill_path(byval canvas as plutovg_canvas_t ptr, byval path as const plutovg_path_t ptr)
declare sub plutovg_canvas_stroke_rect(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single, byval w as single, byval h as single)
declare sub plutovg_canvas_stroke_path(byval canvas as plutovg_canvas_t ptr, byval path as const plutovg_path_t ptr)
declare sub plutovg_canvas_clip_rect(byval canvas as plutovg_canvas_t ptr, byval x as single, byval y as single, byval w as single, byval h as single)
declare sub plutovg_canvas_clip_path(byval canvas as plutovg_canvas_t ptr, byval path as const plutovg_path_t ptr)
declare function plutovg_canvas_add_glyph(byval canvas as plutovg_canvas_t ptr, byval codepoint as plutovg_codepoint_t, byval x as single, byval y as single) as single
Declare Function plutovg_canvas_add_text(ByVal canvas As plutovg_canvas_t Ptr, ByVal text As Const Any Ptr, ByVal length As Long, ByVal encoding_ As plutovg_text_encoding_t, ByVal x As Single, ByVal y As Single) As Single
Declare Function plutovg_canvas_fill_text(ByVal canvas As plutovg_canvas_t Ptr, ByVal text As Const Any Ptr, ByVal length As Long, ByVal encoding_ As plutovg_text_encoding_t, ByVal x As Single, ByVal y As Single) As Single
Declare Function plutovg_canvas_stroke_text(ByVal canvas As plutovg_canvas_t Ptr, ByVal text As Const Any Ptr, ByVal length As Long, ByVal encoding_ As plutovg_text_encoding_t, ByVal x As Single, ByVal y As Single) As Single
Declare Function plutovg_canvas_clip_text(ByVal canvas As plutovg_canvas_t Ptr, ByVal text As Const Any Ptr, ByVal length As Long, ByVal encoding_ As plutovg_text_encoding_t, ByVal x As Single, ByVal y As Single) As Single
declare sub plutovg_canvas_font_metrics(byval canvas as const plutovg_canvas_t ptr, byval ascent as single ptr, byval descent as single ptr, byval line_gap as single ptr, byval extents as plutovg_rect_t ptr)
declare sub plutovg_canvas_glyph_metrics(byval canvas as plutovg_canvas_t ptr, byval codepoint as plutovg_codepoint_t, byval advance_width as single ptr, byval left_side_bearing as single ptr, byval extents as plutovg_rect_t ptr)
declare function plutovg_canvas_text_extents(byval canvas as plutovg_canvas_t ptr, byval text as const any ptr, byval length as long, byval encoding_ as plutovg_text_encoding_t, byval extents as plutovg_rect_t ptr) as single

end extern
#endif

#include once "plutovg.bi"

' draw vector graphic on FBGFX Image

const as double pi = 3.14159265358979323846

const as long iWidth  = 150
const as long iHeight = 150

Dim As Double center_x = iWidth * 0.5
dim as double center_y = iHeight * 0.5
dim as double face_radius = 70
Dim As Double eye_radius = 10
dim as double mouth_radius = 50
dim as double eye_offset_x = 25
dim as double eye_offset_y = 20
dim as double eye_x = center_x - eye_offset_x
dim as double eye_y = center_y - eye_offset_y


screenres iWidth,iHeight,32
line (0,0)-(iWidth,iHeight),RGBA(255,255,255,255),BF

Dim As Any Ptr img = ImageCreate(iWidth,iHeight,RGBA(0,0,0,0))
Dim As UByte Ptr imgPixels
Dim As Long imgWidth,imgHeight,imgBytes,imgPitch
ImageInfo(img,imgWidth,imgHeight,imgBytes,imgPitch,imgPixels)

var surface = plutovg_surface_create_for_data(imgPixels,imgWidth,imgHeight,imgPitch)
var pluto = plutovg_canvas_create(surface)

plutovg_canvas_save(pluto)
  plutovg_canvas_arc(pluto, center_x, center_y, face_radius, 0, 2 * pi, 0)
  plutovg_canvas_set_rgb(pluto, 1, 1, 0)
  plutovg_canvas_fill_preserve(pluto)
  plutovg_canvas_set_rgb(pluto, 0, 0, 0)
  plutovg_canvas_set_line_width(pluto, 5)
  plutovg_canvas_stroke(pluto)
   plutovg_canvas_restore(pluto)

plutovg_canvas_save(pluto)
  plutovg_canvas_arc(pluto, eye_x, eye_y, eye_radius, 0, 2 * pi, 0)
  plutovg_canvas_arc(pluto, center_x + eye_offset_x, eye_y, eye_radius, 0, 2 * pi, 0)
  plutovg_canvas_fill(pluto)
   plutovg_canvas_restore(pluto)

plutovg_canvas_save(pluto)
  plutovg_canvas_arc(pluto, center_x, center_y, mouth_radius, 0, pi, 0)
  plutovg_canvas_set_line_width(pluto, 5)
  plutovg_canvas_stroke(pluto)
plutovg_canvas_restore(pluto)

put (0,0),img,ALPHA
sleep
'plutovg_surface_write_to_png(surface, "smiley.png")
plutovg_surface_destroy(surface)
plutovg_canvas_destroy(pluto)
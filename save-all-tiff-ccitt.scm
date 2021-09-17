; This is a script (Script-Fu) for GIMP (GNU Image Manipulation Program)
; to convert all opened files into black and white mode,
; and save them as TIFF CCITT (Group 4) format.
; Copy this file to "/usr/share/gimp/2.0/scripts"
; or "/usr/local/share/gimp/scripts" etc.
; Open a PDF file as separate images in GIMP, and select the pull-down menu
; "Script-Fu" - "Save all files as TIFF CCITT".
;
; This script is written based on
; "save_all_images.scm" by Saul Goode and  
; "script-fu-save-all-images.scm" by Lauchlin Wilkinson.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This program is free software
; you can redistribute it and/or modify
; it under the terms of the GNU General Public
; License as published by
; the Free Software Foundation
; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

(define (save-all-tiff-ccitt inDir inSaveType 
inFileName inFileNumber) 
  (let* (
          (i (car (gimp-image-list)))
          (ii (car (gimp-image-list))) 
          (image)
          (newFileName "")
          (saveString "")
          (pathchar (if (equal? 
                 (substring gimp-dir 0 1) "/") "/" "\\"))
        )
    (set! saveString
      (cond 
        (( equal? inSaveType 0 ) ".tif" )
;        (( equal? inSaveType 1 ) ".bmp" )
;        (( equal? inSaveType 2 ) ".png" )
;        (( equal? inSaveType 3 ) ".jpg" )
      )
    ) 
    (while (> i 0) 
      (set! image (vector-ref (cadr (gimp-image-list)) (- i 1)))
      (set! newFileName (string-append inDir
              pathchar inFileName 
              (substring "000" (string-length
              (number->string (+ inFileNumber i))))
              (number->string (+ inFileNumber i)) saveString))

	  (gimp-image-flatten image)
	  (gimp-convert-indexed image 0 3 0 FALSE FALSE "")
  
(file-tiff-save 
    1; Runmode, RUN-NONINTERACTIVE (1) -> if you select 0, you can selecet compression types, but you cannot name the file.
    image; Imput image
	(car (gimp-image-get-active-layer image)); Drawable to save
	newFileName; the name of the file to save the image
	newFileName; the name of the file to save the image, raw-filename
	6
  )
	  
      (gimp-image-clean-all image) 
      (set! i (- i 1))
    )
  )
) 

(script-fu-register "save-all-tiff-ccitt" 
 "<Image>/Script-Fu/Save all files as TIFF CCITT" 
 "Save all opened images as TIFF CCITT" 
 "Takaaki Nihei (& Lauchlin Wilkinson, & Saul Goode)" 
 "Takaaki Nihei (& Lauchlin Wilkinson, & Saul Goode)" 
 "191119 (modified 210824)" 
 ""
 SF-DIRNAME    "Save Directory" ""
 SF-OPTION     "Save File Type" (list "tif")
; SF-OPTION     "Save File Type" (list "tif" "bmp" "png" "jpg")
 SF-STRING     "Save File Base Name" "" ; original is "IMAGE"
 SF-ADJUSTMENT "Save File Start Number" 
      (list 0 0 9000 1 100 0 SF-SPINNER)
 )

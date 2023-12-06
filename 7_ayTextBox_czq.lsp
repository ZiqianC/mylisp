;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����6����дLISP����ayTextBox
;;; �����ˣ�����ǫ

(defun c:ayTextBox ()
  
  (setq obj-type nil)
  (setq border-type nil)
  (setq offset nil)

  ; ��ʾѡ������
  (initget "Mtext Text All")
  (setq obj-type (getkword "\nѡ���ı����� �����ı�(Mtext)/�����ı�(Text)/����<All>: "))
  (if (= obj-type nil)
    (setq obj-type "All")
  )
  ; ����ѡ������ͣ�ѡ���Ӧͼ�ζ���
  (if (equal obj-type "Mtext")
    (setq objs (ssget '((0 . "MTEXT"))))
  )
  (if (equal obj-type "Text")
    (setq objs (ssget '((0 . "TEXT"))))
  )
  (if (equal obj-type "All")
    (setq objs (ssget '((0 . "MTEXT,TEXT"))))
  )
  ; ��ʾѡ��߿�����
  (initget "Circle Rectangle")
  (setq border-type (getkword "\nѡ��߿����� Բ��(C)/����(R)<R>: "))
  (if (= border-type nil)
    (setq border-type "Rectangle")
  )

  (princ border-type)
  ;��ʾ����߿�ƫ�ƾ���
  (setq offset (getreal "\n�����ı�����߿�ƫ�ƾ���<0>: "))
  (if (= offset nil)
    (setq offset 0.0)
  )

  (if objs
    (progn
      (setq cnt 0)
      
      ; ������ѡ�е��ı�����objs
      (while (< cnt (sslength objs))
        (setq ent (ssname objs cnt)) 
        (setq cnt (1+ cnt))
        (setq ent-data (entget ent))

        ; ���TEXT�����ı�
        (if (= (cdr (assoc 0 ent-data)) "TEXT")
          (progn
            ; ��ȡ���������
            (setq text-position (cdr (assoc 10 ent-data)))
            ; ��ȡ��ת�Ƕ�
            (setq text-rotation (cdr (assoc 50 ent-data)))
            ; ʹ��textbox������ȡ�����ı����ַ�Χ���εĶԽǵ�
            (setq text-box (textbox ent-data))
            (setq text-1 (nth 0 text-box))
            (setq text-2 (nth 1 text-box))
            (setq text-1x (+ (nth 0 text-1) (nth 0 text-position)))
            (setq text-1y (+ (nth 1 text-1) (nth 1 text-position)))
            (setq text-2x (+ (nth 0 text-2) (nth 0 text-position)))
            (setq text-2y (+ (nth 1 text-2) (nth 1 text-position)))
            ; ���㵥���ı����ַ�Χ�Ŀ����߶�
            (setq text-w (- (nth 0 text-2) (nth 0 text-1)))
            (setq text-h (- (nth 1 text-2) (nth 1 text-1)))
            ; �����ı���Χ��������
            (setq text-cx (+ (nth 0 text-position) (nth 0 text-1) (* text-w 0.5)))
            (setq text-cy (+ (nth 1 text-position) (nth 1 text-1) (* text-h 0.5)))
            ; �������ƫ�ƾ���ı߿򶥵�����
            (setq text-bor-1x (- text-1x offset))
            (setq text-bor-1y (- text-1y offset))
            (setq text-bor-2x (+ text-2x offset))
            (setq text-bor-2y (- text-1y offset))
            (setq text-bor-3x (+ text-2x offset))
            (setq text-bor-3y (+ text-2y offset))
            (setq text-bor-4x (- text-1x offset))
            (setq text-bor-4y (+ text-2y offset))
            ; ����ϵ��ת
            (setq text-bor-1xnew (+ (- (* (- text-bor-1x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-1y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-1ynew (+ (+ (* (- text-bor-1x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-1y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-bor-2xnew (+ (- (* (- text-bor-2x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-2y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-2ynew (+ (+ (* (- text-bor-2x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-2y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-bor-3xnew (+ (- (* (- text-bor-3x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-3y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-3ynew (+ (+ (* (- text-bor-3x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-3y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-bor-4xnew (+ (- (* (- text-bor-4x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-4y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-4ynew (+ (+ (* (- text-bor-4x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-4y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-cxnew (+ (- (* (- text-cx (nth 0 text-position)) (cos text-rotation)) (* (- text-cy (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-cynew (+ (+ (* (- text-cx (nth 0 text-position)) (sin text-rotation)) (* (- text-cy (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))

            (setq text-bor-1new (list text-bor-1xnew text-bor-1ynew 0.0))
            (setq text-bor-2new (list text-bor-2xnew text-bor-2ynew 0.0))
            (setq text-bor-3new (list text-bor-3xnew text-bor-3ynew 0.0))
            (setq text-bor-4new (list text-bor-4xnew text-bor-4ynew 0.0))
            (setq text-c (list text-cxnew text-cynew 0.0))
            
            ; �����ı���Χ��С�뾶
            (setq text-r (sqrt (+ (expt (- text-cx text-1x) 2) (expt (- text-cy text-1y) 2))))
            
            ; ���ɾ��α߿�
            (if (equal border-type "Rectangle")
              (entmake (list 
                        '(0 . "LWPOLYLINE") 
                        '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline")
                        (cons 70 1)
                        (cons 10 text-bor-1new)
                        (cons 10 text-bor-2new)
                        (cons 10 text-bor-3new)
                        (cons 10 text-bor-4new)
                        (cons 10 text-bor-1new)
                       )
              )
            )
            ; ����Բ�α߿�
            (if (equal border-type "Circle")
              (entmake (list
                        '(0 . "CIRCLE")
                        (cons 10 text-c)
                        (cons 40 (+ text-r offset))
                        )
              )
            )
          )
        )

        ; ���MTEXT�����ı�
        (if (= (cdr (assoc 0 ent-data)) "MTEXT")
          (progn
            ; ��ȡ���������
            (setq text-position (cdr (assoc 10 ent-data)))
            ; ��ȡ��ת�Ƕ�
            (setq text-rotation (cdr (assoc 50 ent-data)))
            ; ��ȡ�����ı����ַ�Χ�Ŀ�ȼ��߶�
            (setq text-w (cdr (assoc 42 ent-data)))
            (setq text-h (cdr (assoc 43 ent-data)))
            ; ��������ı����ַ�Χ���ζ�������
            (setq text-1x (nth 0 text-position))
            (setq text-1y (nth 1 text-position))
            (setq text-2x (nth 0 text-position))
            (setq text-2y (- (nth 1 text-position) text-h))
            (setq text-3x (+ (nth 0 text-position) text-w))
            (setq text-3y (- (nth 1 text-position) text-h))
            (setq text-4x (+ (nth 0 text-position) text-w))
            (setq text-4y (nth 1 text-position))
            ; �������ƫ�ƾ���ı߿򶥵�����
            (setq text-bor-1x (- text-1x offset))
            (setq text-bor-1y (+ text-1y offset))
            (setq text-bor-2x (- text-2x offset))
            (setq text-bor-2y (- text-2y offset))
            (setq text-bor-3x (+ text-3x offset))
            (setq text-bor-3y (- text-3y offset))
            (setq text-bor-4x (+ text-4x offset))
            (setq text-bor-4y (+ text-4y offset))
            ; �����ı���Χ��������
            (setq text-cx (+ (nth 0 text-position) (* text-w 0.5)))
            (setq text-cy (- (nth 1 text-position) (* text-h 0.5)))
            ; ����ϵ��ת
            (setq text-bor-1xnew (+ (- (* (- text-bor-1x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-1y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-1ynew (+ (+ (* (- text-bor-1x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-1y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-bor-2xnew (+ (- (* (- text-bor-2x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-2y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-2ynew (+ (+ (* (- text-bor-2x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-2y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-bor-3xnew (+ (- (* (- text-bor-3x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-3y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-3ynew (+ (+ (* (- text-bor-3x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-3y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-bor-4xnew (+ (- (* (- text-bor-4x (nth 0 text-position)) (cos text-rotation)) (* (- text-bor-4y (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-bor-4ynew (+ (+ (* (- text-bor-4x (nth 0 text-position)) (sin text-rotation)) (* (- text-bor-4y (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))
            (setq text-cxnew (+ (- (* (- text-cx (nth 0 text-position)) (cos text-rotation)) (* (- text-cy (nth 1 text-position)) (sin text-rotation))) (nth 0 text-position)))
            (setq text-cynew (+ (+ (* (- text-cx (nth 0 text-position)) (sin text-rotation)) (* (- text-cy (nth 1 text-position)) (cos text-rotation))) (nth 1 text-position)))

            (setq text-bor-1new (list text-bor-1xnew text-bor-1ynew 0.0))
            (setq text-bor-2new (list text-bor-2xnew text-bor-2ynew 0.0))
            (setq text-bor-3new (list text-bor-3xnew text-bor-3ynew 0.0))
            (setq text-bor-4new (list text-bor-4xnew text-bor-4ynew 0.0))
            (setq text-c (list text-cxnew text-cynew 0.0))

            ; �����ı���Χ��С�뾶
            (setq text-r (sqrt (+ (expt (- text-cx text-1x) 2) (expt (- text-cy text-1y) 2))))

            ; ���ɾ��α߿�
            (if (equal border-type "Rectangle")
              (entmake (list 
                        '(0 . "LWPOLYLINE") 
                        '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline")
                        (cons 70 1)
                        (cons 10 text-bor-1new)
                        (cons 10 text-bor-2new)
                        (cons 10 text-bor-3new)
                        (cons 10 text-bor-4new)
                        (cons 10 text-bor-1new)
                       )
              )
            )
            ; ����Բ�α߿�
            (if (equal border-type "Circle")
              (entmake (list
                        '(0 . "CIRCLE")
                        (cons 10 text-c)
                        (cons 40 (+ text-r offset))
                        )
              )
            )
          )
        )        
      )
    )
  )
  ; ��Ĭ�˳�
  (princ)
)

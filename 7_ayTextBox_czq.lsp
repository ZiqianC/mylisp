;;; ZWCAD产品二次开发实训--LISP
;;; 任务6：编写LISP命令ayTextBox
;;; 创建人：陈子谦

(defun c:ayTextBox ()
  
  (setq obj-type nil)
  (setq border-type nil)
  (setq offset nil)

  ; 提示选择类型
  (initget "Mtext Text All")
  (setq obj-type (getkword "\n选择文本类型 多行文本(Mtext)/单行文本(Text)/任意<All>: "))
  (if (= obj-type nil)
    (setq obj-type "All")
  )
  ; 根据选择的类型，选择对应图形对象
  (if (equal obj-type "Mtext")
    (setq objs (ssget '((0 . "MTEXT"))))
  )
  (if (equal obj-type "Text")
    (setq objs (ssget '((0 . "TEXT"))))
  )
  (if (equal obj-type "All")
    (setq objs (ssget '((0 . "MTEXT,TEXT"))))
  )
  ; 提示选择边框类型
  (initget "Circle Rectangle")
  (setq border-type (getkword "\n选择边框类型 圆形(C)/矩形(R)<R>: "))
  (if (= border-type nil)
    (setq border-type "Rectangle")
  )

  (princ border-type)
  ;提示输入边框偏移距离
  (setq offset (getreal "\n设置文本距离边框偏移距离<0>: "))
  (if (= offset nil)
    (setq offset 0.0)
  )

  (if objs
    (progn
      (setq cnt 0)
      
      ; 遍历被选中的文本对象objs
      (while (< cnt (sslength objs))
        (setq ent (ssname objs cnt)) 
        (setq cnt (1+ cnt))
        (setq ent-data (entget ent))

        ; 针对TEXT单行文本
        (if (= (cdr (assoc 0 ent-data)) "TEXT")
          (progn
            ; 获取插入点坐标
            (setq text-position (cdr (assoc 10 ent-data)))
            ; 获取旋转角度
            (setq text-rotation (cdr (assoc 50 ent-data)))
            ; 使用textbox函数获取单行文本文字范围矩形的对角点
            (setq text-box (textbox ent-data))
            (setq text-1 (nth 0 text-box))
            (setq text-2 (nth 1 text-box))
            (setq text-1x (+ (nth 0 text-1) (nth 0 text-position)))
            (setq text-1y (+ (nth 1 text-1) (nth 1 text-position)))
            (setq text-2x (+ (nth 0 text-2) (nth 0 text-position)))
            (setq text-2y (+ (nth 1 text-2) (nth 1 text-position)))
            ; 计算单行文本文字范围的宽度与高度
            (setq text-w (- (nth 0 text-2) (nth 0 text-1)))
            (setq text-h (- (nth 1 text-2) (nth 1 text-1)))
            ; 计算文本范围中心坐标
            (setq text-cx (+ (nth 0 text-position) (nth 0 text-1) (* text-w 0.5)))
            (setq text-cy (+ (nth 1 text-position) (nth 1 text-1) (* text-h 0.5)))
            ; 计算加上偏移距离的边框顶点坐标
            (setq text-bor-1x (- text-1x offset))
            (setq text-bor-1y (- text-1y offset))
            (setq text-bor-2x (+ text-2x offset))
            (setq text-bor-2y (- text-1y offset))
            (setq text-bor-3x (+ text-2x offset))
            (setq text-bor-3y (+ text-2y offset))
            (setq text-bor-4x (- text-1x offset))
            (setq text-bor-4y (+ text-2y offset))
            ; 坐标系旋转
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
            
            ; 计算文本范围最小半径
            (setq text-r (sqrt (+ (expt (- text-cx text-1x) 2) (expt (- text-cy text-1y) 2))))
            
            ; 生成矩形边框
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
            ; 生成圆形边框
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

        ; 针对MTEXT多行文本
        (if (= (cdr (assoc 0 ent-data)) "MTEXT")
          (progn
            ; 获取插入点坐标
            (setq text-position (cdr (assoc 10 ent-data)))
            ; 获取旋转角度
            (setq text-rotation (cdr (assoc 50 ent-data)))
            ; 获取多行文本文字范围的宽度及高度
            (setq text-w (cdr (assoc 42 ent-data)))
            (setq text-h (cdr (assoc 43 ent-data)))
            ; 计算多行文本文字范围矩形顶点坐标
            (setq text-1x (nth 0 text-position))
            (setq text-1y (nth 1 text-position))
            (setq text-2x (nth 0 text-position))
            (setq text-2y (- (nth 1 text-position) text-h))
            (setq text-3x (+ (nth 0 text-position) text-w))
            (setq text-3y (- (nth 1 text-position) text-h))
            (setq text-4x (+ (nth 0 text-position) text-w))
            (setq text-4y (nth 1 text-position))
            ; 计算加上偏移距离的边框顶点坐标
            (setq text-bor-1x (- text-1x offset))
            (setq text-bor-1y (+ text-1y offset))
            (setq text-bor-2x (- text-2x offset))
            (setq text-bor-2y (- text-2y offset))
            (setq text-bor-3x (+ text-3x offset))
            (setq text-bor-3y (- text-3y offset))
            (setq text-bor-4x (+ text-4x offset))
            (setq text-bor-4y (+ text-4y offset))
            ; 计算文本范围中心坐标
            (setq text-cx (+ (nth 0 text-position) (* text-w 0.5)))
            (setq text-cy (- (nth 1 text-position) (* text-h 0.5)))
            ; 坐标系旋转
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

            ; 计算文本范围最小半径
            (setq text-r (sqrt (+ (expt (- text-cx text-1x) 2) (expt (- text-cy text-1y) 2))))

            ; 生成矩形边框
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
            ; 生成圆形边框
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
  ; 静默退出
  (princ)
)

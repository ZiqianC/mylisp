;;; ZWCAD产品二次开发实训--LISP
;;; 任务4：编写LISP命令TotalLength
;;; 创建人：陈子谦

(defun c:TotalLength ()
    
    ; 初始化
    (setq totalLength 0.0)
    (setq entityLength 0.0)
    
    ; 选择一组实体
    (setq selSet (ssget))
    
    ; 判断是否选择了实体
    (if selSet
        (progn
            (setq numEnts (sslength selSet))
            (setq i 0)
            (while (< i numEnts)
                (setq entity (ssname selSet i))
                (setq entityType (cdr (assoc 0 (entget entity))))
                ; 筛选实体选择集合中对应类型的对象
                (cond
                    ((or (eq entityType "CIRCLE")
                         (eq entityType "ELLIPSE")
                         (eq entityType "LINE")
                         (eq entityType "LWPOLYLINE")
                         (eq entityType "SPLINE")
                         (eq entityType "ARC"))
                    (setq entityLength (vlax-curve-getDistAtParam entity (vlax-curve-getEndParam entity)))
                    )
                )
                (setq totalLength (+ totalLength entityLength))
                (setq i (+ i 1))
            )
            (prompt (strcat "\n总长度为：" (rtos totalLength 2 2) "（计算对象：圆、椭圆、直线、多段线、样条曲线、圆弧）"))
        )
        (prompt "\n未选择实体。")
    )
    (princ)
)

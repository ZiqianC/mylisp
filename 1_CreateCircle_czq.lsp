;;; ZWCAD产品二次开发实训--LISP
;;; 任务1：编写LISP命令CreateCircle
;;; 创建人：陈子谦

(defun c:CreateCircle ()
    
    ; 圆心坐标
    (setq circleCenter '(0.0 0.0 0.0))
    ; 圆的半径
    (setq circleRadius 10.0)

    ; 定义圆的相关实体参数
    (setq circleEntity
        (list
         (cons 0 "CIRCLE")
         (cons 10 circleCenter)
         (cons 40 circleRadius)
         )
    )
    ; 创建圆实体
    (entmake circleEntity)

    ; 打印提示语
    (prompt "\n成功创建圆心位于(0,0)，半径为10的圆（颜色随层）") 
    ; 静默退出
    (princ)
)

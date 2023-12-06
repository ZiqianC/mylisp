;;; ZWCAD产品二次开发实训--LISP
;;; 任务5：编写LISP命令SelectSimi
;;; 创建人：陈子谦

(defun c:SelectSimi ()
  
    (setq selectedEntity (car (entsel "\n选择一个实体作为基准：")))
    
    (if selectedEntity
        (progn
            (setq entityType (cdr (assoc 0 (entget selectedEntity))))
            (setq similarEntities (ssget "_X" (list (cons 0 entityType))))
            (if similarEntities
                (progn
                    (sssetfirst nil similarEntities)
                    (princ (strcat "\n已选中 " (itoa (sslength similarEntities)) " 个相同类型的实体。"))
                )
                (princ "\n未找到其他相同类型的实体。")
            )
        )
        (princ "\n未选择有效的实体。")
    )
    (princ)
)

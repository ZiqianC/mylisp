;;; ZWCAD产品二次开发实训--LISP
;;; 任务2：编写LISP函数(ChangeCircleColor)
;;; 创建人：陈子谦

(defun c:ChangeCircleColor ()

    ; 选择一个实体
    (setq selEnt (entsel "\n请选择一个圆："))
    ; 判断是否选择了实体
    (if selEnt
        ; 若选择了实体
        (progn
            (setq a (car selEnt))
            (setq b (entget a))
            (setq EntType (cdr(assoc 0 b)))
            (setq EntColor (cdr(assoc 62 b)))
            ; 判断所选实体是否为圆
            (if (= EntType "CIRCLE")
                ; 若所选实体是圆
                (progn
                    ; 判断所选圆的颜色是否随层
                    (if EntColor
                        ; 若所选圆的颜色非随层
                        (progn
                            (if (= EntColor 1)
                                (progn
                                    (prompt "\n所选择的圆已为红色，无需变更颜色！")
                                )
                                (progn
                                    (setq a (subst (cons 62 1) (assoc 62 b) b))
                                    (entmod a)
                                    (prompt "\n已成功将所选圆的颜色修改为红色！")
                                )
                            )
                        )
                        ; 若所选圆的颜色随层
                        (progn
                            (setq a (cons (cons 62 1) b))
                            (entmod a)
                            (prompt "\n已成功将所选圆的颜色修改为红色！（原颜色随层）")
                        )
                    )    
                )
                ; 若所选实体不是圆
                (progn 
                    (prompt "\n所选图形非圆，请选择圆形！")
                )
            )
        )
        ; 若未选择实体
        (progn
            (prompt "\n未选择图形！请选择圆形！")
        )
    )
    ;静默退出
    (princ)
)

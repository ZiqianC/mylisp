;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����2����дLISP����(ChangeCircleColor)
;;; �����ˣ�����ǫ

(defun c:ChangeCircleColor ()

    ; ѡ��һ��ʵ��
    (setq selEnt (entsel "\n��ѡ��һ��Բ��"))
    ; �ж��Ƿ�ѡ����ʵ��
    (if selEnt
        ; ��ѡ����ʵ��
        (progn
            (setq a (car selEnt))
            (setq b (entget a))
            (setq EntType (cdr(assoc 0 b)))
            (setq EntColor (cdr(assoc 62 b)))
            ; �ж���ѡʵ���Ƿ�ΪԲ
            (if (= EntType "CIRCLE")
                ; ����ѡʵ����Բ
                (progn
                    ; �ж���ѡԲ����ɫ�Ƿ����
                    (if EntColor
                        ; ����ѡԲ����ɫ�����
                        (progn
                            (if (= EntColor 1)
                                (progn
                                    (prompt "\n��ѡ���Բ��Ϊ��ɫ����������ɫ��")
                                )
                                (progn
                                    (setq a (subst (cons 62 1) (assoc 62 b) b))
                                    (entmod a)
                                    (prompt "\n�ѳɹ�����ѡԲ����ɫ�޸�Ϊ��ɫ��")
                                )
                            )
                        )
                        ; ����ѡԲ����ɫ���
                        (progn
                            (setq a (cons (cons 62 1) b))
                            (entmod a)
                            (prompt "\n�ѳɹ�����ѡԲ����ɫ�޸�Ϊ��ɫ����ԭ��ɫ��㣩")
                        )
                    )    
                )
                ; ����ѡʵ�岻��Բ
                (progn 
                    (prompt "\n��ѡͼ�η�Բ����ѡ��Բ�Σ�")
                )
            )
        )
        ; ��δѡ��ʵ��
        (progn
            (prompt "\nδѡ��ͼ�Σ���ѡ��Բ�Σ�")
        )
    )
    ;��Ĭ�˳�
    (princ)
)

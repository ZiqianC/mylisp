;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����5����дLISP����SelectSimi
;;; �����ˣ�����ǫ

(defun c:SelectSimi ()
  
    (setq selectedEntity (car (entsel "\nѡ��һ��ʵ����Ϊ��׼��")))
    
    (if selectedEntity
        (progn
            (setq entityType (cdr (assoc 0 (entget selectedEntity))))
            (setq similarEntities (ssget "_X" (list (cons 0 entityType))))
            (if similarEntities
                (progn
                    (sssetfirst nil similarEntities)
                    (princ (strcat "\n��ѡ�� " (itoa (sslength similarEntities)) " ����ͬ���͵�ʵ�塣"))
                )
                (princ "\nδ�ҵ�������ͬ���͵�ʵ�塣")
            )
        )
        (princ "\nδѡ����Ч��ʵ�塣")
    )
    (princ)
)

;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����1����дLISP����CreateCircle
;;; �����ˣ�����ǫ

(defun c:CreateCircle ()
    
    ; Բ������
    (setq circleCenter '(0.0 0.0 0.0))
    ; Բ�İ뾶
    (setq circleRadius 10.0)

    ; ����Բ�����ʵ�����
    (setq circleEntity
        (list
         (cons 0 "CIRCLE")
         (cons 10 circleCenter)
         (cons 40 circleRadius)
         )
    )
    ; ����Բʵ��
    (entmake circleEntity)

    ; ��ӡ��ʾ��
    (prompt "\n�ɹ�����Բ��λ��(0,0)���뾶Ϊ10��Բ����ɫ��㣩") 
    ; ��Ĭ�˳�
    (princ)
)

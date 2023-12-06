;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����4����дLISP����TotalLength
;;; �����ˣ�����ǫ

(defun c:TotalLength ()
    
    ; ��ʼ��
    (setq totalLength 0.0)
    (setq entityLength 0.0)
    
    ; ѡ��һ��ʵ��
    (setq selSet (ssget))
    
    ; �ж��Ƿ�ѡ����ʵ��
    (if selSet
        (progn
            (setq numEnts (sslength selSet))
            (setq i 0)
            (while (< i numEnts)
                (setq entity (ssname selSet i))
                (setq entityType (cdr (assoc 0 (entget entity))))
                ; ɸѡʵ��ѡ�񼯺��ж�Ӧ���͵Ķ���
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
            (prompt (strcat "\n�ܳ���Ϊ��" (rtos totalLength 2 2) "���������Բ����Բ��ֱ�ߡ�����ߡ��������ߡ�Բ����"))
        )
        (prompt "\nδѡ��ʵ�塣")
    )
    (princ)
)

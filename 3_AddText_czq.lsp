;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����3����дLISP����AddText
;;; �����ˣ�����ǫ

(defun c:AddText ()  
    (setq acadob (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadob))
    (setq ms (vla-get-ModelSpace doc))
    
    ; ������������
    (setq insertPoint (vlax-3D-point '(100.0 100.0 0.0)))
    ; ������������
    (setq textString "text")
    ; �������ָ߶�
    (setq textHeight 10.0)
    
    (setq newText (vla-AddText ms textString insertPoint textHeight))
    
    (prompt "\n�Ѳ��뵥�����֣����ֿ�λ��(100,100)�����ָ߶�10����������text")
    ; ��Ĭ�˳�
    (princ)
)

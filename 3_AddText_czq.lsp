;;; ZWCAD产品二次开发实训--LISP
;;; 任务3：编写LISP命令AddText
;;; 创建人：陈子谦

(defun c:AddText ()  
    (setq acadob (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadob))
    (setq ms (vla-get-ModelSpace doc))
    
    ; 定义插入坐标点
    (setq insertPoint (vlax-3D-point '(100.0 100.0 0.0)))
    ; 定义文字内容
    (setq textString "text")
    ; 定义文字高度
    (setq textHeight 10.0)
    
    (setq newText (vla-AddText ms textString insertPoint textHeight))
    
    (prompt "\n已插入单行文字，文字框位置(100,100)，文字高度10，文字内容text")
    ; 静默退出
    (princ)
)

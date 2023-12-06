;;; ZWCAD产品二次开发实训--LISP
;;; 任务6：编写LISP命令AddReactor
;;; 创建人：陈子谦

(defun c:Addreactor()
  ; 创建直线myLine
  (setq myLine
    (progn
      (setq sPt (getpoint "\n 输入起点坐标："))
      (setq ePt (getpoint sPt "\n 输入终点坐标："))
      (vla-addLine
        (vla-get-ModelSpace(vla-get-ActiveDocument(vlax-get-acad-object)))
        (vlax-3d-point sPt)
        (vlax-3d-point ePt)
      )
    )
  )
  ; 获取当前myLine的长度，并打印显示
  (defun print-length (notifier-object reactor-object parameter-list)
    (setq newLength (vla-get-length notifier-object))
    (princ "\n该直线长度为：")
    (princ newLength)
  )

  ; 对创建的直线myLine创建反应器，当myLine被修改时，print-length
  (setq lineReactor (vlr-object-reactor (list myLine)
      "Line Reactor" '((:vlr-modified . print-length)))
  )
)

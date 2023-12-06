;;; ZWCAD��Ʒ���ο���ʵѵ--LISP
;;; ����6����дLISP����AddReactor
;;; �����ˣ�����ǫ

(defun c:Addreactor()
  ; ����ֱ��myLine
  (setq myLine
    (progn
      (setq sPt (getpoint "\n ����������꣺"))
      (setq ePt (getpoint sPt "\n �����յ����꣺"))
      (vla-addLine
        (vla-get-ModelSpace(vla-get-ActiveDocument(vlax-get-acad-object)))
        (vlax-3d-point sPt)
        (vlax-3d-point ePt)
      )
    )
  )
  ; ��ȡ��ǰmyLine�ĳ��ȣ�����ӡ��ʾ
  (defun print-length (notifier-object reactor-object parameter-list)
    (setq newLength (vla-get-length notifier-object))
    (princ "\n��ֱ�߳���Ϊ��")
    (princ newLength)
  )

  ; �Դ�����ֱ��myLine������Ӧ������myLine���޸�ʱ��print-length
  (setq lineReactor (vlr-object-reactor (list myLine)
      "Line Reactor" '((:vlr-modified . print-length)))
  )
)

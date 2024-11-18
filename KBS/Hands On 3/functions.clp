(deffunction add-illness (?name ?type $?symptoms)
   (assert (illness (name ?name) (type ?type) (symptoms $?symptoms)))
   (printout t "Illness added successfully: " ?name crlf))

(deffunction update-illness (?old-name ?new-name ?new-type $?new-symptoms)
   (do-for-all-facts ((?f illness))
      (if (eq (fact-slot-value ?f name) ?old-name) then
         (retract ?f)
         (assert (illness (name ?new-name) (type ?new-type) (symptoms $?new-symptoms)))
         (printout t "Illness updated successfully: " ?new-name crlf)
         return)) ;; Stop further iteration after finding and updating the fact
)

(deffunction delete-illness (?name)
   (do-for-all-facts ((?f illness))
      (if (eq (fact-slot-value ?f name) ?name) then
         (retract ?f)
         (printout t "Illness deleted successfully: " ?name crlf)
         return))
)

(deffunction search-illness-by-name (?illness-name)
   (do-for-all-facts ((?f illness))
      (if (eq (fact-slot-value ?f name) ?illness-name) then
         (printout t "Illness Found:" crlf)
         (printout t "Name: " (fact-slot-value ?f name) crlf)
         (printout t "Type: " (fact-slot-value ?f type) crlf)
         (printout t "Symptoms: " (fact-slot-value ?f symptoms) crlf)
         return)) ;; Stop further iteration after finding the fact
)


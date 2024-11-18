(defrule calculate-total-all
    (declare (salience 10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?phone-item <- (Smartphone (modelo ?phone) (precio ?phone-price))
    ?comp-item <- (Computadora (modelo ?computer) (precio ?comp-price))
    ?acc-item <- (Accesorio (tipo ?accesory) (precio ?acc-price))
    =>
    (bind ?total (+ (* ?phone-price ?p-qty) (* ?comp-price ?c-qty) (* ?acc-price ?a-qty)))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule calculate-total-1
    (declare (salience 10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora nil)
                     (computadora-qty nil)
                     (accesorio nil)
                     (accesorio-qty nil))
    ?phone-item <- (Smartphone (modelo ?phone) (precio ?phone-price))
    =>
    (bind ?total (* ?phone-price ?p-qty))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule calculate-total-2
    (declare (salience 10))
    ?orden <- (Orden (smartphone nil)
                     (smartphone-qty nil)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio nil)
                     (accesorio-qty nil))
    ?comp-item <- (Computadora (modelo ?computer) (precio ?comp-price))
    =>
    (bind ?total (* ?comp-price ?c-qty))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule calculate-total-3
    ?orden <- (Orden (smartphone nil)
                     (smartphone-qty nil)
                     (computadora nil)
                     (computadora-qty nil)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?acc-item <- (Accesorio (tipo ?accesory) (precio ?acc-price))
    =>
    (bind ?total (* ?acc-price ?a-qty))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule calculate-total-4
    (declare (salience 10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio nil)
                     (accesorio-qty nil))
    ?phone-item <- (Smartphone (modelo ?phone) (precio ?phone-price))
    ?comp-item <- (Computadora (modelo ?computer) (precio ?comp-price))
    =>
    (bind ?total (+ (* ?phone-price ?p-qty) (* ?comp-price ?c-qty)))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule calculate-total-5
    (declare (salience 10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora nil)
                     (computadora-qty nil)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?phone-item <- (Smartphone (modelo ?phone) (precio ?phone-price))
    ?acc-item <- (Accesorio (tipo ?accesory) (precio ?acc-price))
    =>
    (bind ?total (+ (* ?phone-price ?p-qty) (* ?acc-price ?a-qty)))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule calculate-total-6
    (declare (salience 10))
    ?orden <- (Orden (smartphone nil)
                     (smartphone-qty nil)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?comp-item <- (Computadora (modelo ?computer) (precio ?comp-price))
    ?acc-item <- (Accesorio (tipo ?accesory) (precio ?acc-price))
    =>
    (bind ?total (+ (* ?comp-price ?c-qty) (* ?acc-price ?a-qty)))
    (modify ?orden (total ?total))
    (printout t "Total calculado para la orden: " ?total " pesos." crlf))

(defrule iphone16-banamex-24msi
    ?orden <- (Orden (smartphone "iPhone16")
                     (metodo-pago "tarjeta")
                     (tarjeta-tipo "Banamex"))
    =>
    (printout t "La compra del iPhone16 con tarjeta Banamex ofrece 24 meses sin intereses." crlf))

(defrule note21-liverpool-12msi
    ?orden <- (Orden (smartphone "Note21")
                     (metodo-pago "tarjeta")
                     (tarjeta-tipo "VISA"))
    =>
    (printout t "La compra del Samsung Note21 con tarjeta Liverpool VISA ofrece 12 meses sin intereses." crlf))

(defrule macbook-iphone16-vales
    ?orden <- (Orden (smartphone "iPhone16")
                     (computadora "MacBook Air")
                     (metodo-pago "contado")
                     (total ?total&:(> ?total 1000))
                     (cliente ?cliente))
    =>
    (bind ?vales (* (integer (/ ?total 1000)) 100))
    (assert (Vale (valor ?vales) (cliente ?cliente)))
    (printout t "Vales otorgados por la compra: " ?vales " pesos." crlf))

(defrule descuento-accesorios-smartphone
    (declare (salience 20))
    ?orden <- (Orden (smartphone ?phone&~nil)
                     (smartphone-qty ?phone-qty&:(> ?phone-qty 0))
                     (accesorio ?accessory&~nil)
                     (accesorio-qty ?accessory-qty&:(> ?accessory-qty 0))
                     (total ?total))
    ?accessory-data <- (Accesorio (tipo ?accessory) (precio ?price))
    =>
    ;; Calcular descuento
    (bind ?discount (* ?price ?accessory-qty 0.15))
    (bind ?new-price (- (* ?price ?accessory-qty) ?discount))
    (printout t "Oferta: 15% de descuento en accesorios al comprar un Smartphone." crlf)
    (printout t "Accesorio: " ?accessory ", Cantidad: " ?accessory-qty ", Precio original: " (* ?price ?accessory-qty) " pesos." crlf)
    (printout t "Descuento aplicado: " ?discount " pesos. Precio con descuento: " ?new-price " pesos." crlf)
    
    ;; Actualizar total
    (bind ?new-total (- ?total ?discount))
    (printout t "Total actualizado de la orden: " ?new-total " pesos." crlf))

(defrule update-stock-1
    (declare (salience -10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora nil)
                     (computadora-qty nil)
                     (accesorio nil)
                     (accesorio-qty nil))
    ?item1 <- (Smartphone (modelo ?phone) (stock ?stock&:(>= ?stock ?p-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?p-qty))) ;; Update stock
    (printout t "Stock actualizado para " ?phone ": " (- ?stock ?p-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule update-stock-2
    (declare (salience -10))
    ?orden <- (Orden (smartphone nil)
                     (smartphone-qty nil)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio nil)
                     (accesorio-qty nil))
    ?item1 <- (Computadora (modelo ?computer) (stock ?stock&:(>= ?stock ?c-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?c-qty))) ;; Update stock
    (printout t "Stock actualizado para " ?computer ": " (- ?stock ?c-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule update-stock-3
    (declare (salience -10))
    ?orden <- (Orden (smartphone nil)
                     (smartphone-qty nil)
                     (computadora nil)
                     (computadora-qty nil)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?item1 <- (Accesorio (tipo ?accesory) (stock ?stock&:(>= ?stock ?a-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?a-qty))) ;; Update stock
    (printout t "Stock actualizado para " ?accesory ": " (- ?stock ?a-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule update-stock-4
    (declare (salience -10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio nil)
                     (accesorio-qty nil))
    ?item1 <- (Smartphone (modelo ?phone) (stock ?stock&:(>= ?stock ?p-qty)))
    ?item2 <- (Computadora (modelo ?computer) (stock ?stock&:(>= ?stock ?c-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?p-qty))) ;; Update stock
    (modify ?item2 (stock (- ?stock ?c-qty)))
    (printout t "Stock actualizado para " ?phone ": " (- ?stock ?p-qty) " unidades restantes." crlf)
    (printout t "Stock actualizado para " ?computer ": " (- ?stock ?c-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule update-stock-5
    (declare (salience -10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora nil)
                     (computadora-qty nil)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?item1 <- (Smartphone (modelo ?phone) (stock ?stock&:(>= ?stock ?p-qty)))
    ?item2 <- (Accesorio (tipo ?accesory) (stock ?stock&:(>= ?stock ?a-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?p-qty))) ;; Update stock
    (modify ?item2 (stock (- ?stock ?a-qty)))
    (printout t "Stock actualizado para " ?phone ": " (- ?stock ?p-qty) " unidades restantes." crlf)
    (printout t "Stock actualizado para " ?accesory ": " (- ?stock ?a-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule update-stock-6
    (declare (salience -10))
    ?orden <- (Orden (smartphone nil)
                     (smartphone-qty nil)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?item1 <- (Computadora (modelo ?computer) (stock ?stock&:(>= ?stock ?c-qty)))
    ?item2 <- (Accesorio (tipo ?accesory) (stock ?stock&:(>= ?stock ?a-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?c-qty))) ;; Update stock
    (modify ?item2 (stock (- ?stock ?a-qty)))
    (printout t "Stock actualizado para " ?computer ": " (- ?stock ?c-qty) " unidades restantes." crlf)
    (printout t "Stock actualizado para " ?accesory ": " (- ?stock ?a-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule update-stock-7
    (declare (salience -10))
    ?orden <- (Orden (smartphone ?phone)
                     (smartphone-qty ?p-qty)
                     (computadora ?computer)
                     (computadora-qty ?c-qty)
                     (accesorio ?accesory)
                     (accesorio-qty ?a-qty))
    ?item1 <- (Smartphone (modelo ?phone) (stock ?stock&:(>= ?stock ?p-qty)))
    ?item2 <- (Computadora (modelo ?computer) (stock ?stock&:(>= ?stock ?c-qty)))
    ?item3 <- (Accesorio (tipo ?accesory) (stock ?stock&:(>= ?stock ?a-qty)))
    =>
    (modify ?item1 (stock (- ?stock ?p-qty)))
    (modify ?item2 (stock (- ?stock ?c-qty))) ;; Update stock
    (modify ?item3 (stock (- ?stock ?a-qty)))
    (printout t "Stock actualizado para " ?phone ": " (- ?stock ?p-qty) " unidades restantes." crlf)
    (printout t "Stock actualizado para " ?computer ": " (- ?stock ?c-qty) " unidades restantes." crlf)
    (printout t "Stock actualizado para " ?accesory ": " (- ?stock ?a-qty) " unidades restantes." crlf)
    (retract ?orden))

(defrule evaluate-client-type
    ?orden <- (Orden (smartphone-qty ?p-qty)
                     (computadora-qty ?c-qty)
                     (accesorio-qty ?a-qty)
                     (cliente ?client))
    =>
    ;; Check if any quantity exceeds 10
    (if (or (> ?p-qty 10)
            (> ?c-qty 10)
            (> ?a-qty 10))
            
        then
        ;; Print as mayorista
        (printout t "El cliente " ?client " es clasificado como mayorista basado en las cantidades de la orden." crlf))
    (if (and (<= ?p-qty 10)
             (<= ?c-qty 10)
             (<= ?a-qty 10))
             
        then
        ;; Print as menudista
        (printout t "El cliente " ?client " es clasificado como menudista basado en las cantidades de la orden." crlf)))

(defrule msi-12-mayores-50000
    ?orden <- (Orden (metodo-pago "tarjeta")
                     (total ?total&:(> ?total 50000)))
    =>
    (printout t "Oferta: Tu compra de " ?total " pesos califica para 12 meses sin intereses." crlf))

(defrule msi-6-mayores-30000
    ?orden <- (Orden (metodo-pago "tarjeta")
                     (total ?total&:(> ?total 30000)))
    =>
    (printout t "Oferta: Tu compra de " ?total " pesos califica para 6 meses sin intereses." crlf))

(defrule msi-6-accesorios
    ?orden <- (Orden (accesorio-qty ?qty&:(> ?qty 0))
                     (metodo-pago "tarjeta")
                     (total ?total&:(> ?total 2000)))
    =>
    (printout t "Oferta: Tu compra de accesorios por " ?total " pesos califica para 6 meses sin intereses." crlf))

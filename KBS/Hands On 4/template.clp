(deftemplate Smartphone
    (slot marca)
    (slot modelo)
    (slot stock)
    (slot precio))

(deftemplate Computadora
    (slot marca)
    (slot modelo)
    (slot stock)
    (slot precio))

(deftemplate Accesorio
    (slot tipo) 
    (slot stock)
    (slot precio))

(deftemplate Cliente
    (slot nombre)
    (slot tipo)) 

(deftemplate Orden
    (slot smartphone) ;; Lista de smartphones ordenados
    (slot smartphone-qty) ;; Cantidad de smartphones
    (slot computadora) ;; Lista de computadoras ordenadas
    (slot computadora-qty) ;; Cantidad de computadoras
    (slot accesorio) ;; Lista de accesorios ordenados
    (slot accesorio-qty) ;; Cantidad de accesorios
    (slot cliente) ;; Referencia al cliente
    (slot metodo-pago) ;; Tarjeta o contado
    (slot tarjeta-tipo) ;; Ejemplo: Banamex, Liverpool VISA
    (slot total) ;; Total de la orden
)

(deftemplate Tarjeta
    (slot banco)
    (slot grupo)
    (slot fecha-expiracion))

(deftemplate Vale
    (slot valor)
    (slot cliente))
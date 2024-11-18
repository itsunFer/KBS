(deffacts inventario
    ;; Smartphones
    (Smartphone (marca "Apple") (modelo "iPhone16") (stock 200) (precio 30000))
    (Smartphone (marca "Apple") (modelo "iPhone15") (stock 200) (precio 20000))
    (Smartphone (marca "Samsung") (modelo "Note21") (stock 200) (precio 25000))
    
    ;; Computadoras
    (Computadora (marca "Apple") (modelo "MacBook Air") (stock 200) (precio 40000))
    (Computadora (marca "Apple") (modelo "MacBook Pro") (stock 200) (precio 60000))
    (Computadora (marca "HP") (modelo "Pavilion 15") (stock 200) (precio 20000))
    
    ;; Accesorios
    (Accesorio (tipo "Funda") (stock 200) (precio 500))
    (Accesorio (tipo "Funda2") (stock 100) (precio 450))
    (Accesorio (tipo "Mica") (stock 50) (precio 200))
    
    ;; Clientes
    (Cliente (nombre "Juan Perez") (tipo "mayorista"))
    (Cliente (nombre "Antonio Lopez") (tipo "mayorista"))
    (Cliente (nombre "Maria Lopez") (tipo "menudista"))
    
    ;; Tarjetas
    (Tarjeta (banco "Banamex") (grupo "VISA") (fecha-expiracion "12/2026"))
    (Tarjeta (banco "Liverpool") (grupo "VISA") (fecha-expiracion "01/2025")))
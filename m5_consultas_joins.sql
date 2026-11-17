/* CONSULTA 1 */

SELECT
  v.fecha_venta AS fecha,
  c.id_clientes AS ID_Clientes,
  c.nombre AS cliente,
  c.ciudad AS ciudad,
  p.nombre_producto AS producto,
  cat.nombre_categoria AS categoria,
  v.cantidad AS cantidad,
  v.precio_unitario AS Precio_unitario,
    CAST((v.cantidad*v.precio_unitario) AS DECIMAL(12,2)) AS Total_venta

    FROM ventas AS v

      INNER JOIN clientes AS c
       ON v.id_clientes = c.id_clientes

      INNER JOIN productos AS p
       ON v.id_productos = p.id_productos


      INNER JOIN categorias AS cat
       ON p.id_categoria = cat.id_categoria

       ORDER BY v.fecha_venta;

    
    --CONSULTA 2: que cliente no tuvo ventas

    SELECT
      c.nombre AS cliente,
      c.email AS Email,
      c.fecha_registro AS Fecha_registro
       
       FROM clientes AS c
       LEFT JOIN ventas AS v
         ON c.id_clientes = v.id_clientes
       WHERE v.id_venta IS NULL;

       --AGREGUE CLIENTE SIN VENTAS

       INSERT INTO clientes
    (id_clientes, nombre, email, ciudad, fecha_registro)
VALUES
    (6, 'Lucía Fernández', 'lucia@mail.com', 'Córdoba', '2024-03-20');

    SELECT *
       FROM dbo.clientes;


--CONSULTA 3: que producto no tuvo ventas 

 SELECT 
   p.nombre_producto AS producto,
   cat.nombre_categoria AS categoria,
   p.precio AS Precio

   FROM productos AS p
   LEFT JOIN ventas AS v
    ON p.id_productos = v.id_productos

    INNER JOIN categorias AS cat
     ON p.id_categoria = cat.id_categoria
     WHERE v.id_venta IS NULL;
  
  --AGREGUE UN PRODUCTO SIN VENTAS PARA COMPROBAR 

  INSERT INTO productos
    (id_productos, nombre_producto, id_categoria, precio, stock, activo)
  VALUES
    (7, 'Webcam HD', 2, 75.00, 10, 1);

    SELECT *
   FROM dbo.productos;



      
-- CONSULTA 4: se separo a las ventas en dos periodos, se creo una columna llamada canal y se unio todo UNION ALL

SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total,
           'Periodo 1' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT fecha_venta, cantidad * precio_unitario AS total,
           'Periodo 2' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-11' AND '2024-03-15'

) AS consolidado
GROUP BY canal;



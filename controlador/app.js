const express = require('express')
const bodyParser = require('body-parser')
const mysql2 = require('mysql2/promise')

const app = express()

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(__dirname));

//Conexion bbdd
const db = mysql2.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'manzanasdelcuidado'
})

db.on("error", (err) => {
    console.error("Error 7: " + err)
})

// Registrar usuario
app.post('/crear', async (req, res) => {
    const {nombres,tipod,numerod,manzanaa} = req.body
    try {
        console.log(manzanaa);
        
        //verificar el usurio
        const [veri]= await db.query('SELECT * FROM usuario WHERE Tipo_documento=? AND Documento=?', [tipod,numerod])

        if (veri.length > 0) {
            res.status(409).send(`
                <script>
                window.onload=function(){
                alert("Usuario existente")
                window.location.href='.../Vista/sesion.html'
                }
                </script>
                `)
        }
        else{
            await db.query('INSERT INTO usuario (Nombres,Tipo_documento,Documento,fk_id_manzana) VALUES (?,?,?,?)',[nombres, tipod, numerod,manzanaa])
            res.status(201).send(`
                <script>
                window.onload=function(){
                alert("DATOS GUARDADOS")
                window.location.href='.../Vista/sesion.html'
                }
                </script>
                `)
        }
    }
    catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');
    }
//     const jhon = `INSERT INTO usuario (Nombres,Tipo_documento,Documento,fk_id_manzana) VALUES (?,?,?,?)`
//     db.query(jhon, [nombre, tipo, numero, manzana], (err, result) => {
//         if (err) {
//             console.error("Error: " + err)
//             res.status(500).send("Pailas")
//             return
//         }
//         else {
//             console.log("Todo bien perro")
//             res.status(200).send("Listo los datos")
//         }
//     })
})

// Apertura del servidor
app.listen(3000, () => {
    console.log(`Servidor Node.js escuchando`)
})
const express = require('express')
const bodyParser = require('body-parser')
const mysql2 = require('mysql2/promise')
const path = require('path')
const moment = require('moment')
const session = require('express-session')
const app = express()

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(__dirname));
app.use(express.static(path.join(__dirname, '../Vista')));

// configurar la sesion
app.use(session({
    secret: 'Miapp',
    resave: false,
    saveUninitialized: true
}))

//Conexion bbdd
const db = mysql2.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'manzanasdelcuidado'
})


// Registrar usuario
app.post('/crear', async (req, res) => {
    const { nombres, tipod, numerod, manzanaa } = req.body
    try {
        //verificar el usurio
        const [veri] = await db.query('SELECT * FROM usuario WHERE Tipo_documento=? AND Documento=?', [tipod, numerod])

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
        else {
            await db.query('INSERT INTO usuario (Nombres,Tipo_documento,Documento,fk_id_manzana) VALUES (?,?,?,?)', [nombres, tipod, numerod, manzanaa])
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
})

app.post('/iniciar', async (req, res) => {
    try {

        const { tipod, numerod } = req.body
        const [datos] = await db.query('SELECT * FROM usuario WHERE Tipo_documento=? AND Documento=?', [tipod, numerod])
        
        if (datos.length > 0) {
            req.session.usuario=datos[0].Nombres
            res.sendFile(path.join(__dirname, '../Vista/botones.html'))
        }else{
            res.sendFile(path.join(__dirname, '../Vista/sesion.html')) 
        }
    } catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');
    }
})



app.get('/obtener-usuario',(req,res)=>{
    const usuario=req.session.usuario
    
    if(usuario){
        res.json(usuario)
    }
    else{
        res.status(401).send('Usuario no autenticado')
    }
})

app.get('/obtenerServiciosManzana', async (req, res) =>{
    try {
        const [datos] = await db.query('SELECT s.id_servicio,s.Nombre_servicio, s.Descripcion FROM manzanas  m INNER JOIN manzanas_servicios ms ON m.id_manzana = ms.fk_id_manzana INNER JOIN servicios s ON ms.fk_id_servicio = s.id_servicio WHERE m.id_manzana = 1 ')
        if (datos.length > 0) {
            res.json(datos)
        }else {
            res.status(500).send('Error en el servidor');

        }
    } catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');
    }
})
//Enviar servicios 
app.post('/guardar-servicios-usuario',async (req,res)=>{
    const usuario=req.session.usuario
    const Documento=req.session.Documento
    const {servicios,fechaHora}=req.body
    console.log(servicios,fechaHora)
})
// Apertura del servidor
app.listen(3000, () => {
    console.log(`Servidor Node.js escuchando`)
})

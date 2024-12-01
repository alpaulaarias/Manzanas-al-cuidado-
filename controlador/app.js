const express = require('express')
const bodyParser = require('body-parser')
const mysql2 = require('mysql2/promise')
const path = require('path')
const moment = require('moment')
const session = require('express-session')
const { log } = require('console')
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
    database: 'manzanasdelcuidado2'
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
    try {
        const usuario=req.session.usuario
        const {servicios,fecha}=req.body
    
        const [datosUsuario] = await db.query(' SELECT id_mujer FROM usuario WHERE Nombres= ?',[usuario])
        const idUsuario = datosUsuario[0].id_mujer
        servicios.forEach(async idServicio => {
            const resultado = await db.query('INSERT INTO solicitudes(Fecha_asistencia, fk_id_mujer, fk_id_servicio) VALUES(?,?,?)',[fecha, idUsuario, idServicio]) 
        });
        res.status(200).json({operacion: 'ok'})
    } catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');       
    }

})

app.get('/obtenerServiciosUsuario', async (req, res) => {
    try {
        const usuario=req.session.usuario

        const [datosUsuario] = await db.query(' SELECT id_mujer FROM usuario WHERE Nombres= ?',[usuario])
        const idUsuario = datosUsuario[0].id_mujer
        const [servicios]=await db.query("SELECT * FROM usuario  u INNER JOIN solicitudes s ON u.id_mujer = s.fk_id_mujer INNER JOIN servicios se ON s.fk_id_servicio = se.id_servicio WHERE u.id_mujer =?", [idUsuario])
        res.status(200).json(servicios)

    } catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');
    }
})
app.delete('/eliminarServicioUsuario',  async (req, res) => {
    try {
        const {servicio}=req.body
        console.log (servicio)

        const query='delete from solicitudes where fk_id_servicio=?'
        const [resu] = await db.query(query,[servicio])
        res.status(200).json({operacion:'se elimino servicio'})

    } catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');   
    }
}) 

app.get('/obtenerUsuarios', async (req, res) => {
    try {
        const query='select * from usuario'
        const [usuarios]= await db.query(query)
        console.log(usuarios);
        res.status(200).json(usuarios)
        
    } catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor'); 
    }
})
// Apertura del servidor
app.listen(3000, () => {
    console.log(`Servidor Node.js escuchando`)
})

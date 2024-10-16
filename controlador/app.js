const express = require('express')
const bodyParser = require('body-parser')
const mysql2 = require('mysql2/promise')
const path= require('path')
const moment=require('moment')
const session=require('express-session')
const app = express()

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(__dirname));
app.use(express.static(path.join(__dirname)));

// configurar la sesion
app.use(session({
    secret:'Miapp',
    resave:false,
    saveUninitialized:true
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
    const {nombres,tipod,numerod,manzanaa} = req.body
    try {
        //verificar el usurio
        const conect= await mysql2.createConnection(db)
        const [veri]= await conect.execute('SELECT * FROM usuario WHERE Tipo_documento=? AND Documento=?', [tipod,numerod])

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
            await conect.execute('INSERT INTO usuario (Nombres,Tipo_documento,Documento,fk_id_manzana) VALUES (?,?,?,?)',[nombres, tipod, numerod,manzanaa])
            res.status(201).send(`
                <script>
                window.onload=function(){
                alert("DATOS GUARDADOS")
                window.location.href='.../Vista/sesion.html'
                }
                </script>
                `)
                await conect.end()
        }
        await conect.end()
    }
    catch (error) {
        console.error('Error en el servidor:', error)
        res.status(500).send('Error en el servidor');
    }
})

app.post('/iniciar', async (req,res)=>{
    const {tipod,numerod}=req.body
    try{
        const conect=await mysql2.createConnection(db)
        const [datos]= await conect.execute('SELECT * FROM usuario WHERE Tipo_documento=? AND Documento=?', [tipod,numerod])
        console.log(datos)
    }
    if (datos.length>0){
        const [man]=
    res.sendFile(path.join(__dirname, 'botones.html'))
}
})
// Apertura del servidor
app.listen(3000, () => {
    console.log(`Servidor Node.js escuchando`)
})

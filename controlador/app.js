const express = require('express')
const bodyParser = require('body-parser')
const mysql2 = require('mysql2')

const app=express()

// Middleware
app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());
app.use(express.static(_dirname));

//Conexion bbdd
const db= mysql2.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    datebase:'manzanasdelcuidado'
})

db.connect((err)=>{
    if(err){
        console.error("Error"+err)
        return
    }
    console.log("ok")
})

// Registrar usuario
app.post('/crear',(req,res)=>{
    const {nombre,tipo,numero,manzana}=req.body
    console.log(nombre,tipo,numero,manzana)
    const jhon=`INSERT INTO usuario (Nombres,Tipo_documento,Documento,fk_id_manzana) VALUES (?,?,?,?)`
    db.query(jhon,[nombre,tipo,numero,manzana],(err,result)=>{
        if(err){
            console.error("Error: "+err)
            res.status(500).send("Pailas")
            return
        }
        else{
            console.log("Todo bien perro")
            res.status(200).send("Listo los datos")
        }
    })
})

// Apertura del servidor
app.listen(3000, ()=>{
    console.log(`Servidor Node.js escuchando`)
})
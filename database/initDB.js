const fs = require('fs');
const path = require('path');
const sqlite3 = require('sqlite3').verbose();

async function initializeDatabase(dbPath) {
    // Crear carpeta si no existe
    const dbDir = path.dirname(dbPath);
    if (!fs.existsSync(dbDir)) {
        fs.mkdirSync(dbDir, { recursive: true });
    }

    // Abrir la base de datos con modo de escritura
    const db = await new Promise((resolve, reject) => {
        const dbInstance = new sqlite3.Database(dbPath, sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE, (err) => {
            if (err) reject(err);
            else resolve(dbInstance);
        });
    });

    try {
        // Verificar si la base de datos está recién creada
        const isNewDb = await checkIfNewDatabase(db);
        
        // 1. Crear todas las tablas (solo si es nueva o forzar recreación)
        await createTables(db, isNewDb);
        
        // 2. Crear todos los triggers
        await createTriggers(db);
        
        return db;
    } catch (err) {
        db.close();
        throw err;
    }
}

async function checkIfNewDatabase(db) {
    return new Promise((resolve, reject) => {
        db.get("SELECT name FROM sqlite_master WHERE type='table'", (err, row) => {
            if (err) reject(err);
            resolve(!row); // Si no hay tablas, es nueva
        });
    });
}

async function createTables(db, forceCreate = false) {
    const schemasDir = path.join(__dirname, 'schemas');
    
    if (!fs.existsSync(schemasDir)) {
        throw new Error(`No se encontró la carpeta de esquemas: ${schemasDir}`);
    }

    const schemaFiles = fs.readdirSync(schemasDir)
        .filter(file => file.endsWith('.sql'));

    for (const file of schemaFiles) {
        const tableName = file.replace('.sql', '');
        const sql = fs.readFileSync(path.join(schemasDir, file), 'utf8');
        
        try {
            // Verificar si la tabla ya existe
            const tableExists = await checkTableExists(db, tableName);
            
            if (!tableExists || forceCreate) {
                await executeQuery(db, sql);
                console.log(`✅ ${tableExists ? 'Tabla actualizada' : 'Tabla creada'}: ${tableName}`);
            } else {
                console.log(`ℹ️ Tabla ya existe: ${tableName}`);
            }
        } catch (err) {
            console.error(`❌ Error al procesar tabla ${tableName}:`, err.message);
            throw err;
        }
    }
}

async function checkTableExists(db, tableName) {
    return new Promise((resolve, reject) => {
        db.get(
            "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
            [tableName],
            (err, row) => {
                if (err) reject(err);
                resolve(!!row);
            }
        );
    });
}
async function createTriggers(db) {
    const triggersDir = path.join(__dirname, 'triggers');
    
    // Si no existe la carpeta de triggers, simplemente retornar
    if (!fs.existsSync(triggersDir)) {
        console.log('ℹ️ No se encontró carpeta de triggers');
        return;
    }

    const triggerFiles = fs.readdirSync(triggersDir)
        .filter(file => file.endsWith('.sql'));

    for (const file of triggerFiles) {
        const triggerName = file.replace('.sql', '');
        const sql = fs.readFileSync(path.join(triggersDir, file), 'utf8');
        
        try {
            // Verificar si el trigger ya existe
            const triggerExists = await checkTriggerExists(db, triggerName);
            
            if (!triggerExists) {
                await executeQuery(db, sql);
                console.log(`🎯 Trigger creado: ${triggerName}`);
            } else {
                console.log(`ℹ️ Trigger ya existe: ${triggerName}`);
            }
        } catch (err) {
            console.error(`❌ Error al procesar trigger ${triggerName}:`, err.message);
            throw err;
        }
    }
}

async function checkTriggerExists(db, triggerName) {
    return new Promise((resolve, reject) => {
        db.get(
            "SELECT name FROM sqlite_master WHERE type='trigger' AND name=?",
            [triggerName],
            (err, row) => {
                if (err) reject(err);
                resolve(!!row);
            }
        );
    });
}
function executeQuery(db, sql) {
    return new Promise((resolve, reject) => {
        db.run(sql, function(err) {
            if (err) {
                // Mejorar el mensaje de error para debugging
                const errorMsg = `Error en SQL: ${sql.substring(0, 50)}... → ${err.message}`;
                reject(new Error(errorMsg));
            } else {
                resolve();
            }
        });
    });
}

module.exports = { initializeDatabase };
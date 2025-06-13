// main.js
const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const fs = require('fs');
const { initializeDatabase } = require('./database/initDB');

let db;
const dbFolder = path.join(__dirname, 'database');
const dbPath = path.join(dbFolder, 'policlinica.db');

function createWindow() {
    const win = new BrowserWindow({
    width: 1280,
    height: 720,
    minWidth: 800,  // Ancho mínimo donde el navbar sigue siendo usable
    minHeight: 600,
        autoHideMenuBar: true,
         webPreferences: {
            preload: path.join(__dirname, 'preload.js'),
            nodeIntegration: false,
            contextIsolation: true,
            sandbox: true
        },
        title: 'Sistema de Policlínica',
        icon: path.join(__dirname, 'icon.ico')
    });

    // Cargar la aplicación el archivo HTML principal
    win.loadFile('public/index.html');

    // Solo abrir devTools en desarrollo
    if (process.env.NODE_ENV === 'development') {
        win.webContents.openDevTools({ mode: 'detach' });
    }

    // Manejar cierre limpio
    win.on('closed', () => {
        win = null;
    });
}

function setupIPCHandlers() {
    // Operaciones de base de datos
    ipcMain.handle('execute-query', async (event, sql, params) => {
        return new Promise((resolve, reject) => {
            db.run(sql, params, function (err) {
                if (err) {
                    console.error('Error en execute-query:', err);
                    reject(err.message);
                } else {
                    resolve({
                        lastID: this.lastID,
                        changes: this.changes
                    });
                }
            });
        });
    });

    ipcMain.handle('fetch-all', async (event, sql, params) => {
        return new Promise((resolve, reject) => {
            db.all(sql, params, (err, rows) => {
                if (err) {
                    console.error('Error en fetch-all:', err);
                    reject(err.message);
                } else {
                    resolve(rows || []);
                }
            });
        });
    });

    ipcMain.handle('fetch-one', async (event, sql, params) => {
        return new Promise((resolve, reject) => {
            db.get(sql, params, (err, row) => {
                if (err) {
                    console.error('Error en fetch-one:', err);
                    reject(err.message);
                } else {
                    resolve(row || {});
                }
            });
        });
    });

    // // Control de ventana
    // ipcMain.on('minimize-window', () => {
    //     const win = BrowserWindow.getFocusedWindow();
    //     win?.minimize();
    // });

    // ipcMain.on('maximize-window', () => {
    //     const win = BrowserWindow.getFocusedWindow();
    //     if (win?.isMaximized()) {
    //         win.unmaximize();
    //     } else {
    //         win?.maximize();
    //     }
    // });

    // ipcMain.on('close-window', () => {
    //     const win = BrowserWindow.getFocusedWindow();
    //     win?.close();
    // });

    // Otras utilidades
    ipcMain.handle('get-app-version', () => {
        return app.getVersion();
    });
}

async function initializeApp() {
    try {
        // Verificar y crear carpeta de base de datos si no existe
        if (!fs.existsSync(dbFolder)) {
            fs.mkdirSync(dbFolder, { recursive: true });
            console.log('📂 Carpeta de base de datos creada');
        }

        // Inicializar la base de datos
        db = await initializeDatabase(dbPath);
        console.log('📦 Base de datos conectada');

        // Configurar manejadores IPC
        setupIPCHandlers();

        // Crear ventana principal
        createWindow();

    } catch (err) {
        console.error('🔥 Error crítico durante la inicialización:', err);
        app.quit();
    }
}

// Eventos de la aplicación
app.whenReady().then(initializeApp);

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
        createWindow();
    }
});

app.on('window-all-closed', () => {
    // Cerrar conexión a la base de datos si existe
    if (db) {
        db.close((err) => {
            if (err) {
                console.error('Error al cerrar la base de datos:', err);
            } else {
                console.log('🔌 Conexión a la base de datos cerrada');
            }
        });
    }

    if (process.platform !== 'darwin') {
        app.quit();
    }
});

// Manejo de errores no capturados
process.on('uncaughtException', (error) => {
    console.error('⚠️ Error no capturado:', error);
});
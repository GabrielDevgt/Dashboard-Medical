// preload.js
const { contextBridge, ipcRenderer } = require('electron');

// Versión segura con validación básica
const validChannels = [
    'execute-query', 'fetch-all', 'fetch-one'
    // 'minimize-window', 'maximize-window', 'close-window'
];

contextBridge.exposeInMainWorld('electronAPI', {
    // Operaciones de base de datos
    executeQuery: (sql, params = []) => {
        if (typeof sql !== 'string') {
            throw new Error('SQL debe ser un string');
        }
        return ipcRenderer.invoke('execute-query', sql, params);
    },
    fetchAll: (sql, params = []) => {
        if (typeof sql !== 'string') {
            throw new Error('SQL debe ser un string');
        }
        return ipcRenderer.invoke('fetch-all', sql, params);
    },
    fetchOne: (sql, params = []) => {
        if (typeof sql !== 'string') {
            throw new Error('SQL debe ser un string');
        }
        return ipcRenderer.invoke('fetch-one', sql, params);
    },

    // // Control de ventana
    // minimizeWindow: () => ipcRenderer.send('minimize-window'),
    // maximizeWindow: () => ipcRenderer.send('maximize-window'),
    // closeWindow: () => ipcRenderer.send('close-window'),

    // Sistema de eventos seguro
    on: (channel, callback) => {
        if (validChannels.includes(channel)) {
            ipcRenderer.on(channel, (event, ...args) => callback(...args));
        }
    },
    removeListener: (channel, callback) => {
        if (validChannels.includes(channel)) {
            ipcRenderer.removeListener(channel, callback);
        }
    }
});

// Seguridad adicional
contextBridge.exposeInMainWorld('isElectron', true);
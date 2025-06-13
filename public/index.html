<!DOCTYPE html>
<html lang="es">
<head class="custom-titlebar">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Policlínica - Los Angeles</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        button {
            padding: 8px 16px;
            margin: 5px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #45a049;
        }
        #results {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            min-height: 100px;
            background-color: #fafafa;
        }
        .window-controls {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="window-controls">
            <button id="min-btn">Minimizar</button>
            <button id="max-btn">Maximizar</button>
            <button id="close-btn">Cerrar</button>
        </div>

        <h1>Prueba de Conexión Electron-SQLite</h1>
        
        <button id="create-table">Crear Tabla de Prueba</button>
        <button id="insert-data">Insertar Datos</button>
        <button id="get-data">Obtener Datos</button>
        <button id="clear-data">Limpiar Datos</button>
        
        <h3>Resultados:</h3>
        <div id="results"></div>
    </div>

    <script>
        // Función para mostrar resultados
        function logResult(message) {
            const resultsDiv = document.getElementById('results');
            resultsDiv.innerHTML += `<p>${message}</p>`;
        }

        // Control de ventana
        document.getElementById('min-btn').addEventListener('click', () => {
            window.electronAPI.minimizeWindow();
        });

        document.getElementById('max-btn').addEventListener('click', () => {
            window.electronAPI.maximizeWindow();
        });

        document.getElementById('close-btn').addEventListener('click', () => {
            window.electronAPI.closeWindow();
        });

        // Pruebas de base de datos
        document.getElementById('create-table').addEventListener('click', async () => {
            try {
                const sql = `CREATE TABLE IF NOT EXISTS pacientes_test (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nombre TEXT NOT NULL,
                    edad INTEGER,
                    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
                )`;
                
                await window.electronAPI.executeQuery(sql);
                logResult('✅ Tabla creada correctamente');
            } catch (error) {
                logResult(`❌ Error al crear tabla: ${error}`);
            }
        });

        document.getElementById('insert-data').addEventListener('click', async () => {
            try {
                const result = await window.electronAPI.executeQuery(
                    'INSERT INTO pacientes_test (nombre, edad) VALUES (?, ?)',
                    ['Paciente de Prueba', Math.floor(Math.random() * 50) + 20]
                );
                logResult(`✅ Datos insertados. ID: ${result.lastID}`);
            } catch (error) {
                logResult(`❌ Error al insertar datos: ${error}`);
            }
        });

        document.getElementById('get-data').addEventListener('click', async () => {
            try {
                const pacientes = await window.electronAPI.fetchAll(
                    'SELECT * FROM pacientes_test ORDER BY id DESC LIMIT 5'
                );
                
                if (pacientes.length === 0) {
                    logResult('ℹ️ No hay datos en la tabla');
                } else {
                    logResult('📋 Últimos 5 registros:');
                    pacientes.forEach(p => {
                        logResult(`ID: ${p.id}, Nombre: ${p.nombre}, Edad: ${p.edad}`);
                    });
                }
            } catch (error) {
                logResult(`❌ Error al obtener datos: ${error}`);
            }
        });

        document.getElementById('clear-data').addEventListener('click', async () => {
            try {
                await window.electronAPI.executeQuery('DELETE FROM pacientes_test');
                document.getElementById('results').innerHTML = '';
                logResult('🗑️ Todos los datos de prueba fueron eliminados');
            } catch (error) {
                logResult(`❌ Error al limpiar datos: ${error}`);
            }
        });

        // Mostrar versión de la app al cargar
        (async function() {
            try {
                const version = await window.electronAPI.getAppVersion();
                logResult(`Versión de la app: ${version}`);
            } catch (error) {
                console.log('No se pudo obtener la versión:', error);
            }
        })();
    </script>
</body>
</html>
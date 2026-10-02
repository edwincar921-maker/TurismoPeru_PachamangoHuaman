# TurismoPeru_Seguridad_PachamangoHuaman
## Descripción
Este proyecto implementa un mecanismo básico de administración, seguridad y reportes analíticos para el sistema de información de una empresa turística. Incluye la creación de perfiles con el principio de mínimo privilegio, estrategias de importación de datos y la integración de reportes utilizando Python.

## Tecnologías Utilizadas
- SQL Server (T-SQL)
- Utilidad BCP (Bulk Copy Program)
- Python 3.x (pandas, matplotlib, pyodbc, python-dotenv)
- Git y GitHub para control de versiones

## Requisitos
- SQL Server Management Studio (SSMS)
- Python 3 instalado en el sistema.
- ODBC Driver for SQL Server.

## Configuración
Para que los scripts de Python funcionen correctamente, es necesario configurar las variables de entorno. Renombre el archivo `.env.example` a `.env` e ingrese las credenciales de conexión reales de su servidor SQL.

## Estructura del Proyecto

TurismoPeruSeguridad_PachamangoHuaman/
├── README.md
├── .gitignore
├── 01_usuarios_roles/
│   ├── 01_logins.sql
│   ├── 02_users.sql
│   ├── 03_roles.sql
│   └── 04_permisos.sql
├── 02_importacion_exportacion/
│   └── importacion.sql
├── 03_backups/
│   └── TurismoPeru_EJPH_Full.bacpac
├── 04_seguridad/
│   └── pruebas_permisos.sql
├── 05_reportes/
│   └── README.md
├── 06_python/
│   ├── app.py
│   ├── requirements.txt
│   └── .env.example
└── evidencias/
    ├── login.png
    ├── permisos.png
    ├── backup.png
    ├── github.png
    └── reporte.png

## Scripts Disponibles
- **01_logins.sql / 02_users.sql**: Creación de cuentas de acceso y usuarios de base de datos.
- **03_roles.sql / 04_permisos.sql**: Definición de roles (vendedor, analista) y restricciones explícitas (GRANT/DENY).
- **importacion.sql**: Creación de tabla staging y lógica para descartar registros duplicados.
- **pruebas_permisos.sql**: Script de auditoría para verificar las restricciones del rol analista.

## Procedimiento de Restauración
Para restaurar la base de datos:
1. Abrir SQL Server Management Studio (SSMS).
2. Hacer clic derecho sobre la carpeta "Databases" (Bases de datos).
3. Seleccionar "Import Data-tier Application" (Importar aplicación de capa de datos).
4. Buscar y seleccionar el archivo `TurismoPeru_EJPH_Full.bacpac` ubicado en la carpeta `03_backups`.
5. Seguir el asistente hasta completar la restauración.

## Configuración del Reporte
Para ejecutar el reporte analítico en Python:
1. Navegar a la raíz del proyecto.
2. Instalar las dependencias ejecutando: `pip install -r 06_python/requirements.txt`
3. Ejecutar el script: `python 06_python/app.py`
Esto procesará los indicadores y generará los gráficos correspondientes.

## Capturas de Pantalla
Las evidencias de ejecución se encuentran en la carpeta `/evidencias`:
- `login.png`: Logins creados en el servidor.
- `permisos.png`: Prueba de rechazo de INSERT por parte del analista.
- `backup.png`: Generación del archivo bacpac.
- `github.png`: Historial de commits en el repositorio.
- `reporte.png` / `ingresos_metodo.png`: Visualización de los KPIs generados.

##Actividad 4: Principio de Mínimo Privilegio
**¿Por qué no es adecuado asignar db_owner al vendedor o al analista?**
Asignar el rol `db_owner` otorga control total sobre la base de datos, lo que permite eliminar tablas, alterar configuraciones de seguridad, modificar roles y realizar respaldos. Esto viola el Principio de Mínimo Privilegio, el cual establece que un usuario solo debe tener los permisos estrictamente necesarios para realizar sus funciones. El vendedor solo requiere registrar y consultar operaciones comerciales, mientras que el analista solo necesita permisos de lectura (SELECT) para generar reportes. Otorgarles privilegios administrativos expone el sistema a modificaciones accidentales o malintencionadas, robo de información y pérdida de datos críticos.
import os
import pyodbc
import pandas as pd
import matplotlib.pyplot as plt
from dotenv import load_dotenv

# Cargar configuración segura
load_dotenv()
server_raw = os.getenv('DB_SERVER')
server = server_raw.replace('\\\\', '\\') 
database = os.getenv('DB_DATABASE')

print(f"Iniciando prueba de conexión...")
print(f"-> Servidor detectado: {server}")
print(f"-> Base de datos: {database}")

try:
    # 1. Conexión ajustada (Cifrado desactivado para LocalDB)
    connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;Encrypt=no;'
    conn = pyodbc.connect(connection_string)
    
    print("-> ¡CONEXIÓN EXITOSA!"))
    
    # 2. Consulta de datos 
    query = """
    SELECT 
        c.documento, 
        r.id_reserva, r.estado,
        p.monto, p.metodo_pago
    FROM dbo.cliente c
    INNER JOIN dbo.reserva r ON c.documento = r.documento_cliente
    INNER JOIN dbo.pago p ON r.id_reserva = p.id_reserva
    """
    df = pd.read_sql(query, conn)
    
    # 3. Procesamiento de indicadores 
    total_clientes = df['documento'].nunique()
    total_reservas = df['id_reserva'].nunique()
    total_ingresos = df['monto'].sum()
    ticket_promedio = total_ingresos / total_reservas if total_reservas > 0 else 0

    # 4. Visualización 
    os.makedirs('evidencias', exist_ok=True)
    plt.figure(figsize=(8, 5))
    df.groupby('metodo_pago')['monto'].sum().plot(kind='bar', color='#4CAF50')
    plt.title('Ingresos por Medio de Pago')
    plt.ylabel('Monto Total (S/)')
    plt.xlabel('Medio de Pago')
    plt.xticks(rotation=0)
    plt.tight_layout()
    plt.savefig('evidencias/ingresos_metodo.png')
    plt.close()

    # 5. Generación de Reporte HTML
    html_content = f"""
    <html>
    <head><title>Reporte Analítico - TurismoPeru</title></head>
    <body style="font-family: Arial, sans-serif; padding: 20px;">
        <h2>Reporte Analítico de Ventas y Reservas</h2>
        <h3>1. Indicadores Principales:</h3>
        <ul>
            <li><b>Total Clientes:</b> {total_clientes}</li>
            <li><b>Total Reservas:</b> {total_reservas}</li>
            <li><b>Total Ingresos:</b> S/ {total_ingresos:.2f}</li>
            <li><b>Ticket Promedio:</b> S/ {ticket_promedio:.2f}</li>
        </ul>
        <h3>2. Conclusiones:</h3>
        <ol>
            <li>Se observa que el total de ingresos asciende a S/ {total_ingresos:.2f}.</li>
            <li>El ticket promedio por reserva es de S/ {ticket_promedio:.2f}, lo que indica la rentabilidad por cada operación.</li>
            <li>Se analizaron {total_reservas} reservas correspondientes a la participación de {total_clientes} clientes únicos.</li>
            <li>El comportamiento en los medios de pago refleja preferencias claras que pueden orientar futuras promociones.</li>
            <li>La proporción entre clientes y reservas sugiere oportunidades para estrategias de fidelización.</li>
        </ol>
        <h3>3. Gráficos</h3>
        <p>Ingresos clasificados por medio de pago:</p>
        <img src="../evidencias/ingresos_metodo.png" width="600" style="border: 1px solid #ccc;">
    </body>
    </html>
    """
    
    os.makedirs('05_reportes', exist_ok=True)
    with open('05_reportes/reporte.html', 'w', encoding='utf-8') as f:
        f.write(html_content)

    print("¡Procesamiento completo! El gráfico y el reporte HTML se generaron con éxito.")

except Exception as e:
    print(f"Error en la ejecución: {e}")
finally:
    if 'conn' in locals():
        conn.close()
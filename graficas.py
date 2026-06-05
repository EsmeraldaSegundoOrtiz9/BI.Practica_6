import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

load_dotenv()

engine = create_engine(
    f"postgresql+psycopg2://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@"
    f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
)

query = """
SELECT *
FROM data_mart_ventas
ORDER BY total_unidades_vendidas DESC;
"""

df = pd.read_sql(query, engine)

# Gráfica 1
plt.figure(figsize=(10,6))
plt.bar(df['category'], df['total_unidades_vendidas'])
plt.title('Unidades vendidas por categoría')
plt.xlabel('Categoría')
plt.ylabel('Unidades vendidas')
plt.xticks(rotation=25)
plt.tight_layout()

plt.savefig('grafica_unidades_vendidas.png')
print("Gráfica 1 guardada")

plt.close()

# Gráfica 2
plt.figure(figsize=(10,6))
plt.bar(df['category'], df['rating_promedio'])
plt.title('Rating promedio por categoría')
plt.xlabel('Categoría')
plt.ylabel('Rating')
plt.xticks(rotation=25)
plt.tight_layout()

plt.savefig('grafica_rating_promedio.png')
print("Gráfica 2 guardada")

plt.close()
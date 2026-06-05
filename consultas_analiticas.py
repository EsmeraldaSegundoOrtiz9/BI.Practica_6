import pandas as pd
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

print("\nDATA MART DE VENTAS\n")
print(df)

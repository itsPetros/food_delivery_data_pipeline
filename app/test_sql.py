import sqlite3

conn = sqlite3.connect("food_delivery.db")

with open("sql/queries.sql", "r", encoding="utf-8") as file:
    queries = file.read().split(";")

for query in queries:
    query = query.strip()

    if query:
        print("\nRUNNING QUERY:")
        print(query[:50], "...")

        try:
            result = conn.execute(query).fetchall()

            for row in result[:5]:
                print(row)

        except Exception as e:
            print("ERROR:", e)

conn.close()
import sqlite3

def load(customers, restaurants, orders, order_details):

    conn = sqlite3.connect("food_delivery.db")

    customers.to_sql("customers", conn, if_exists="replace", index=False)
    restaurants.to_sql("restaurants", conn, if_exists="replace", index=False)
    orders.to_sql("orders", conn, if_exists="replace", index=False)
    order_details.to_sql("order_details", conn, if_exists="replace", index=False)

    conn.close()
from extract import extract
from transform import transform
from load import load

orders, restaurants = extract()

customers, restaurants_table, orders_table, order_details = transform(
    orders,
    restaurants
)

load(customers, restaurants_table, orders_table, order_details)

print("Pipeline completed successfully.")
import pandas as pd


def transform(orders, restaurants):
    # 0. Initial Cleanup & ID Generation
    orders = orders.drop_duplicates()
    restaurants = restaurants.drop_duplicates()

    # Generate a unique customer ID using factorization
    orders["CustomerID"] = orders["Customer Name"].factorize()[0] + 1

    # 1. Customers Table
    # Extract unique customer mappings using a clean method chain
    customers = (
        orders[["CustomerID", "Customer Name"]]
        .drop_duplicates()
        .rename(columns={"Customer Name": "CustomerName"})
    )

    # 2. Restaurants Table
    # Standardize column layouts if needed (keeps original structure)
    restaurants_table = restaurants.rename(
        columns={
            "RestaurantID": "RestaurantID",
            "RestaurantName": "RestaurantName",
            "Cuisine": "Cuisine",
            "Zone": "Zone",
            "Category": "Category",
        }
    )

    # 3. Orders Table (Main Fact Table)
    # Isolate core transaction metrics
    orders_table = orders[[
        "Order ID",
        "CustomerID",
        "Restaurant ID",
        "Order Date",
        "Order Amount",
        "Payment Mode",
        "Delivery Time Taken (mins)",
    ]].copy()

    orders_table.columns = [
        "OrderID",
        "CustomerID",
        "RestaurantID",
        "OrderDate",
        "OrderAmount",
        "PaymentMode",
        "DeliveryTime",
    ]
    
    # 4. Order Details Table (Ratings & Items)
    # Isolate order fulfillment specifics
    order_details = orders[[
        "Order ID",
        "Quantity of Items",
        "Customer Rating-Food",
        "Customer Rating-Delivery",
    ]].copy()

    order_details.columns = [
        "OrderID",
        "QuantityItems",
        "FoodRating",
        "DeliveryRating",
    ]

    return customers, restaurants_table, orders_table, order_details

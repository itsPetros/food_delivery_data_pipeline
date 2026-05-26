def transform(orders, restaurants):

    # basic cleanup
    orders = orders.drop_duplicates()
    restaurants = restaurants.drop_duplicates()

    # create a simple customer id (since dataset doesn't have one)
    orders["CustomerID"] = (
        orders["Customer Name"].factorize()[0] + 1
    )

    # -------------------------
    # 1. Customers table
    # -------------------------
    customers = orders[[
        "CustomerID",
        "Customer Name"
    ]].drop_duplicates()

    customers.columns = [
        "CustomerID",
        "CustomerName"
    ]

    # -------------------------
    # 2. Restaurants table (clean rename)
    # -------------------------
    restaurants_table = restaurants.rename(columns={
        "RestaurantID": "RestaurantID",
        "RestaurantName": "RestaurantName",
        "Cuisine": "Cuisine",
        "Zone": "Zone",
        "Category": "Category"
    })

    # -------------------------
    # 3. Orders table (main fact table)
    # -------------------------
    orders_table = orders[[
        "Order ID",
        "CustomerID",
        "Restaurant ID",
        "Order Date",
        "Order Amount",
        "Payment Mode",
        "Delivery Time Taken (mins)"
    ]].copy()

    orders_table.columns = [
        "OrderID",
        "CustomerID",
        "RestaurantID",
        "OrderDate",
        "OrderAmount",
        "PaymentMode",
        "DeliveryTime"
    ]

    # -------------------------
    # 4. Order details table (ratings + items)
    # -------------------------
    order_details = orders[[
        "Order ID",
        "Quantity of Items",
        "Customer Rating-Food",
        "Customer Rating-Delivery"
    ]].copy()

    order_details.columns = [
        "OrderID",
        "QuantityItems",
        "FoodRating",
        "DeliveryRating"
    ]

    return customers, restaurants_table, orders_table, order_details
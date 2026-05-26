CREATE TABLE IF NOT EXISTS customers (
    CustomerID   INTEGER PRIMARY KEY,
    CustomerName TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS restaurants (
    RestaurantID   INTEGER PRIMARY KEY,
    RestaurantName TEXT    NOT NULL,
    Cuisine        TEXT,
    Zone           TEXT,
    Category       TEXT    CHECK (Category IN ('Pro', 'Ordinary'))
);

CREATE TABLE IF NOT EXISTS orders (
    OrderID       TEXT    PRIMARY KEY,
    CustomerID    INTEGER NOT NULL REFERENCES customers(CustomerID),
    RestaurantID  INTEGER NOT NULL REFERENCES restaurants(RestaurantID),
    OrderDate     TEXT    NOT NULL,   -- stored as 'M/D/YYYY HH:MM'
    OrderAmount   REAL    NOT NULL CHECK (OrderAmount >= 0),
    PaymentMode   TEXT,
    DeliveryTime  INTEGER CHECK (DeliveryTime >= 0)  -- minutes
);

CREATE TABLE IF NOT EXISTS order_details (
    OrderID       TEXT    PRIMARY KEY REFERENCES orders(OrderID),
    QuantityItems INTEGER CHECK (QuantityItems > 0),
    FoodRating    INTEGER CHECK (FoodRating BETWEEN 1 AND 5),
    DeliveryRating INTEGER CHECK (DeliveryRating BETWEEN 1 AND 5)
);

CREATE INDEX IF NOT EXISTS idx_orders_customer    ON orders(CustomerID);
CREATE INDEX IF NOT EXISTS idx_orders_restaurant  ON orders(RestaurantID);
CREATE INDEX IF NOT EXISTS idx_orders_date        ON orders(OrderDate);

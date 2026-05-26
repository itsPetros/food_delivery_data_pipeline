import pandas as pd


def extract():
    orders = pd.read_csv("data/orders.csv")
    restaurants = pd.read_csv("data/restaurants.csv")

    return orders, restaurants
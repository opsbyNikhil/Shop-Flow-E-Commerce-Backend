from django.urls import path

from .views import (
    home,
    categories,
    products,
    product_detail,
    health_check
)


urlpatterns = [

    path(
        "",
        home,
        name="home"
    ),

    path(
        "categories/",
        categories,
        name="categories"
    ),

    path(
        "products/",
        products,
        name="products"
    ),

    path(
        "products/<int:product_id>/",
        product_detail,
        name="product-detail"
    ),

    path(
        "health/", 
        health_check, 
        name="health_check"
    ),

]
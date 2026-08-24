from django.urls import path
from .views import (
    ProfileView,
    ProfileDetailView,
    CreateProfileView,
    UpdateProfileView,
    DeleteProfileView,
)

urlpatterns = [
    path("", ProfileView.as_view(), name="profile-list"),
    path("create/", CreateProfileView.as_view(), name="create-profile"),
    path("<int:user_id>/", ProfileDetailView.as_view(), name="profile-detail"),
    path("update/<int:user_id>/", UpdateProfileView.as_view(), name="update-profile"),
    path("delete/<int:user_id>/", DeleteProfileView.as_view(), name="delete-profile"),
]
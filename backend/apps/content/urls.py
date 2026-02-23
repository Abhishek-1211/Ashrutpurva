from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CategoryViewSet, PoemViewSet, EventViewSet, 
    MediaCoverageViewSet, BlogViewSet, VideoViewSet, BookViewSet
)

router = DefaultRouter()
router.register(r'categories', CategoryViewSet)
router.register(r'poems', PoemViewSet)
router.register(r'events', EventViewSet)
router.register(r'media-coverage', MediaCoverageViewSet)
router.register(r'blogs', BlogViewSet)
router.register(r'videos', VideoViewSet)
router.register(r'books', BookViewSet)

urlpatterns = [
    path('', include(router.urls)),
]

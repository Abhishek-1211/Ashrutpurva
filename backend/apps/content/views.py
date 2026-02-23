from rest_framework import viewsets, permissions, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Category, Poem, Event, MediaCoverage, Blog, Video, Book, Engagement
from .serializers import (
    CategorySerializer, PoemSerializer, EventSerializer, 
    MediaCoverageSerializer, BlogSerializer, VideoSerializer, BookSerializer
)

class ContentBaseViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = [permissions.AllowAny]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    ordering_fields = ['created_at', 'title']
    ordering = ['-created_at']

class CategoryViewSet(ContentBaseViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    search_fields = ['name']

class PoemViewSet(ContentBaseViewSet):
    queryset = Poem.objects.filter(is_published=True)
    serializer_class = PoemSerializer
    filterset_fields = ['category']
    search_fields = ['title', 'content']

    @action(detail=True, methods=['post'], permission_classes=[permissions.IsAuthenticated])
    def like(self, request, pk=None):
        poem = self.get_object()
        engagement, created = Engagement.objects.get_or_create(user=request.user, poem=poem)
        engagement.is_liked = not engagement.is_liked
        engagement.save()
        return Response({'is_liked': engagement.is_liked}, status=status.HTTP_200_OK)

    @action(detail=True, methods=['post'], permission_classes=[permissions.IsAuthenticated])
    def bookmark(self, request, pk=None):
        poem = self.get_object()
        engagement, created = Engagement.objects.get_or_create(user=request.user, poem=poem)
        engagement.is_bookmarked = not engagement.is_bookmarked
        engagement.save()
        return Response({'is_bookmarked': engagement.is_bookmarked}, status=status.HTTP_200_OK)

class EventViewSet(ContentBaseViewSet):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    search_fields = ['title', 'description']

class MediaCoverageViewSet(ContentBaseViewSet):
    queryset = MediaCoverage.objects.all()
    serializer_class = MediaCoverageSerializer
    search_fields = ['title', 'source_name']

class BlogViewSet(ContentBaseViewSet):
    queryset = Blog.objects.all()
    serializer_class = BlogSerializer
    search_fields = ['title']

class VideoViewSet(ContentBaseViewSet):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer
    search_fields = ['title']

class BookViewSet(ContentBaseViewSet):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    search_fields = ['title']

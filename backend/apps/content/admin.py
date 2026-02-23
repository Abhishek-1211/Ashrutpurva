from django.contrib import admin
from .models import Category, Poem, Event, MediaCoverage, Blog, Video, Book, Engagement

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)

@admin.register(Poem)
class PoemAdmin(admin.ModelAdmin):
    list_display = ('title', 'category', 'created_at', 'is_published')
    list_filter = ('category', 'is_published')
    search_fields = ('title', 'content')

@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('title', 'date_time', 'location', 'is_notified')
    list_filter = ('date_time', 'is_notified')
    search_fields = ('title', 'description')

admin.site.register(MediaCoverage)
admin.site.register(Blog)
admin.site.register(Video)
admin.site.register(Book)
admin.site.register(Engagement)

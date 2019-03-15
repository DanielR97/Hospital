from django.urls import path
from .views import list_appointments, create_appointment, update_appointment, cancel_appointment, stats


urlpatterns = [
        path('', list_appointments, name='list_appointments'),
        path('new', create_appointment, name='create_appointment'),
        path('stats', stats, name='stats'),
        path('update/<int:id>/', update_appointment, name='update_appointment'),
        path('cancel/<int:id>/', cancel_appointment, name='cancel_appointment'),
]


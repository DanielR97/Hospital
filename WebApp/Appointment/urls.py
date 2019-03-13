from django.urls import path
from .views import list_appointments, create_appointment, update_appointment, cancel_appointment

urlpatterns = [
        path('', list_appointments, name='list_appointments'),
        path('new', create_appointment, name='create_appointment'),
        path('update/<int:id>/', update_appointment, name='update_appointment'),
        path('cancel/<int:id>/', cancel_appointment, name='cancel_appointment'),
]


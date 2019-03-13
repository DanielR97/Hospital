from django.contrib import admin
from .models import Appointment

admin.site.register(Appointment)
admin.site.index_title = "Doctor"
admin.site.site_header = "Hospital"


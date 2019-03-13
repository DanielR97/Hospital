from django.contrib import admin
from .models import Appointment
from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.auth.models import User

admin.site.unregister(Group)
admin.site.unregister(User)
admin.site.register(Appointment)
admin.site.index_title = "Doctor"
admin.site.site_header = "Hospital"

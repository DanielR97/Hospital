from django.shortcuts import render, redirect
from .models import Appointment
from .forms import AppointmentForm
from django.contrib.auth.decorators import user_passes_test
def staff_required(login_url=None):
    return user_passes_test(lambda u: u.is_staff, login_url=login_url)

@staff_required(login_url="../admin")
def list_appointments(request):
    appointments = Appointment.objects.all()
    return render(request, 'appointments.html', {'appointments': appointments})

def create_appointment(request):
    form = AppointmentForm(request.POST or None)
    
    if form.is_valid():
        form.save()
        return redirect('list_appointments')

    return render(request, 'appointment-form.html', {'form': form})

def update_appointment(request, id):
    appointment = Appointment.objects.get(id=id)
    form = AppointmentForm(request.POST or None, instance=appointment)

    if form.is_valid():
        form.save()
        return redirect('list_appointments')

    return render(request, 'appointment-form.html', {'form': form, 'appointment': appointment})

def cancel_appointment(request,id):
    appointment = Appointment.objects.get(id=id)

    if request.method == 'POST':
        appointment.delete()
        return redirect('list_appointments')

    return render(request, 'appointment-cancel-confirm.html', {'appointment': appointment})


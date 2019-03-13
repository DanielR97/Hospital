from django.shortcuts import render, redirect
from .models import Appointment
from .forms import AppointmentForm

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


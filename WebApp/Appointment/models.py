from django.db import models

class Appointment(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)
    reason = models.CharField(db_column='Reason', max_length=255)
    date = models.DateField(db_column='Date')
    patient = models.CharField(db_column='Patient', max_length=9)
    doctor = models.CharField(db_column='Doctor', max_length=9)
    room = models.CharField(db_column='Room', max_length=4)

    def __str__(self):
        return str(self.id)
    class Meta:
        managed = False
        db_table = 'Appointment'


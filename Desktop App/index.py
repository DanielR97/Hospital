import tkinter.messagebox as tkMessageBox
import tkinter.ttk as ttk
from tkinter import *
import pymysql

root = Tk()
root.title("Hospital")
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
width = 1115
height = 320
x = (screen_width / 2) - (width / 2)
y = (screen_height / 2) - (height / 2)
img = PhotoImage(file='icon.png')
root.tk.call('wm', 'iconphoto', root._w, img)
root.geometry('%dx%d+%d+%d' % (width, height, x, y))
root.resizable(True, True)


def database():
    global conn, cursor
    conn = pymysql.connect(host='localhost', user='doctor', password='0000',
                           db='Hospital')
    cursor = conn.cursor()


def create():
    if DATE.get() == "" or REASON.get() == "" or PATIENT.get() == "" or DOCTOR.get() == "":
        txt_result.config(text="Please, complete the form", fg="red")
    else:
        database()
        cursor.execute(
            "INSERT INTO `hospital_appointment` (`date`, `reason`, `patient`, `doctor`, `room`)"
            "VALUES(%s, %s, %s, %s, (SELECT room from hospital_doctor WHERE id=%s ))",
            (str(DATE.get()), str(REASON.get()), str(PATIENT.get()), str(DOCTOR.get()), str(DOCTOR.get())))
        tree.delete(*tree.get_children())
        cursor.execute("SELECT * FROM `hospital_appointment` ORDER BY `id` ASC")
        fetch = cursor.fetchall()
        for data in fetch:
            tree.insert('', 'end', values=(data[0], data[1], data[2], data[3], data[4], data[5]))
        conn.commit()
        DATE.set("")
        REASON.set("")
        PATIENT.set("")
        DOCTOR.set("")
        cursor.close()
        conn.close()
        txt_result.config(text="Appointment created", fg="green")


def list_appointments():
    tree.delete(*tree.get_children())
    database()
    cursor.execute("SELECT * FROM `hospital_appointment` ORDER BY `id` ASC")
    fetch = cursor.fetchall()
    for data in fetch:
        tree.insert('', 'end', values=(data[0], data[1], data[2], data[3], data[4], data[5]))
    cursor.close()
    conn.close()
    txt_result.config(text="Appointments listed", fg="black")


def modify():
    database()
    tree.delete(*tree.get_children())
    cursor.execute(
        "UPDATE `hospital_appointment` SET `date` = %s, `reason` = %s, `patient` = %s,  `doctor` = %s,"
        " `room` = (SELECT room from hospital_doctor WHERE id=%s ) WHERE `id` = %s",
        (str(DATE.get()), str(REASON.get()), str(PATIENT.get()), str(DOCTOR.get()), str(DOCTOR.get()),
         int(id)))
    conn.commit()
    cursor.execute("SELECT * FROM `hospital_appointment` ORDER BY `id` ASC")
    fetch = cursor.fetchall()
    for data in fetch:
        tree.insert('', 'end', values=(data[0], data[1], data[2], data[3], data[4], data[5]))
    cursor.close()
    conn.close()
    DATE.set("")
    REASON.set("")
    PATIENT.set("")
    DOCTOR.set("")
    btn_create.config(state=NORMAL)
    btn_list_appointments.config(state=NORMAL)
    btn_modify.config(state=DISABLED)
    btn_delete.config(state=NORMAL)
    txt_result.config(text="Appointment successfully modified", fg="black")


def on_selected(event):
    global id
    cur_item = tree.focus()
    contents = (tree.item(cur_item))
    selected_item = contents['values']
    print(selected_item)
    id = selected_item[0]
    REASON.set("")
    DATE.set("")
    PATIENT.set("")
    DOCTOR.set("")
    REASON.set(selected_item[1])
    DATE.set(selected_item[2])
    PATIENT.set(selected_item[3])
    DOCTOR.set(selected_item[4])
    btn_create.config(state=DISABLED)
    btn_list_appointments.config(state=DISABLED)
    btn_modify.config(state=NORMAL)
    btn_delete.config(state=DISABLED)


def delete():
    if not tree.selection():
        txt_result.config(text="Please select an appointment first", fg="red")
    else:
        result = tkMessageBox.askquestion('Hospital', 'Do you really want to cancel the selected appointment?',
                                          icon="warning")
        if result == 'yes':
            cur_item = tree.focus()
            contents = (tree.item(cur_item))
            selected_item = contents['values']
            tree.delete(cur_item)
            database()
            cursor.execute("DELETE FROM `hospital_appointment` WHERE `id` = %d" % selected_item[0])
            conn.commit()
            cursor.close()
            conn.close()
            txt_result.config(text="Appointment successfully canceled", fg="black")
        if result == 'no':
            txt_result.config(text="Appointments listed", fg="black")


def close_window():
    result = tkMessageBox.askquestion('Hospital', 'Are you sure to exit?', icon="warning")
    if result == 'yes':
        root.destroy()


DATE = StringVar()
REASON = StringVar()
PATIENT = StringVar()
DOCTOR = StringVar()

Top = Frame(root, width=900, height=50, bd=2, relief="raise")
Top.pack(side=TOP)
Left = Frame(root, width=300, height=500, bd=2, relief="raise")
Left.pack(side=LEFT)
Right = Frame(root, width=600, height=500, bd=2, relief="raise")
Right.pack(side=RIGHT)
Forms = Frame(Left, width=300, height=450)
Forms.pack(side=TOP)
Buttons = Frame(Left, width=300, height=100, bd=2, relief="raise")
Buttons.pack(side=BOTTOM)

txt_title = Label(Top, width=900, font=('arial', 16), text="Appointments")
txt_title.pack()
txt_date = Label(Forms, text="Date (YMD):", font=('arial', 16), bd=15)
txt_date.grid(row=0, sticky="e")
txt_reason = Label(Forms, text="Reason:", font=('arial', 16), bd=15)
txt_reason.grid(row=1, sticky="e")
txt_patient = Label(Forms, text="Patient:", font=('arial', 16), bd=15)
txt_patient.grid(row=2, sticky="e")
txt_doctor = Label(Forms, text="Doctor:", font=('arial', 16), bd=15)
txt_doctor.grid(row=3, sticky="e")
txt_result = Label(Buttons)
txt_result.pack(side=TOP)

date = Entry(Forms, textvariable=DATE, width=30)
date.grid(row=0, column=1)
reason = Entry(Forms, textvariable=REASON, width=30)
reason.grid(row=1, column=1)
patient = Entry(Forms, textvariable=PATIENT, width=30)
patient.grid(row=2, column=1)
doctor = Entry(Forms, textvariable=DOCTOR, width=30)
doctor.grid(row=3, column=1)

btn_create = Button(Buttons, width=10, text="Create", command=create)
btn_create.pack(side=LEFT)
btn_list_appointments = Button(Buttons, width=10, text="List", command=list_appointments)
btn_list_appointments.pack(side=LEFT)
btn_modify = Button(Buttons, width=10, text="Modify", command=modify, state=DISABLED)
btn_modify.pack(side=LEFT)
btn_delete = Button(Buttons, width=10, text="Cancel", command=delete)
btn_delete.pack(side=LEFT)

scrollbar_y = Scrollbar(Right, orient=VERTICAL)
scrollbar_x = Scrollbar(Right, orient=HORIZONTAL)
tree = ttk.Treeview(Right, columns=("ID", "Date", "Reason", "Patient", "Doctor", "Room"),
                    selectmode="extended", height=500, yscrollcommand=scrollbar_y.set, xscrollcommand=scrollbar_x.set)
scrollbar_y.config(command=tree.yview)
scrollbar_y.pack(side=RIGHT, fill=Y)
scrollbar_x.config(command=tree.xview)
scrollbar_x.pack(side=BOTTOM, fill=X)
tree.heading('ID', text="ID", anchor=W)
tree.heading('Date', text="Date", anchor=W)
tree.heading('Reason', text="Reason", anchor=W)
tree.heading('Patient', text="Patient", anchor=W)
tree.heading('Doctor', text="Doctor", anchor=W)
tree.heading('Room', text="Room", anchor=W)
tree.column('#0', stretch=NO, minwidth=0, width=0)
tree.column('#1', stretch=NO, minwidth=0, width=40)
tree.column('#2', stretch=NO, minwidth=0, width=120)
tree.column('#3', stretch=NO, minwidth=0, width=200)
tree.column('#4', stretch=NO, minwidth=0, width=120)
tree.column('#5', stretch=NO, minwidth=0, width=120)
tree.column('#6', stretch=NO, minwidth=0, width=60)
tree.pack()
tree.bind('<Double-Button-1>', on_selected)

root.protocol("WM_DELETE_WINDOW", close_window)

if __name__ == '__main__':
    list_appointments()
    root.mainloop()

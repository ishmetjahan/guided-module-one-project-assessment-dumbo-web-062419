Teacher.destroy_all
Student.destroy_all
Enrollment.destroy_all
Classroom.destroy_all

# %w(Kim Jim Bill Will).each do |name|
#     Teacher.create(name: name)
# end
tom= Teacher.create(name:"Tom")
frank= Teacher.create(name:"Frank")

abby= Student.create(name:"Abby")
ben= Student.create(name:"Ben")
jane= Student.create(name:"Jane")

Classroom.create(name:"Art", teacher_id:tom.id, student_id:ben.id)
Classroom.create(name:"Dance", teacher_id:frank.id, student_id:abby.id)
Classroom.create(name:"Music", teacher_id:frank.id, student_id:jane.id)


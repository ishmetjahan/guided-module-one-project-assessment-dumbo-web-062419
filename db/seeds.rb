Teacher.destroy_all
Student.destroy_all
Enrollment.destroy_all
Classroom.destroy_all

ishmet= Teacher.create(name: "Ishmet")
jahan= Teacher.create(name: "Jahan")
jim= Teacher.create(name: "Jimmy")


john1= Student.create(name:"John Doe")
john2= Student.create(name:"Kim Doe")
john3= Student.create(name:"Dim Doe")
john4= Student.create(name:"Peep Doe")
smith1= Student.create(name:"Macy Smith")
smith2= Student.create(name:"Peter Smith")
smith3= Student.create(name:"Jane Smith")

math1= Classroom.create(name:"Math", teacher_id:ishmet)
music= Classroom.create(name:"Music", teacher_id:ishmet)
art1= Classroom.create(name:"Art", teacher_id:jahan.id)
code1= Classroom.create(name:"Code", teacher_id:jahan.id)
art2= Classroom.create(name:"Art", teacher_id:jim.id)

Enrollment.create(student_id:john1.id,classroom_id:art1.id)
Enrollment.create(student_id:john2.id,classroom_id:art1.id)
Enrollment.create(student_id:john3.id,classroom_id:art1.id)
Enrollment.create(student_id:john4.id,classroom_id:art1.id)
Enrollment.create(student_id:john1.id,classroom_id:math1.id)
Enrollment.create(student_id:john4.id,classroom_id:math1.id)
Enrollment.create(student_id:smith2.id,classroom_id:math1.id)
Enrollment.create(student_id:smith1.id,classroom_id:math1.id)



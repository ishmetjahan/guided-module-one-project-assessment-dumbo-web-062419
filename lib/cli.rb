    #require_relative "../db/migrate/seeds.rb"
class Interface

    def initialize 
        @prompt= TTY::Prompt.new
    end

    def login_menu
        puts `clear`
        puts "Welcome to Happy Camp 2019 😃"
        puts " "
        pid = fork{ exec 'afplay', 'lib/Happiness_music.mp3' } 
        @prompt.select "Are you a teacher or a student?" do |menu|
            menu.choice "Teacher", -> do
                puts "  "
                teacher_name = @prompt.ask "What is your name?"
               if Teacher.find_by(name: teacher_name) == nil 
                @current_user = Teacher.create(name: teacher_name)
               else
                @current_user = Teacher.find_by(name: teacher_name)
               end
               main_menu
            end

            menu.choice "Student", -> do
                puts " "
                student_name = @prompt.ask "What is your name?"
                if Student.find_by(name: student_name) == nil 
                    @current_student_user = Student.create(name: student_name)
                   else
                    @current_student_user = Student.find_by(name: student_name)
                   end
                student_menu    
            end
        end
    end

    def main_menu
        puts `clear`
        @prompt.select "What would you like to do?" do |menu|
            menu.choice "Create New Class", -> do 
                create_classrooms
            end
            menu.choice "View students in your class", -> do
                list_classrooms
            end
            menu.choice "Update a Class", -> do 
                update_classrooms
            end
            menu.choice "Remove a Class", -> do
                remove_classrooms
            end
            menu.choice "Exit"
        end
    
    end

    def student_menu
        puts `clear`
        puts "-----------------------------------------"
        puts "SORRY work in Progress- will be up shortly"
        puts "------------------------------------"
        @prompt.select "What would you like to do?" do |menu|
            menu.choice "Enroll New Class", -> do
                enroll_in_classrooms
            end
            menu.choice "Exit"
        end
    end

    def enroll_in_classrooms
        new_subject = @prompt.ask "Would you like to enroll in a random class?" 
        if new_subject == "Yes"
            randomclass = Classroom.all
            new_class = Enrollment.create(student_id:@current_student_user.id, classroom_id:randomclass.sample.id)
        else
           puts "Please return later for more class options"
        end
        #binding.pry
        student_menu
    end

    def create_classrooms
        new_subject= @prompt.ask "What would you like to teach?" 
        new_class = Classroom.create(name: new_subject, teacher_id: @current_user.id)
        main_menu
    end

    def list_classrooms
        @prompt.select "For which class would you like to see a list of students?" do |menu|
           @all_subjects = @current_user.classrooms.each do |classroom|
                menu.choice classroom.name, -> do
                    list_students_for_classroom(classroom)
                end
            end

            menu.choice "Back", -> { main_menu }
        end

    end

    def list_students_for_classroom(classroom)
        puts `clear`
        if classroom.students.empty?
            puts "No students enrolled in this class yet..."
        else
            puts "Here is the list of students enrolled in this class:"
            puts " "
            puts classroom.students.pluck(:name)
        end
        @prompt.select "" do |menu| 
            menu.choice "Back", -> { main_menu } 
        end
    end

    def update_classrooms
        new_name= @prompt.ask "Please enter a name that you would like to call your new class."
        @prompt.select("Please select the class that you would like to update") do |menu|
        @current_user.classroom_instance.each do |subject|
            menu.choice subject.name, -> {subject.update(name: new_name)}
            end
        end
        binding.pry
    end

    def remove_classrooms
        @prompt.select("Please select the class that you would like to update") do |menu|
            @current_user.classroom_instance.each do |subject|
            menu.choice subject.name, -> { subject.destroy }
            end
        end 
        #need to add a reload or refresh button
    end

end
require_relative '../config/environment'
require 'tty-prompt'
require 'pry'
ActiveRecord::Base.logger = nil
puts "Welcome Happy Camp 2019 😀"
class Interface

    def initialize 
        @prompt= TTY::Prompt.new
    end

    def login_menu
        puts `clear`
        @prompt.select "Are you a teacher or a student?" do |menu|
            menu.choice "Teacher", -> do
                teacher_name = @prompt.ask "What is your name?"
                @current_user = Teacher.find_by(name: teacher_name)
                main_menu
            end

            menu.choice "Student", -> do
                # logic for students
            end
        end
    end

    def main_menu
        puts `clear`
        @prompt.select "What would you like to do?" do |menu|
            menu.choice "Create New Class"
            menu.choice "View Students in Class", -> do
                list_classrooms
            end
            menu.choice "Update a Class"
            menu.choice "Remove a Class"
            menu.choice "Exit"
        end
    end

    def list_classrooms
        @prompt.select "Which class do you want to see students for?" do |menu|
            @current_user.classrooms.each do |classroom|
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
            puts "----------------------------------------------------"
            puts classroom.students.pluck(:name)
        end
        @prompt.select "" do |menu| 
            menu.choice "Back", -> { main_menu } 
        end
    end
end

cli = Interface.new
cli.login_menu


#binding.pry

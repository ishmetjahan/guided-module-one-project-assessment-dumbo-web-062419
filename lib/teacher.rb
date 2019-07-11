class Teacher < ActiveRecord::Base 
    has_many :classrooms
    has_many :students, through: :classrooms

    def classroom_names
        self.classrooms.map {|classroom| classroom }
    end

end
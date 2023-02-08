require './person'
require './classroom'

class Student < Person
  def initialize(classroom, age, name, parent_permission, id = Random.rand(1..1000))
    super(age, name, id, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end

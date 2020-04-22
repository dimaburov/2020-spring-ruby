# frozen_string_literal: true

class StudentList
  def initialize
    @student = []
  end

  def add(stud)
    @student.push(stud)
  end

  def iterator_losers
    arr = @student.select { |t| t.score < 21 }

    return arr.enum_for(:each) unless block_given?

    arr.each do |array|
      yield array
    end
  end

  def test(clas_st)
    a = 0
    countA = 0
    @student.each do |stud|
      if stud.clas == clas_st
        a += 1
        countA += stud.score
      end
    end
    "#{clas_st} #{a}, #{countA}\n"
  end

  def test_bloc
    clas = ''
    str = ''
    @student.each do |stud|
      next if clas == stud.clas

      clas = stud.clas
      str += test(stud.clas)
    end
    str
  end

  def new_table_score(score3, score4, score5)
    clas = ''
    str = ''
    @student.each do |stud|
      next if clas == stud.clas

      clas = stud.clas
      str += clas_score(stud.clas, score3, score4, score5)
    end
    str
  end

  def clas_score(clas, score3, score4, score5)
    arr = @student.select { |t| t.clas == clas }
    count2 = 0
    count3 = 0
    count4 = 0
    count5 = 0
    arr.each do |stud|
      count2 += 1 if stud.score.to_i < score3.to_i
      if stud.score.to_i >= score3.to_i && stud.score.to_i < score4.to_i
        count3 += 1
      end
      if stud.score.to_i >= score4.to_i && stud.score.to_i < score5.to_i
        count4 += 1
      end
      count5 += 1 if stud.score.to_i >= score5.to_i
    end
    "#{clas} 2: #{count2} 3: #{count3} 4: #{count4} 5: #{count5}\n"
  end
end

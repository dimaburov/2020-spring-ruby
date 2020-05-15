# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_side_lengths(row_author, row_title, row_date)
    author = row_author || ''
    title = row_title || ''
    date = row_date || ''
    error = [].concat(check_author(author))
              .concat(check_title(title))
              .concat(check_date(date))
    {
      author: author,
      title: title,
      date: date,
      error: error
    }
  end

  def self.check_author(author)
    if author.empty?
      ['Поле с именем автора пусто']
    else
      []
    end
  end

  def self.check_title(title)
    if title.empty?
      ['Поле с названием произведения пусто']
    else
      []
    end
  end

  def self.check_month_day(date)
    if (date.slice(5..6).to_i > 12) || date.slice(5..6).to_i.negative?
      ['В поле дата переданы некоректные данные, поле ждёт, что в году 12 месяцев']
    elsif (date.slice(8..9).to_i > 31) || date.slice(8..9).to_i.negative?
      ['В поле дата переданы некоректные данные, поле ждёт, что в месяце 31 день']
    else
      []
    end
  end

  def self.check_date(date)
    if /\d{4}-\d{2}-\d{2}/ =~ date
      check_month_day(date)
    else
      ['Дата должна быть передана в формате ГГГГ-ММ-ДД']
    end
  end

  def self.check_side_year(row_year)
    year=row_year || ''
    error=[].concat(check_year(year))
    {
      year: year,
      error: error
    }
  end

  def self.check_year(year)
    if year.empty?
    ['Поле с отчётным годом пусто']
    else 
      unless /\d{4}/ =~ year then
        ['Год должен быть формата ГГГГ']
      else
        []
      end
    end
  end
end

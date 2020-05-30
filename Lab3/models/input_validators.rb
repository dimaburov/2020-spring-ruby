# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_side_lengths(row_author, row_title,
                              row_date,
                              row_format, row_sizes,
                              row_point, row_txt)
    author = row_author || ''
    title = row_title || ''
    date = row_date || ''
    formats = row_format || ''
    sizes = row_sizes || ''
    point = row_point || ''
    txt = row_txt || ''

    error = [].concat(check_author(author))
              .concat(check_title(title))
              .concat(check_date(date))
              .concat(check_formats_size(formats, sizes))
              .concat(point(point))
              .concat(check_txt(txt))
    {
      author: author,
      title: title,
      date: date,
      formats: formats,
      sizes: sizes,
      point: point,
      txt: txt,
      error: error
    }
  end

  def self.check_side_format(row_formats)
    formats = row_formats || ''
    error = [].concat(check_format(formats))
    {
      formats: formats,
      error: error
    }
  end

  def self.check_format(formats)
    if formats.empty?
      ['Поле сортировки пусто']
    else
      []
    end
  end

  def self.check_formats_size(formats, sizes)
    if formats.empty?
      ['Поле с форматом не должно быть пустым']
    elsif formats == 'Бумажная книга'
      check_size(sizes)
    elsif formats == 'Электронная книга'
      check_size(sizes)
    elsif formats == 'Аудио книга'
      check_size(sizes)
    else
      ['Формат чтения должен быть : бумажная книга, электронная , аудио']
    end
  end

  def self.check_size(sizes)
    if sizes.empty?
      ['Поле с размером не должно быть пустым']
    elsif /\d/ =~ sizes
      []
    else
      ['В поле размер должно быть число']
    end
  end

  def self.point(point)
    if (point.to_i > 10) || point.to_i.negative?
      ['Оценка должна быть от 0 до 10']
    else
      []
    end
  end

  def self.check_txt(txt)
    if txt.size > 2000
      ['Размер текста должен быть не больше 2000 символов']
    else
      []
    end
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
    if date.slice(0..4).to_i > 9999
      ['Дата должна быть передана в формате ГГГГ-ММ-ДД']
    elsif (date.slice(5..6).to_i > 12) || date.slice(5..6).to_i <= 0
      ['Поле дата ждёт, что в году 12 месяцев, год начинается 01 месяца']
    elsif (date.slice(8..9).to_i > 31) || date.slice(8..9).to_i <= 0
      ['Поле дата ждёт, что в месяце 31 день, месяц начинается с 01 дня']
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

  def self.check_side_year(row_year, array_year)
    year = row_year || ''
    error = [].concat(check_year(year, array_year))
    {
      year: year,
      error: error
    }
  end

  def self.check_year_other(year, array_year)
    flag_year = false
    array_year.each do |years|
      flag_year = true if year.to_i == years.to_i
    end
    if flag_year
      []
    else
      ['Введённый год не совпадает с теми, за которые есть информация']
    end
  end

  def self.check_year(year, array_year)
    if year.empty?
      []
    elsif /\d{4}/ =~ year
      if /\d{5}/ =~ year
        ['Год должен быть формата ГГГГ']
      else
        check_year_other(year, array_year)
      end
    else
      ['Год должен быть формата ГГГГ']
    end
  end
end

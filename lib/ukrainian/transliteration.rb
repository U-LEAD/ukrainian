# encoding: utf-8

module Ukrainian
  module Transliteration
    extend self

    # https://uk.wikipedia.org/wiki/%D0%A2%D1%80%D0%B0%D0%BD%D1%81%D0%BB%D1%96%D1%82%D0%B5%D1%80%D0%B0%D1%86%D1%96%D1%8F
    LOWER_RULES = {
      'а'=>'a',  'б'=>'b',    'в'=>'v',  'г'=>'h',
      'ґ'=>'g',  'д'=>'d',    'е'=>'e',  'є'=>'ie',
      'ж'=>'zh', 'з'=>'z',    'и'=>'y',  'і'=>'i',
      'ї'=>'i',  'й'=>'i',    'к'=>'k',  'л'=>'l',
      'м'=>'m',  'н'=>'n',    'о'=>'o',  'п'=>'p',
      'р'=>'r',  'с'=>'s',    'т'=>'t',  'у'=> 'u',
      'ф'=>'f',  'х'=>'kh',   'ц'=>'ts', 'ч'=>'ch',
      'ш'=>'sh', 'щ'=>'shch', 'ь'=>'',   'ю'=>'iu',
      'я'=>'ia'
    }

    CAPITAL_RULES = {
      'А'=>'A',  'Б'=>'B',    'В'=>'V',  'Г'=>'H',
      'Ґ'=>'G',  'Д'=>'D',    'Е'=>'E',  'Є'=>'Ie',
      'Ж'=>'Zh', 'З'=>'Z',    'И'=>'Y',  'І'=>'I',
      'Ї'=>'I',  'Й'=>'I',    'К'=>'K',  'Л'=>'L',
      'М'=>'M',  'Н'=>'N',    'О'=>'O',  'П'=>'P',
      'Р'=>'R',  'С'=>'S',    'Т'=>'T',  'У'=> 'U',
      'Ф'=>'F',  'Х'=>'Kh',   'Ц'=>'Ts', 'Ч'=>'Ch',
      'Ш'=>'Sh', 'Щ'=>'Shch', 'Ь'=>'',   'Ю'=>'Iu',
      'Я'=>'Ia'
    }

    BEGINNING_OF_WORD_RULES = {
      'Є' => 'Ye', 'Ї' => 'Yi', 'Й' => 'Y', 'Ю' => 'Yu', 'Я' => 'Ya',
      'є' => 'ye', 'ї' => 'yi', 'й' => 'y', 'ю' => 'yu', 'я' => 'ya'
    }

    COMBINATION_RULES = { 'зг' => 'zgh', 'зГ' => 'zGH', 'ЗГ' => 'ZGH', 'Зг' => 'Zgh' }

    UPCASE_RULES = CAPITAL_RULES.inject({}) { |rules, (k, v)| rules[k] = v.upcase; rules }.freeze
    RULES = LOWER_RULES.merge(CAPITAL_RULES).merge(COMBINATION_RULES).merge({ '№'=>'#', '-'=>'-' }).freeze
    REGEXP = /#{COMBINATION_RULES.keys.join('|')}|./.freeze
    LETTERS = LOWER_RULES.keys.concat(CAPITAL_RULES.keys).freeze

    # Official Ukrainian-English transliteration
    def transliterate(string, options = { :skip_unknown => false, :skip_digits => false })
      chars = string.scan(REGEXP)

      chars.each_with_index.inject('') do |result, (char, index)|
        if (index == 0 || !LETTERS.include?(chars[index-1])) && BEGINNING_OF_WORD_RULES.has_key?(char)
          result << BEGINNING_OF_WORD_RULES[char]
        elsif UPCASE_RULES.has_key?(char) && (index > 0 && UPCASE_RULES.has_key?(chars[index-1]) || UPCASE_RULES.include?(chars[index+1]))
          result << UPCASE_RULES[char]
        elsif RULES.has_key?(char)
          result << RULES[char]
        elsif char == ' '
          result << char
        elsif char =~ /\d/
          options[:skip_digits] ? result : result << char
        else
          options[:skip_unknown] ? result : result << char
        end
      end
    end

    def slugify(string, options = { :skip_unknown => true, :skip_digits => false })
      transliterate(string, options).downcase.strip.squeeze(' ').gsub('#', '').gsub(' ', '-')
    end
  end
end

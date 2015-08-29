# encoding: utf-8
require 'spec_helper'

describe Ukrainian do
  describe "#transliterate" do
    def t(str)
      Ukrainian::transliterate(str)
    end

    specify { expect(t('Алушта')).to eq 'Alushta' }
    specify { expect(t('Борщагівка')).to eq 'Borshchahivka' }
    specify { expect(t('Вишгород')).to eq 'Vyshhorod' }
    specify { expect(t('Гадяч')).to eq 'Hadiach' }
    specify { expect(t('Ґалаґан')).to eq 'Galagan' }
    specify { expect(t('Дон')).to eq 'Don' }
    specify { expect(t('Рівне')).to eq 'Rivne' }
    specify { expect(t('Єнакієве')).to eq 'Yenakiieve' }
    specify { expect(t('Наєнко')).to eq 'Naienko' }
    specify { expect(t('Житомир')).to eq 'Zhytomyr' }
    specify { expect(t('Закарпаття')).to eq 'Zakarpattia' }
    specify { expect(t('Медвин')).to eq 'Medvyn' }
    specify { expect(t('Іршава')).to eq 'Irshava' }
    specify { expect(t('Їжакевич')).to eq 'Yizhakevych' }
    specify { expect(t('Кадіївка')).to eq 'Kadiivka' }
    specify { expect(t('Йосипівка')).to eq 'Yosypivka' }
    specify { expect(t('Стрий')).to eq 'Stryi' }
    specify { expect(t('Київ')).to eq 'Kyiv' }
    specify { expect(t('Лебедин')).to eq 'Lebedyn' }
    specify { expect(t('Миколаїв')).to eq 'Mykolaiv' }
    specify { expect(t('Ніжин')).to eq 'Nizhyn' }
    specify { expect(t('Одеса')).to eq 'Odesa' }
    specify { expect(t('Полтава')).to eq 'Poltava' }
    specify { expect(t('Ромни')).to eq 'Romny' }
    specify { expect(t('Суми')).to eq 'Sumy' }
    specify { expect(t('Тетерів')).to eq 'Teteriv' }
    specify { expect(t('Ужгород')).to eq 'Uzhhorod' }
    specify { expect(t('Фастів')).to eq 'Fastiv' }
    specify { expect(t('Харків')).to eq 'Kharkiv' }
    specify { expect(t('Біла Церква')).to eq 'Bila Tserkva' }
    specify { expect(t('Чернівці')).to eq 'Chernivtsi' }
    specify { expect(t('Шостка')).to eq 'Shostka' }
    specify { expect(t('Гоща')).to eq 'Hoshcha' }
    specify { expect(t('Юрій')).to eq 'Yurii' }
    specify { expect(t('Крюківка')).to eq 'Kriukivka' }
    specify { expect(t('Яготин')).to eq 'Yahotyn' }
    specify { expect(t('Ічня')).to eq 'Ichnia' }
    specify { expect(t('Згорани')).to eq 'Zghorany' }
    specify { expect(t('Розгон')).to eq 'Rozghon' }
  end
end

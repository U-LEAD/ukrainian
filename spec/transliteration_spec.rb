# encoding: utf-8
require 'spec_helper'

describe Ukrainian do
  describe '#transliterate' do
    def t(str, options = { :skip_unknown => false, :skip_digits => false })
      Ukrainian::transliterate(str, options)
    end

    def slugify(str)
      Ukrainian::slugify(str)
    end

    %w(transliterate translit).each do |method|
      it "#{method}' method should perform transliteration" do
        str = double(:str)
        expect(Ukrainian::Transliteration).to receive(:transliterate).with(str,
          { :skip_unknown=>false, :skip_digits=>false })
        Ukrainian.send(method, str)
      end
    end

    it 'should return transliterate for ukrainian characters' do
      expect(transliterate('Не мала баба клопоту, купила порося.')).to eq 'Ne mala baba klopotu, kupyla porosia.'
    end

    it 'should return transliterate for ukrainian characters' do
      expect(translit('Не мала баба клопоту, купила порося.')).to eq 'Ne mala baba klopotu, kupyla porosia.'
    end

    context 'should transliterate properly' do
      it { expect(t('Це просто якийсь текст')).to eq 'Tse prosto yakyis tekst' }
      it { expect(t('щ')).to eq 'shch' }
      it { expect(t('ш')).to eq 'sh' }
      it { expect(t('Ш')).to eq 'Sh' }
      it { expect(t('ц')).to eq 'ts' }
    end

    it 'should properly transliterate mixed ukrainian-english strings' do
      expect(t('Ласкаво просимо до Wiki')).to eq 'Laskavo prosymo do Wiki'
    end

    context 'should properly transliterate mixed case chars in a string' do
      it { expect(t('ДУЖЕ ДЯКУЮ')).to eq 'DUZHE DIAKUIU' }
      it { expect(t('До зустрічі')).to eq 'Do zustrichi' }
      it { expect(t('В. І. Вернадський')).to eq 'V. I. Vernadskyi' }
      it { expect(t('ВХІД')).to eq 'VKHID' }
    end

    context 'should work for multi-char substrings' do
      it { expect(t('21 очко')).to eq '21 ochko' }
      it { expect(t('Вася Пупкін')).to eq 'Vasia Pupkin' }
      it { expect(t('Вася')).to eq 'Vasia' }
      it { expect(t('ВАСЯ')).to eq 'VASIA' }
    end

    context 'skip_digits' do
      it 'skips digits if option skip_digits equals true' do
        expect(t('12-го Грудня 1-й провулок')).to eq '12-ho Hrudnia 1-y provulok'
        expect(t('12-го Грудня 1-й провулок', :skip_digits => true)).to eq '-ho Hrudnia -y provulok'
      end
    end

    context 'skip_unknown' do
      it 'skips unknown chasrs if option skip_unknown equals true' do
        expect(t('12-го Грудня, some text. 1-й провулок')).to eq '12-ho Hrudnia, some text. 1-y provulok'
        expect(t('12-го Грудня, some text. 1-й провулок', :skip_unknown => true)).to eq '12-ho Hrudnia   1-y provulok'
      end
    end
  end

  describe '#slugify' do
    it 'transliterate the string and converts it to a slug' do
      expect(slugify('12-го Грудня, some text. 1-й провулок')).to eq '12-ho-hrudnia-1-y-provulok'
    end
  end
end

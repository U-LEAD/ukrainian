# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Ukrainian do

  describe "with locale" do
    it "should define :'uk' LOCALE" do
      expect(Ukrainian::LOCALE).to eq(:'uk')
    end

    it "should provide 'locale' proxy" do
      expect(Ukrainian.locale).to eq(Ukrainian::LOCALE)
    end
  end

  describe "during i18n initialization" do
    after(:each) do
      I18n.load_path = []
      Ukrainian.init_i18n
    end

    it "should keep existing translations while switching backends" do
      I18n.load_path << File.join(File.dirname(__FILE__), 'fixtures', 'en.yml')
      Ukrainian.init_i18n
      expect(I18n.t(:foo, :locale => :'en')).to eq("bar")
    end

    it "should keep existing :uk translations while switching backends" do
      I18n.load_path << File.join(File.dirname(__FILE__), 'fixtures', 'uk.yml')
      Ukrainian.init_i18n
      expect(I18n.t(:'date.formats.default', :locale => :'uk')).to eq("override")
    end

    it "should NOT set default locale to Ukrainian locale" do
      locale = I18n.default_locale
      Ukrainian.init_i18n
      expect(I18n.default_locale).to eq(locale)
    end
  end

  describe "with localize proxy" do
    before(:each) do
      @time = double(:time)
      @options = { :format => "%d %B %Y" }
    end

    %w(l localize).each do |method|
      it "'#{method}' should call I18n backend localize" do
        expect(I18n).to receive(:localize).with(@time, @options.merge({ :locale => Ukrainian.locale }))
        Ukrainian.send(method, @time, @options)
      end
    end
  end

  describe "with translate proxy" do
    before(:all) do
      @object = :bar
      @options = { :scope => :foo }
    end

    %w(t translate).each do |method|
      it "'#{method}' should call I18n backend translate" do
        expect(I18n).to receive(:translate).with(@object, @options.merge({ :locale => Ukrainian.locale }))
        Ukrainian.send(method, @object, @options)
      end
    end
  end

  describe "strftime" do
    before(:each) do
      @time = double(:time)
    end

    it "should call localize with object and format" do
      format = "%d %B %Y"
      expect(Ukrainian).to receive(:localize).with(@time, { :format => format })
      Ukrainian.strftime(@time, format)
    end

    it "should call localize with object and default format when format is not specified" do
      expect(Ukrainian).to receive(:localize).with(@time, { :format => :default })
      Ukrainian.strftime(@time)
    end
  end

  describe "#pluralize" do

    context "should pluralize correctly" do

      let(:variants) { %w(річ речі речей речі) }

      it { expect(pluralize( 1, *variants)).to eq('річ') }
      it { expect(pluralize( 2, *variants)).to eq('речі') }
      it { expect(pluralize( 3, *variants)).to eq('речі') }
      it { expect(pluralize( 5, *variants)).to eq('речей') }
      it { expect(pluralize( 10, *variants)).to eq('речей') }
      it { expect(pluralize( 21, *variants)).to eq('річ') }
      it { expect(pluralize( 29, *variants)).to eq('речей') }
      it { expect(pluralize( 129, *variants)).to eq('речей') }
      it { expect(pluralize( 131, *variants)).to eq('річ') }
      it { expect(pluralize( 3.14, *variants)).to eq('речі') }
    end

    context "invalid parameters" do

      let(:variants) { %w(річ речі речей речі) }

      it "should have a Numeric as a first parameter" do
        expect {  pluralize( "1", *variants) }.to raise_error(ArgumentError, "Must have a Numeric as a first parameter")
      end

      it "should have at least 3 variants for pluralization" do
        expect { pluralize( 1, *variants[0..1] ) }.to raise_error(ArgumentError, "Must have at least 3 variants for pluralization")
      end

      it "should have at least 4 variants for pluralization" do
        expect { pluralize( 1.8, *variants[0..2]) }.to raise_error(ArgumentError, "Must have at least 4 variants for pluralization")
      end
    end
  end
end

# encoding: utf-8
require 'spec_helper'

describe I18n, "Ukrainian Date/Time localization" do
  before(:all) do
    Ukrainian.init_i18n
    @date = Date.parse("1985-12-01")
    @time = Time.local(1985, 12, 01, 16, 05)
  end

  describe "with date formats" do
    it "should use default format" do
      expect(l(@date)).to eq("01.12.1985")
    end

    it "should use short format" do
      expect(l(@date, :format => :short)).to eq("01 груд.")
    end

    it "should use long format" do
      expect(l(@date, :format => :long)).to eq("01 грудня 1985")
    end
  end

  describe "with date day names" do
    it "should use day names" do
      expect(l(@date, :format => "%d %B (%A)")).to eq("01 грудня (неділя)")
      expect(l(@date, :format => "%d %B %Y року була %A")).to eq("01 грудня 1985 року була неділя")
    end

    it "should use standalone day names" do
      expect(l(@date, :format => "%A")).to eq("Неділя")
      expect(l(@date, :format => "%A, %d %B")).to eq("Неділя, 01 грудня")
    end

    it "should use abbreviated day names" do
      expect(l(@date, :format => "%a")).to eq("Нд.")
      expect(l(@date, :format => "%a, %d %b %Y")).to eq("Нд., 01 груд. 1985")
    end
  end

  describe "with month names" do
    it "should use month names" do
      expect(l(@date, :format => "%d %B")).to eq("01 грудня")
      expect(l(@date, :format => "%-d %B")).to eq("1 грудня")

      if RUBY_VERSION > "1.9.2"
        expect(l(@date, :format => "%1d %B")).to eq("1 грудня")
        expect(l(@date, :format => "%2d %B")).to eq("01 грудня")
      end

      expect(l(@date, :format => "%e %B %Y")).to eq(" 1 грудня 1985")
      expect(l(@date, :format => "<b>%d</b> %B")).to eq("<b>01</b> грудня")
      expect(l(@date, :format => "<strong>%e</strong> %B %Y")).to eq("<strong> 1</strong> грудня 1985")
      expect(l(@date, :format => "А було тоді %eе число %B %Y")).to eq("А було тоді  1е число грудня 1985")
    end

    it "should use standalone month names" do
      expect(l(@date, :format => "%B")).to eq("Грудень")
      expect(l(@date, :format => "%B %Y")).to eq("Грудень 1985")
    end

    it "should use abbreviated month names" do
      @date = Date.parse("1985-03-01")
      expect(l(@date, :format => "%d %B")).to eq("01 березня")
      expect(l(@date, :format => "%e %B %Y")).to eq(" 1 березня 1985")
      expect(l(@date, :format => "<b>%d</b> %B")).to eq("<b>01</b> березня")
      expect(l(@date, :format => "<strong>%e</strong> %B %Y")).to eq("<strong> 1</strong> березня 1985")
    end

    it "should use standalone abbreviated month names" do
      @date = Date.parse("1985-03-01")
      expect(l(@date, :format => "%B")).to eq("Березень")
      expect(l(@date, :format => "%B %Y")).to eq("Березень 1985")
    end
  end

  it "should define default date components order: day, month, year" do
    expect(I18n.backend.translate(Ukrainian.locale, :"date.order")).to eq([:day, :month, :year])
  end

  describe "with time formats" do
    it "should use default format" do
      expect(l(@time)).to match(/^Нд., 01 груд. 1985, 16:05:00/)
    end

    it "should use short format" do
      expect(l(@time, :format => :short)).to eq("01 груд., 16:05")
    end

    it "should use long format" do
      expect(l(@time, :format => :long)).to eq("01 грудня 1985, 16:05")
    end

    it "should define am and pm" do
      expect(I18n.backend.translate(Ukrainian.locale, :"time.am")).not_to be_nil
      expect(I18n.backend.translate(Ukrainian.locale, :"time.pm")).not_to be_nil
    end
  end

  protected
    def l(object, options = {})
      I18n.l(object, options.merge( { :locale => Ukrainian.locale }))
    end
end

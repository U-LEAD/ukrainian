# encoding: utf-8
require 'spec_helper'

describe I18n, "Ukrainian pluralization" do
  let(:backend) { I18n.backend }
  let(:hash) { { one: 'one', few: 'few', many: 'many', other: 'other' } }

  context "should pluralize correctly" do
    it { expect(backend.pluralize(:uk, hash, 1)).to eq 'one' }
    it { expect(backend.pluralize(:uk, hash, 2)).to eq 'few' }
    it { expect(backend.pluralize(:uk, hash, 3)).to eq 'few' }
    it { expect(backend.pluralize(:uk, hash, 5)).to eq 'many' }
    it { expect(backend.pluralize(:uk, hash, 10)).to eq 'many' }
    it { expect(backend.pluralize(:uk, hash, 11)).to eq 'many' }
    it { expect(backend.pluralize(:uk, hash, 21)).to eq 'one' }
    it { expect(backend.pluralize(:uk, hash, 29)).to eq 'many' }
    it { expect(backend.pluralize(:uk, hash, 131)).to eq 'one' }
    it { expect(backend.pluralize(:uk, hash, 1.31)).to eq 'other' }
    it { expect(backend.pluralize(:uk, hash, 2.31)).to eq 'other' }
    it { expect(backend.pluralize(:uk, hash, 3.31)).to eq 'other' }
  end
end

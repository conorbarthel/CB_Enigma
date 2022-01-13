require './lib/enigma'
require 'date'
require 'pry'

RSpec.describe "Enigma" do
  let(:enigma) {Enigma.new}

  it "exists" do
    expect(enigma).to be_a(Enigma)
  end

  it "has attributes" do
    expect(enigma.alphabet).to be_a(Array)
    expect(enigma.alphabet.size).to eq(27)
  end

  it "can make keys" do
    expected = {
      :a => "06",
      :b => "62",
      :c => "28",
      :d => "89"
    }
    expect(enigma.shift_keys(6289)).to eq(expected)
  end

  it "can make offsets" do
    expected = {
      :a => "6",
      :b => "1",
      :c => "0",
      :d => "0"
    }
    expect(enigma.offsets(60690)).to eq(expected)
  end

  it "can generate shifts" do
    expected = {
      :a => "12",
      :b => "63",
      :c => "28",
      :d => "89"
    }
    expect(enigma.shifts("6289", "60690")).to eq(expected)
  end

  it "can code messages" do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    expect(enigma.encrypt("hello world", "02715", "040895"))
  end
end

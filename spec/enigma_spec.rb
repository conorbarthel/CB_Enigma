require 'spec_helper'
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
    expect(enigma.reverse_alphabet.last).to eq("a")
    expect(enigma.reverse_alphabet_hash.size).to eq(27)
  end

  it "can make five digit numbers" do
    expect(enigma.five_digit(23)).to eq("00023")
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
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
      expect(enigma.encrypt("hello world")).to be_a(Hash)
  end

  it "can decode messages" do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
    expect(enigma.decrypt("keder ohulw", "02715")[:date]).to eq(Date.today.strftime("%d%m%y"))
  end

  it "can find how far a letter moved" do
    expect(enigma.num_away("b", "d")).to eq(2)
    expect(enigma.num_away("d", "b")).to eq(25)
  end

  it "can find cracked shifts" do
    expected = {
      a: "3",
      b: "0",
      c: "1",
      d: "2"
    }
    expect(enigma.cracked_shifts("gtryuxemb")).to eq(expected)
  end

  xit "find cracked keys" do
    expect(enigma.crack_keys("vjqtbeaweqihssi", "291018")).to eq("08304")
  end

  xit "can crack the code" do
    expected = {
       decryption: "hello world end",
       date: "291018",
       key: "08304"
    }
    expect(enigma.crack("vjqtbeaweqihssi", "291018")).to eq(expected)
  end
end

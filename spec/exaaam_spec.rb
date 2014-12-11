#-*- encoding: utf-8 -*-

require 'spec_helper'
require 'benchmark'

describe 'Exaam' do
  before do
    @inputs = []

    10000.times do | i |
      @inputs << (i + 1)
    end

    @inputs.shuffle!

    @exaaam = Exaaam.new
    # @left_out = @inputs.delete(@inputs.sample)
    @left_out = @inputs.delete(8814)
    # pp @inputs
  end

  it 'helloはHello World!を返す' do
    expect(
        capture(:stdout){@exaaam.hello}).to eq "Hello World!!\n"

  end

  it 'looped_result' do
    result = Benchmark.realtime do
      @ret = @exaaam.looped_result(@inputs)
    end
    puts "looped_result #{result}s"

    # pp @left_out
    # pp @ret
    expect(
        @ret
    ).to eq @left_out

  end

  it 'divided_array' do
    result = Benchmark.realtime do
      @ret = @exaaam.divided_array(@inputs)
    end
    puts "divided_array #{result}s"

    # pp @left_out
    # pp @ret
    expect(
        @ret
    ).to eq @left_out

  end

  it 'uniq_array' do
    result = Benchmark.realtime do
      @ret = @exaaam.uniq_array(@inputs)
    end
    puts "uniq_array #{result}s"

    # pp @left_out
    # pp @ret
    expect(
        @ret
    ).to eq @left_out

  end

  it 'recursive_duo_suicide' do
    result = Benchmark.realtime do
      @ret = @exaaam.recursive_duo_suicide(@inputs)
    end
    puts "recursive_duo_suicide #{result}s"

    expect(
      @ret
    ).to eq @left_out

  end

  it 'recursive_duo_suicide_alt' do
    result = Benchmark.realtime do
      @ret = @exaaam.recursive_duo_suicide_alt(@inputs)
    end
    puts "recursive_duo_suicide_alt #{result}s"

    expect(
      @ret
    ).to eq @left_out

  end

  it 'recursive_duo_search' do
    result = Benchmark.realtime do
      @ret = @exaaam.recursive_duo_search(@inputs)
    end
    puts "recursive_duo_search #{result}s"

    expect(
      @ret
    ).to eq @left_out

  end

  it 'calculate_rest' do
    result = Benchmark.realtime do
      @ret = @exaaam.calculate_rest(@inputs)
    end
    puts "calculate_rest #{result}s"

    expect(
      @ret
    ).to eq @left_out

  end

  it 'looped_duo_search' do
    result = Benchmark.realtime do
      @ret = @exaaam.looped_duo_search(@inputs)
    end
    puts "looped_duo_search #{result}s"

    expect(
      @ret
    ).to eq @left_out

  end

  it 'looped_numbers' do
    result = Benchmark.realtime do
      @ret = @exaaam.looped_numbers(@inputs)
    end
    puts "looped_numbers #{result}s"

    expect(
      @ret
    ).to eq @left_out

  end
end
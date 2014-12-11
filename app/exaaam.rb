#-*- encoding: utf-8 -*-

class Exaaam
  def hello(arg = nil)
    puts "Hello World!!"
  end

  # 配列変換と結果の出力
  def answer(arg)
    # puts array.size
    array = arg.gsub(/[\[\]]/, '').split(",").map(&:to_i)
    puts calculate_rest array
  end

  # 配列をソートしてインデックス付きループをまわして、インデックスと値が異なったら答え
  def looped_result(array)
    result = nil
    array.sort!

    array.each.with_index(1) do |value, i|
      unless value == i
        result = value - 1
        break
      end
    end

    result
  end

  # 1..10000の値をループさせ、配列に含まれているか調べる。
  def looped_numbers(array)
    hash = array.group_by { |value| value }
    # pp hash
    10000.times do |i|
      return i+1 unless hash.has_key?(i+1)
    end

  end

  # 配列をソートし、前後二分割し、足りない値がある方を再帰でさらに二分割・・・を繰り返す。
  def divided_array(array)
    array.sort!

    recursive_divide(array)
  end

  # 1..100000の配列を追加して、値が一個しかないものを調べる。
  def uniq_array(array)

    # 10000までの配列を追加
    10000.times do |i|
      array << (i + 1)
    end

    # 値をキーに持つハッシュに変換し、値が一個しかないハッシュのキーを取得
    # array.group_by{|value| value}.select{|k, v| v.size == 1}.keys.first
    array.group_by { |value| value }.select { |k, v| v.one? }.keys.first
  end


  # 1..10000までの総和から、配列の値の総和を引くと、足りない要素になる。
  def calculate_rest(array)
    # 1..10000の総和
    total = 10001 * 5000

    # 配列の値の総和
    sum   = array.inject { |sum, n| sum + n }
    # sum   = array.inject(:+)

    total - sum
  end

  # 配列の頭から値を取得していき、足すと10001になるペアがあるかを調べる。再帰。
  # 場合によりstack level too deepが出るし遅い。
  def recursive_duo_search(array, index = 0)
    first = array[index]
    pair  = 10001 - first

    # pp "first:#{first}"
    # pp "pair:#{pair}"

    return pair unless array.include?(pair)

    recursive_duo_search(array, index + 1)

  end

  # 配列の頭から値を取得していき、足すと10001になるペアがあるかを調べる。ループ。
  def looped_duo_search(array)
    # ハッシュに変換
    hash = array.group_by { |value| value }

    hash.each_key do |key|
      pair = 10001 - key
      return pair unless hash.has_key?(pair)
    end
  end

  # 配列の頭から値を取得していき、足すと10001になるペアがあるかを調べる。調査済みの値は配列から削除していく。再帰。
  def recursive_duo_suicide(array)
    first = array.delete_at(0)
    pair  = 10001 - first
    ret   = array.delete(pair)

    # pp "first:#{first}"
    # pp "pair:#{pair}"

    return pair if ret.nil?

    recursive_duo_suicide(array)
  end

  # 配列の頭から値を取得していき、足すと10001になるペアがあるかを調べる。調査済みの値は配列から削除していく。再帰。ハッシュ版
  # array版のrecursive_duo_suicideよりは速い。
  def recursive_duo_suicide_alt(array)
    # ハッシュに変換
    hash = array.group_by { |value| value }

    recursive_duo_suicide_hash(hash)
  end

  private

  def recursive_duo_suicide_hash(hash)
    key, value = hash.shift
    pair  = 10001 - key
    ret   = hash.delete(pair)

    # pp "first:#{first}"
    # pp "pair:#{pair}"

    return pair if ret.nil?

    recursive_duo_suicide_hash(hash)
  end

  def recursive_divide(array)
    # return array.first if array.size == 1
    return array.first if array.one?

    slice   = array.size.quo(2).ceil
    # slice = (array.size/2).ceil

    divided = array.each_slice(slice).to_a

    # pp 'recursive last'
    # pp divided.first.first
    # pp divided.first.last
    # pp 'recursive size'
    # pp divided.first.size

    # もし前後の配列の値が連続していなかったら、その間の値が答え
    return divided.first.last + 1 unless divided.first.last + 1 == divided[1].first

    # 配列の先頭の値＋配列の要素数が配列の末尾の値じゃないなら、前側配列の中に答えがある
    recursive_divide((divided.first.last != (divided.first.first + slice - 1)) ? divided.first : divided[1])
  end
end

Exaaam.new.answer ARGV[0]

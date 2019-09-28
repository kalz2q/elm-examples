#buta014.dicを使ったしりとり。最初はランダムに[れ]>とか出して、れんぎょう。とか答えると、次は[う]>うま、[ま]>でプロンプト。そんな感じ。

# $KCODE="s"
dictionary = []
File.open("buta014.dic") { |f|
  f.each do |word|
    word.strip!
    dictionary.push(word)
  end
}

def char_rand(aiueo)
   aiueo[rand(aiueo.length)]
end

aiueo = %w(
あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ ら り る れ ろ わ
)

def getLastChar(str)
  komoji = {"ぁ"=>"あ","ぃ"=>"い","ぅ"=>"う","ぇ"=>"え","ぉ"=>"お","ゃ"=>"や","ゅ"=>"ゆ","ょ"=>"よ","ゎ"=>"わ","っ"=>"つ"}
  last = str[-2..-1]
  if komoji.has_key?(last) then
    last = komoji[last]
  end

  if last == "ー" then
    last = str[-4..-3]
    if komoji.has_key?(last) then
      last = komoji[last]
    end
  end
  return last
end

def komojifree(str)
  str.gsub!("ぁ","あ")
  str.gsub!("ぃ","い")
  str.gsub!("ぅ","う")
  str.gsub!("ぇ","え")
  str.gsub!("ぉ","お")
  str.gsub!("ゃ","や")
  str.gsub!("ゅ","ゆ")
  str.gsub!("ょ","よ")
  str.gsub!("ゎ","わ")
  str.gsub!("っ","つ")
  return str
end

def get_answer(before, dictionary)
  wd = nil
  loop do
    print "[#{getLastChar(before)}\] > "
    wd = gets
    wd.strip!
    wd = komojifree(wd)
    if wd.length == 0
      wd= before
      break
    elsif /\A#{getLastChar(before)}\w*/ =~ wd && dictionary.include?(wd)
       break
     end      
     if wd.length > 16
       puts "長すぎます(8文字以上)"
     end
     puts "ぶたさんの辞書にありません"
  end
  return wd
end

def random_select(before, dictionary)
  selected_dictionary = []
  dictionary.each{ |word| 
    if /\A#{getLastChar(before)}\w*/=== word
      selected_dictionary.push(word)
    end
  }
  return selected_dictionary[rand(selected_dictionary.length)]
end

def think_answer(before, dictionary)
  word = ""
  loop do
    word = random_select(before, dictionary)
    if (word[-2..-1] === "ー") then
    else
      break
    end
  end
  word
end

# main
before = char_rand(aiueo)
p before
loop do
  before = get_answer(before, dictionary)
  p before
  if before[-2..-1]=="ん"
    puts"\"ん\"で終わってるので、まけー"
    exit
  end
  before = think_answer(before, dictionary)
  p before
  if before[-2..-1]=="ん"
    puts"\"ん\"で終わってるので、まけー"
    exit
  end
end
def substrings(string, dictionary)
  result={}
  dictionary.each do |word|
    matches = string.downcase.scan(word.downcase)
    if matches.count > 0
        result[word.downcase] = matches.count
    end
  end
  result
end

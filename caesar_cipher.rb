def caesar_cipher(string, shift)
  encrypted_string = ""
  string.downcase.each_char do |character|
    if ("a".."z").include? character
      pre_shift = character.ord - 97
      shifted = ((pre_shift + shift) % 26) + 97
      encrypted_string += shifted.chr
    else
      encrypted_string += character
    end
  end
  encrypted_string
end
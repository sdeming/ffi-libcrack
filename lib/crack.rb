require 'ffi'

module LibCrack
  extend FFI::Library
  ffi_lib 'libcrack'

  attach_function :FascistCheck, [:string, :string], :string
  attach_function :GetDefaultCracklibDict, [], :string
end

if __FILE__ == $0
  require 'pp'

  puts "Default dictionary: #{LibCrack::GetDefaultCracklibDict()}"

  words = %w{ scott 
              testing 
              word 
              1234567890 
              $3cret1ve
              1bqp0k4,$334%4mmzlp00 
              f00lzpr1d3 }
      

  results = words.inject({:good => {}, :bad => {}}) do |memo,word|
    result = LibCrack::FascistCheck(word, nil)

    if result.nil?
      memo[:good][word] = "ok"
    else
      memo[:bad][word] = result
    end

    memo
  end

  pp results
end

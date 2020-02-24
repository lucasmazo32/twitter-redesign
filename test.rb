my_hash = {:username=>["can't be blank", "is too short (minimum is 5 characters)", "is too long (maximum is 20 characters)"], :name=>["can't be blank", "is too short (minimum is 3 characters)"]}

my_hash.each{ |x| p x[0].to_s + ' ' + x[1][0] }
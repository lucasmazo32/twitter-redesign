def test(seed = false)
  @user = 5 if seed
  @user
end

p test(true)

p test
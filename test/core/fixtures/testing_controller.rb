class TestingController < AbstractController

  def basic
    'abcd'
  end

  def home
    'home'
  end

  def params_test
    "#{@p.cat} and #{@p.year}"
  end

end


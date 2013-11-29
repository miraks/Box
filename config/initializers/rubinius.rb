# Временные фиксы для багов рубиниуса

if defined? Rubinius
  # Рубиниус пытается сделать undef для =~ у Pathname,
  # но такого метода у Pathname уже нету
  class Pathname
    def =~
    end
  end
end
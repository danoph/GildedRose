class Item
  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end
end

class NormalItem < Item
  def quality_adjustment
    adjust = -1
    adjust -= 1 if sell_in <= 0
    adjust
  end
end

class AgedBrie < Item
  def quality_adjustment
    1
  end
end

class ConjuredItem < NormalItem
  def quality_adjustment
    super * 2
  end
end

class SulfurasItem < Item
  def quality_adjustment
    0
  end

  def quality
    80
  end
end

class BackstagePass < Item
  def quality_adjustment
    adjust = 1

    if (sell_in < 11)
      adjust += 1
    end
    if (sell_in < 6)
      adjust += 1
    end
    if sell_in <= 0
      adjust = -quality
    end

    adjust
  end
end

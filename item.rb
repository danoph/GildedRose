class Item
  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end
end

class StoreItem < Item
  def update
    adjust_quality
    adjust_sell_in
  end

  def adjust_quality
    self.quality += quality_adjustment if quality + quality_adjustment >= 0 && quality + quality_adjustment <= 50
  end

  def adjust_sell_in
    self.sell_in = sell_in - 1
  end
end

class NormalItem < StoreItem
  def quality_adjustment
    adjust = -1
    adjust -= 1 if sell_in <= 0
    adjust
  end
end

class AgedBrie < StoreItem
  def quality_adjustment
    1
  end
end

class ConjuredItem < NormalItem
  def quality_adjustment
    super * 2
  end
end

class SulfurasItem < StoreItem
  def adjust_quality; end
  def adjust_sell_in; end
end

class BackstagePass < StoreItem
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

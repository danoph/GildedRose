class Item

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def increase_quality
    if quality < 50
      self.quality = quality + 1
    end
  end

  def decrease_quality
    if quality > 0
      self.quality = quality - 1
    end
  end

  def decrease_sell_in
    self.sell_in = sell_in - 1
  end

  def update_quality
    decrease_quality

    if sell_in <= 0
      decrease_quality
    end

    decrease_sell_in
  end
end

class AgedBrie < Item
  def update_quality
    increase_quality

    if sell_in <= 0
      increase_quality
    end

    decrease_sell_in
  end
end

class DexterityVest < Item

end

class MongooseElixir < Item

end

class Sulfuras < Item
  def decrease_sell_in
  end

  def decrease_quality
  end
end

class BackstagePass < Item
  def update_quality
    increase_quality

    if sell_in < 11
      increase_quality
    end

    if sell_in < 6
      increase_quality
    end

    if sell_in <= 0
      self.quality = 0
    end

    decrease_sell_in
  end
end

class ManaCake < Item

end

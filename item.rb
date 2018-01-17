class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def increase_quality
    self.quality += 1 if quality < 50
  end

  def decrease_quality
    self.quality -= 1 if quality > 0
  end

  def decrease_sell_in
    self.sell_in -= 1
  end

  def update_quality
    decrease_quality
    decrease_quality if sell_in <= 0
    decrease_sell_in
  end

  def reset_quality
    self.quality = 0
  end
end

class AgedBrie < Item
  def update_quality
    increase_quality
    increase_quality if sell_in <= 0
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
    increase_quality if sell_in < 11
    increase_quality if sell_in < 6
    reset_quality if sell_in <= 0
    decrease_sell_in
  end
end

class ManaCake < Item
end

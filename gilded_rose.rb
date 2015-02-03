require './item.rb'

class NormalItem < Item
  def update
    update_quality
    update_sell_in
  end

  def adjustment_multiplier
    1
  end

  def expired_quality_adjustment
    adjustment_multiplier * -2
  end

  def normal_quality_adjustment
    adjustment_multiplier * -1
  end

  def quality_adjustment
    if sell_in <= 0
      expired_quality_adjustment
    else
      normal_quality_adjustment
    end
  end

  def update_quality
    new_quality = quality + quality_adjustment
    self.quality = new_quality if new_quality >= 0 && new_quality <= 50
  end

  def update_sell_in
    self.sell_in = sell_in - 1;
  end
end

class ConjuredItem < NormalItem
  def adjustment_multiplier
    2
  end
end

class AgedBrieItem < NormalItem
  def adjustment_multiplier
    -1
  end
end

class SulfurasItem < NormalItem
  def update_quality; end
  def update_sell_in; end
end

class BackstageItem < NormalItem
  def expired_quality_adjustment
    -quality
  end

  def normal_quality_adjustment
    if sell_in < 6
      3
    elsif sell_in < 11
      2
    else
      1
    end
  end
end

class GildedRose
  attr_reader :items

  def initialize
    @items = []
    @items << NormalItem.new("+5 Dexterity Vest", 10, 20)
    @items << AgedBrieItem.new("Aged Brie", 2, 0)
    @items << NormalItem.new("Elixir of the Mongoose", 5, 7)
    @items << SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << BackstageItem.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << ConjuredItem.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each do |item|
      item.update
    end
  end
end

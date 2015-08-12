require './item.rb'

class NormalItem
  def tick
    subtract_quality
    self.sell_in -= 1

    subtract_quality if sell_in < 0
  end

  def add_quality
    self.quality += 1 if quality < 50
  end

  def subtract_quality
    self.quality -= 1 if quality > 0
  end
end

class Sulfuras < NormalItem

  def tick
  end

end

class AgedBrie < NormalItem

  def tick
    add_quality
    add_quality if sell_in < 0
    self.sell_in -= 1
  end


end

class BackstagePasses < NormalItem

  def tick
    add_quality
    add_quality if sell_in < 11
    add_quality if sell_in < 6

    self.sell_in -= 1

    self.quality = 0 if sell_in < 0
  end

end

class ConjuredItem < NormalItem

  def tick
    subtract_quality
    subtract_quality
    self.sell_in -= 1
    subtract_quality if sell_in < 0
  end

end

class ItemFactory

  def build(item)
    klass = case item.name
    when "Aged Brie"
      AgedBrie
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePasses
    when /conjured/i
      ConjuredItem
    else
      NormalItem
    end

    klass.new(item.name, item.sell_in, item.quality)
  end

end

class GildedRose

  @items = []

  attr_reader :items

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
    @items << Item.new("Another Conjured Item #2", 3, 6)
  end

  def update_quality
    factory = ItemFactory.new

    @items = items.map do |item|
      factory.build(item)
    end

    items.each do |item|
      item.tick
    end
  end

end

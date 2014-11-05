require './item.rb'

class GildedRose
  attr_reader :items

  @items = []

  def initialize
    @items = []
    @items << NormalItem.new("+5 Dexterity Vest", 10, 20)
    @items << AgedBrie.new("Aged Brie", 2, 0)
    @items << NormalItem.new("Elixir of the Mongoose", 5, 7)
    @items << SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << ConjuredItem.new("Conjured Mana Cake", 3, 6)
    @items << ConjuredItem.new("Conjured Item", 4, 8)
  end

  def update_quality
    @items.each{|item| item.update }
  end
end

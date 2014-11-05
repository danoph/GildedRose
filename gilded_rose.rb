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
    @items.each do |item|
      update_item_quality(item)
      update_item_sell_in(item)
    end
  end

  def update_item_quality(item)
    item.quality += item.quality_adjustment if item.quality + item.quality_adjustment >= 0 && item.quality + item.quality_adjustment <= 50
  end

  def update_item_sell_in(item)
    if (item.name != "Sulfuras, Hand of Ragnaros")
      item.sell_in = item.sell_in - 1;
    end
  end
end

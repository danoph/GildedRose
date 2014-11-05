require './item.rb'

class GildedRose
  attr_reader :items

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
    @items << Item.new("Conjured Item", 4, 8)
  end

  def update_quality
    @items.each do |item|
      update_item_quality_and_sell_in(item)
    end
  end

  def update_item_quality_and_sell_in(item)
    update_item_quality(item)
    update_item_sell_in(item)
  end

  def update_item_quality(item)
    if item.name =~ /conjured/i
      subtract_quality(item, 2)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      # dont update
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      add_quality(item)

      if (item.sell_in < 11)
        add_quality(item)
      end
      if (item.sell_in < 6)
        add_quality(item)
      end
      if item.sell_in <= 0
        item.quality = 0
      end
    elsif item.name == "Aged Brie"
      add_quality(item)
    else
      subtract_quality(item)

      if (item.sell_in <= 0)
        subtract_quality(item)
      end
    end
  end

  def add_quality(item, amount=1)
    item.quality += amount if item.quality < 50
  end

  def subtract_quality(item, amount=1)
    item.quality = item.quality - amount if item.quality > 0
  end

  def update_item_sell_in(item)
    if (item.name != "Sulfuras, Hand of Ragnaros")
      item.sell_in = item.sell_in - 1;
    end
  end
end

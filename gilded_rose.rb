require './item.rb'

class ItemFactory
  def self.create(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras.new(item)
    when /Conjured/i
      ConjuredItem.new(item)
    else
      MyItem.new(item)
    end
  end
end

class MyItem
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
    update_quality
    update_sell_in
  end

  def update_quality
    rem_quality
    rem_quality if @item.sell_in < 1
  end

  def update_sell_in
    @item.sell_in -= 1
  end

  def rem_quality
    @item.quality -= 1 if @item.quality > 0
  end

  def add_quality(inc = 1)
    @item.quality += inc if @item.quality < 50
  end
end

class AgedBrie < MyItem
  def update_quality
    add_quality
    add_quality if @item.sell_in < 0
  end
end

class BackstagePass < MyItem
  def update_quality
    if @item.sell_in < 1
      @item.quality = 0
    elsif @item.sell_in <= 5
      add_quality 3
    elsif @item.sell_in <= 10
      add_quality 2
    else
      add_quality
    end
  end
end

class Sulfuras < MyItem
  def update_sell_in
  end

  def update_quality
  end
end

class ConjuredItem < MyItem
  def rem_quality
    @item.quality -= 2 if @item.quality > 0
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
  end

  def update_quality
    @my_items = @items.map{|i| ItemFactory.create(i) }

    @my_items.each do |item|
      item.update
    end
  end
end

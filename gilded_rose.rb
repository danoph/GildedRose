require './item.rb'

class SulfurasItemUpdater
  def initialize(item)
    @item = item
  end

  def update_item_quality
    # nothing
  end

  def update_item_sell_in
    # nothing
  end
end

class NormalItemUpdater
  def initialize(item)
    @item = item
  end

  def update_item_quality
    if  @item.name == "Aged Brie" || @item.name == "Backstage passes to a TAFKAL80ETC concert"
      increment_item_quality

      if (@item.name == "Backstage passes to a TAFKAL80ETC concert")
        increment_item_quality if @item.sell_in < 11
        increment_item_quality if @item.sell_in < 6

        @item.quality = 0 if @item.sell_in < 1
      else
        increment_item_quality if @item.sell_in < 0
      end
    else
      decrement_item_quality
      decrement_item_quality if @item.sell_in < 1
    end
  end

  def update_item_sell_in
    decrement_sell_in
  end

  def increment_item_quality
    if (@item.quality < 50)
      @item.quality += 1
    end
  end

  def decrement_item_quality
    if (@item.quality > 0)
      @item.quality -= 1
    end
  end

  def decrement_sell_in
    @item.sell_in -= 1
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
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        updater = SulfurasItemUpdater.new item
      else
        updater = NormalItemUpdater.new item
      end

      updater.update_item_quality
      updater.update_item_sell_in
    end
  end
end

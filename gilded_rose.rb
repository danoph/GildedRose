require './item.rb'

class MyItem < Item
  def update_quality
  end

  def update_sell_in
  end
end

class AgedBrie < MyItem
  def update_quality
    item.quality += 1
  end
end

class GildedRose

  @items = []

  attr_reader :items

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << AgedBrie.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      decrease_sell_in(item, 1)

      item.update_quality

      change_item_quality(item)
    end
  end

  private

  def change_item_quality(item)
    case item.name
    when "Aged Brie"
      increase_quality(item, 1)
      increase_quality(item, 1) if item.sell_in < 0
    when "Backstage passes to a TAFKAL80ETC concert"
      if item.sell_in <= 0
        decrease_quality(item, item.quality)
      elsif item.sell_in < 5
        increase_quality(item, 3)
      elsif item.sell_in < 10
        increase_quality(item, 2)
      else
        increase_quality(item, 1)
      end
    else
      decrease_quality(item, 1)
      decrease_quality(item, 1) if item.sell_in < 0
    end


    # if !["Aged Brie", "Backstage passes to a TAFKAL80ETC concert"].include?(item.name)
    #   decrease_quality(item, 1)
    # else
    #   increase_quality(item, 1)

    #   if (item.name == "Backstage passes to a TAFKAL80ETC concert")
    #     increase_quality(item, 1) if item.sell_in < 10
    #     increase_quality(item, 1) if item.sell_in < 5
    #   end
    # end

    # if (item.sell_in < 0)
    #   case item.name
    #   when "Aged Brie"
    #     increase_quality(item, 1)
    #   when "Backstage passes to a TAFKAL80ETC concert"
    #     decrease_quality(item, item.quality)
    #   else
    #     decrease_quality(item, 1)
    #   end
    # end
  end

  def increase_quality(item, number)
    item.quality += number if item.quality < 50
  end

  def decrease_quality(item, number)
    item.quality -= number if item.quality > 0
  end

  def decrease_sell_in(item, number)
     item.sell_in -= number
  end

end

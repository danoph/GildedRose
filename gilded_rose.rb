require './item.rb'

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

  def increase_quality(item)
    if (item.quality < 50)
      item.quality = item.quality + 1
    end
  end

  def decrease_quality(item)
    if (item.quality > 0)
      if (item.name != "Sulfuras, Hand of Ragnaros")
        item.quality = item.quality - 1
      end
    end
  end

  def decrease_sell_in(item)
    if (item.name != "Sulfuras, Hand of Ragnaros")
      item.sell_in = item.sell_in - 1;
    end
  end

  def update_quality

    @items.each do |item|
      if item.name == "Aged Brie"
        increase_quality(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        increase_quality(item)
        if (item.sell_in < 11)
          increase_quality(item)
        end
        if (item.sell_in < 6)
          increase_quality(item)
        end
      else
        decrease_quality(item)
      end

      if (item.sell_in <= 0)
        if (item.name == "Aged Brie")
            increase_quality(item)
        else
          if (item.name == "Backstage passes to a TAFKAL80ETC concert")
            item.quality = item.quality - item.quality
          else
            decrease_quality(item)
          end
        end
      end

      decrease_sell_in(item)

    end
  end

end

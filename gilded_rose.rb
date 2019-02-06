require './item.rb'

class AgedBrieQualityUpdater
  def initialize(item)
    @item = item
  end

  def update
    if (@items[i].quality < 50)
      @items[i].quality = @items[i].quality + 1
      if (@items[i].name == "Backstage passes to a TAFKAL80ETC concert")
        if (@items[i].sell_in < 11)
          if (@items[i].quality < 50)
            @items[i].quality = @items[i].quality + 1
          end
        end
        if (@items[i].sell_in < 6)
          if (@items[i].quality < 50)
            @items[i].quality = @items[i].quality + 1
          end
        end
      end
    end
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

      if (item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert")
        if (item.quality > 0)
          if (item.name != "Sulfuras, Hand of Ragnaros")
            item.quality -= 1
          end
        end
      else
        if (item.quality < 50)
          item.quality += 1
          if (item.name == "Backstage passes to a TAFKAL80ETC concert")
          end
        end
      end

      # STAGE2
      if (item.name != "Sulfuras, Hand of Ragnaros")
        item.sell_in -= 1;
      end

      # STAGE3 -- exceptions to the quality rule
      if (item.sell_in < 0)
        if (item.name != "Aged Brie")
          if (item.name != "Backstage passes to a TAFKAL80ETC concert")
            if (item.quality > 0 && item.name != "Sulfuras, Hand of Ragnaros")
                item.quality -= 1
            end
          else
            item.quality = 0
          end
        else
          if (item.quality < 50)
            item.quality += 1
          end
        end
      end
    end
  end

  def appreciating_spoilable
    if (item.sell_in < 11)
      if (item.quality < 50)
        item.quality += 1
      end
    end
    if (item.sell_in < 6)
      if (item.quality < 50)
        item.quality += 1
      end
    end
  end

end

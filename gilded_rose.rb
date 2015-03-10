require './item.rb'

class ExtendedItem < Item
  def inc
    self.quality += 1 if self.quality < 50
  end
  def dec
  end
  def update_quality
    item.quality -= 1

    if (!["Aged Brie", "Backstage passes to a TAFKAL80ETC concert"].include?(self.name))
      self.quality -= 1 if self.quality > 0 && self.name != "Sulfuras, Hand of Ragnaros"
    elsif self.quality < 50
      self.quality += 1
      if self.name == "Backstage passes to a TAFKAL80ETC concert"
        self.quality += 1 if self.sell_in < 11 && self.quality < 50
        self.quality += 1 if self.sell_in < 6 && self.quality < 50
      end
    end 

    self.sell_in -= 1 if (self.name != "Sulfuras, Hand of Ragnaros")

    if self.sell_in < 0
      if self.name == 'Aged Brie'
        self.quality += 1 if self.quality < 50
      elsif self.name == 'Backstage passes to a TAFKAL80ETC concert'
        self.quality = 0
      elsif self.name != "Sulfuras, Hand of Ragnaros" && self.quality > 0
        self.quality -= 1
      end
    end
  end
end

class AgiedBrie < ExtendedItem
  def update_quality
    self.quality += 1
  end
end

class SulfurasItem < ExtendedItem
  def update_quality
  end

  def update_sell_in
  end
end

class GildedRose
  @items = []
  attr_reader :items

  def initialize
    @items = []
    @items << ExtendedItem.new("+5 Dexterity Vest", 10, 20)
    @items << AgiedBrie.new("Aged Brie", 2, 0)
    @items << ExtendedItem.new("Elixir of the Mongoose", 5, 7)
    @items << SulfarasItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << ExtendedItem.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each &:update
  end
end

=begin
    for i in 0..(@items.size-1)
      if (@items[i].name != "Aged Brie" && @items[i].name != "Backstage passes to a TAFKAL80ETC concert")
        if (@items[i].quality > 0)
          if (@items[i].name != "Sulfuras, Hand of Ragnaros")
            @items[i].quality = @items[i].quality - 1
          end
        end
      else
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
      if (@items[i].name != "Sulfuras, Hand of Ragnaros")
        @items[i].sell_in = @items[i].sell_in - 1;
      end
      if (@items[i].sell_in < 0)
        if (@items[i].name != "Aged Brie")
          if (@items[i].name != "Backstage passes to a TAFKAL80ETC concert")
            if (@items[i].quality > 0)
              if (@items[i].name != "Sulfuras, Hand of Ragnaros")
                @items[i].quality = @items[i].quality - 1
              end
            end
          else
            @items[i].quality = @items[i].quality - @items[i].quality
          end
        else
          if (@items[i].quality < 50)
            @items[i].quality = @items[i].quality + 1
          end
        end
      end
    end
  end 

    @items.each do |item|
      if (!["Aged Brie", "Backstage passes to a TAFKAL80ETC concert"].include?(item.name))
        item.quality -= 1 if item.quality > 0 && item.name != "Sulfuras, Hand of Ragnaros"
      elsif item.quality < 50
        item.quality += 1
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality += 1 if item.sell_in < 11 && item.quality < 50
          item.quality += 1 if item.sell_in < 6 && item.quality < 50
        end
      end 

      item.sell_in -= 1 if (item.name != "Sulfuras, Hand of Ragnaros")

      if item.sell_in < 0
        if item.name == 'Aged Brie'
          item.quality += 1 if item.quality < 50
        elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = 0
        elsif item.name != "Sulfuras, Hand of Ragnaros" && item.quality > 0
          item.quality -= 1
        end
      end
    end #each
  end #def
=end
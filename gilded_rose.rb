require './item.rb'

class GildedRose

  @items = []

  attr_reader :items

  def initialize
    @items = []
    @items << DexterityVest.new("+5 Dexterity Vest", 10, 20)
    @items << AgedBrie.new("Aged Brie", 2, 0)
    @items << MongooseElixir.new("Elixir of the Mongoose", 5, 7)
    @items << Sulfuras.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << ManaCake.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each do |item|
      item.update_quality
    end
  end

end

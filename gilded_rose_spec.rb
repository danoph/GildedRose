require './gilded_rose.rb'
require "rspec"

describe GildedRose do
  describe '#update_quality' do
    describe 'dexterity vest' do
      let(:item) { subject.items[0] }

      it 'decreases normally' do
        subject.update_quality
        expect(item.sell_in).to eq(9)
        expect(item.quality).to eq(19)
      end

      it 'quality does not go below 0' do
        18.times do |i|
          subject.update_quality
        end
        expect(item.quality).to eq(0)
      end

      it 'sell by date can go negative' do
        18.times do |i|
          subject.update_quality
        end
        expect(item.sell_in).to eq(-8)
      end

      it 'degrades quality faster when sell by date past' do
        10.times do |i|
          subject.update_quality
        end
        expect(item.quality).to eq(10)
        expect(item.sell_in).to eq(0)

        subject.update_quality

        expect(item.quality).to eq(8)
        expect(item.sell_in).to eq(-1)

        subject.update_quality

        expect(item.quality).to eq(6)
        expect(item.sell_in).to eq(-2)
      end
    end

    describe 'aged brie' do
      let(:item) { subject.items[1] }

      it 'increases in quality while sell_in decreases' do
        subject.update_quality
        expect(item.sell_in).to eq(1)
        expect(item.quality).to eq(1)
      end

      it 'quality does not go above 50' do
        75.times do |i|
          subject.update_quality
        end

        expect(item.quality).to eq(50)
      end
    end

    describe 'elixir' do
      let(:item) { subject.items[2] }

      it 'decreases normally' do
        subject.update_quality
        expect(item.sell_in).to eq(4)
        expect(item.quality).to eq(6)
      end
    end

    describe 'sulfuras' do
      let(:item) { subject.items[3] }

      it 'never decreases' do
        20.times do
          subject.update_quality
          expect(item.sell_in).to eq(0)
          expect(item.quality).to eq(80)
        end
      end
    end

    describe 'backstage passes' do
      let(:item) { subject.items[4] }

      it 'decreases normally' do
        subject.update_quality
        expect(item.sell_in).to eq(14)
        expect(item.quality).to eq(21)
      end

      describe 'quality' do
        context 'more than 10 days left' do
          let(:sell_in) { 14 }
          let(:quality) { 21 }

          it 'increases quality when sell in date closer' do
            5.times do |i|
              subject.update_quality
              expect(item.sell_in).to eq(sell_in - i)
              expect(item.quality).to eq(quality + i)
            end
          end
        end

        context 'less than 10 days left' do
          before do
            5.times do |i|
              subject.update_quality
            end
          end

          it 'increases quality by 2' do
            sell_in = 10
            quality = 25

            5.times do
              sell_in = sell_in - 1
              quality = quality + 2
              subject.update_quality
              expect(item.sell_in).to eq(sell_in)
              expect(item.quality).to eq(quality)
            end
          end
        end

        context 'less than 5 days left' do
          before do
            10.times do |i|
              subject.update_quality
            end
          end

          it 'increases quality by 3' do
            sell_in = 5
            quality = 35

            5.times do
              sell_in = sell_in - 1
              quality = quality + 3
              subject.update_quality
              expect(item.sell_in).to eq(sell_in)
              expect(item.quality).to eq(quality)
            end
          end
        end

        context 'concert has passed' do
          before do
            15.times do |i|
              subject.update_quality
            end
          end

          it 'increases quality by 3' do
            sell_in = 0
            quality = 50

            expect(item.sell_in).to eq(sell_in)
            expect(item.quality).to eq(quality)

            5.times do
              sell_in = sell_in - 1
              subject.update_quality
              expect(item.sell_in).to eq(sell_in)
              expect(item.quality).to eq(0)
            end
          end
        end
      end
    end

    describe 'conjured mana cake', pending: true do
      let(:item) { subject.items[5] }

      it 'decreases twice as fast' do
        subject.update_quality
        expect(item.sell_in).to eq(2)
        expect(item.quality).to eq(4)
      end
    end
  end
end

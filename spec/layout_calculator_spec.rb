require 'spec_helper'
require 'flicket/layout_calculator'

describe Flicket::LayoutCalculator do
  let(:subject) { described_class.new }
  it '#rows' do
    expect(subject.rows).to eq 3
  end

  it '#columns' do
    expect(subject.columns).to eq 4
  end

  context 'single width cell' do
    it '#cell_width' do
      expect(subject.cell_width(0)).to eq 576
    end

    describe '#crop_rect' do
      it 'takes cell aspect ratio' do
        expect(subject.crop_rect(0, 400, 400).aspect_ratio).to eq 576.0/480
      end

      it 'retains width' do
        expect(subject.crop_rect(0, 400, 400).width).to eq 400
      end
    end
  end

  context 'single-height cell' do
    it '#cell_height' do
      expect(subject.cell_height(0)).to eq 480
    end

    it '#cell_width' do
      expect(subject.cell_width(0)).to eq 576
    end
  end

  context 'multi-height cell' do
    it '#cell_height' do
      expect(subject.cell_height(4)).to eq 480*2
    end

    it '#cell_width' do
      expect(subject.cell_width(4)).to eq 576
    end

    describe '#crop_rect' do
      it 'takes cell aspect ratio' do
        expect(subject.crop_rect(4, 400, 400).aspect_ratio).to eq 576.0/960
      end

      it 'retains height' do
        expect(subject.crop_rect(4, 400, 400).height).to eq 400
      end
    end
  end

  describe '#cell_rect' do
    let(:total_width) { described_class::WIDTH }
    let(:total_height) { described_class::HEIGHT }

    cell_width = described_class::WIDTH / 4
    cell_height = described_class::HEIGHT / 3
    # name => x, y, width, height
    {
      0 => [0, 0, cell_width, cell_height],
      1 => [cell_width, 0, cell_width, cell_height],
      3 => [3*cell_width, 0, cell_width, 2*cell_height],
      4 => [0, cell_height, cell_width, 2*cell_height],
      5 => [cell_width, cell_height, cell_width, cell_height],
      8 => [2*cell_width, 2*cell_height, cell_width, cell_height]
    }.each do |cell_name, expected_rect|
      it "calculates for cell #{cell_name}" do
        expect(subject.cell_rect(cell_name)).to eq(Flicket::Rectangle.new(*expected_rect))
      end
    end
  end
end

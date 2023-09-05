class Logo

  attr_reader :image

  class << self
    def load
      File.read(file_path)
    rescue Errno::ENOENT
      raise "Файл #{file_name} не найден"
    end

    private

    def file_path
      File.expand_path(file_name, Dir.pwd)
    end

    def file_name
      "logo.txt"
    end
  end

  def initialize
    @image = self.class.load
  end

end

RSpec.describe Logo do
  let(:logo) { File.read(File.expand_path('logo.txt', Dir.pwd)) }
  
  describe '.load' do
    let(:exists_logo_path) { File.expand_path('logo.txt', Dir.pwd) }
    let(:not_exists_logo_path) { File.expand_path('logo1.txt', Dir.pwd) }

    context 'when file exists' do
      it 'reads the file' do
        expect(File).to receive(:read).with(exists_logo_path).and_return(logo)
        described_class.load
      end
    end

    context 'when file not exists' do
      it "raise error 'Файл logo.txt не найден'" do
        allow(described_class).to receive(:file_path).and_return(not_exists_logo_path)
        expect{ described_class.load }.to raise_error(RuntimeError, "Файл logo.txt не найден")
      end
    end
  end

  describe '#image' do
    it 'returns logo image' do
      expect(subject.image).to eq(logo)
    end
  end

end

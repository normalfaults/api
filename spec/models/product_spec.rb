describe Product do
  context 'options' do
    let(:options) { [{ dialog_name: 'name' }, { dialog_name: 'name2' }] }

    it 'can store unstructured options' do
      create :product, options: options
      product =  Product.first

      expect(product.options[0][:dialog_name]).to eq(options[0]['dialog_name'])
      expect(product.options[1][:dialog_name]).to eq(options[1]['dialog_name'])
    end
  end
end

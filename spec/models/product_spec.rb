# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  service_type_id    :integer
#  service_catalog_id :integer
#  cloud_id           :integer
#  chef_role          :string(100)
#  active             :boolean
#  img                :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  options            :json
#  deleted_at         :datetime
#  product_type_id    :integer
#  setup_price        :decimal(10, 4)   default(0.0)
#  hourly_price       :decimal(10, 4)   default(0.0)
#  monthly_price      :decimal(10, 4)   default(0.0)
#
# Indexes
#
#  index_products_on_cloud_id         (cloud_id)
#  index_products_on_deleted_at       (deleted_at)
#  index_products_on_product_type_id  (product_type_id)
#

describe Product do
  context 'options' do
    let(:options) { [{ dialog_name: 'name' }, { dialog_name: 'name2' }] }

    it 'can store unstructured options' do
      product = create :product, options: options
      expect(product.options[0][:dialog_name]).to eq(options[0]['dialog_name'])
      expect(product.options[1][:dialog_name]).to eq(options[1]['dialog_name'])
    end
  end
end

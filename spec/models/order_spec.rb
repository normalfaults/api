describe Order do
  context "options" do
    let(:options) {
      [{ dialog_name: "name", type:"text", default_value: "value"},
       { dialog_name: "name2", type: "dropdown", default_value: "value", options: ["option1", "option2", "option3"]}]}

    it "can store unstructured options" do
      create :order, options: options
      order = Order.first

      expect(order.options[0][:dialog_name]).to eq(options[0]['dialog_name'])
      expect(order.options[1][:dialog_name]).to eq(options[1]['dialog_name'])
    end
  end
end
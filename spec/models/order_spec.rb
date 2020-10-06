require 'rails_helper'

RSpec.describe Order, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  customer = Customer.create(first_name:"Sinan" ,last_name:"cenngiz", phone:"1234567890", email:"sinancengiz@gmail.com")
  subject { Order.new(product_name: "Product Jack", product_count: 20, customer_id:customer.id )}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with invalid attributes" do
    subject.product_name = nil
    expect(subject).to_not be_valid
  end

  it "is valid with an integer product_count " do
    subject.product_count = 10
    expect(subject).to be_valid
  end

  it "is not valid without a product_count is integer" do
    subject.product_count = "ten"
    expect(subject).to_not be_valid
  end
  
  it "is valid with an existing customer" do
    puts customer.id
    subject.customer_id = customer.id
    expect(subject).to be_valid
  end

  it "is not valid without a customer exist" do
    subject.customer_id = "30"
    expect(subject).to_not be_valid
  end

end

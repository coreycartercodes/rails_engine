require 'rails_helper'

describe "New API" do
  xit "Sends Things" do
    create_list(:book, 3)

    get '/api/v1/books'

    expect(response).to be_successful
  end
end
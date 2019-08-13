require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Lists', 'Lists Collection' do

  explanation 'Lists resource'

  header 'Content-Type', 'application/json'

  route 'lists', 'Get all lists' do
    get 'Get Lists Collection' do
      let!(:list) do
        Fabricate.create(:list, name: 'Notification System', number: '42x', description: 'description', published: true)
      end

      let(:published_filter) { { 'filter[published_eq]' => true } }

      parameter :published_filter, with_example: true

      context '200' do
        example_request 'Getting the published lists' do
          expect(response_status).to eql(200)        
          expect(JSON.load(response_body)).to eql(
            { 'data' => [
              {
                'id' => '1',
                'type' => 'list',
                'attributes' => {
                  'name' => 'Notification System',
                  'number' => '42x',
                  'description' => 'description'
                  }
                }
              ]
            }
          )
        end
      end
    end
  end
end
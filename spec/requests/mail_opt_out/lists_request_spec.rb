require 'rails_helper'

module MailOptOut
  RSpec.describe ListsController, type: :request do
    describe 'GET /lists' do
      let!(:list) do
        Fabricate.create(:list, name: 'Notification System', number: '42x', description: 'description', published: true)
      end
      let(:params) { { 'filter[published_eq]' => true } }

      subject do
        # routes(Engine.routes, '/')
        # get(lists_path, params)
        get '/lists', params
      end

      it do
        expect(subject).to eql(200)
        expect(response_json['data'].size).to eql(1)
        expect(response_json['data'][0]).to eql(
          {
            'id'   =>  list.id.to_s,
            'type' => 'list',
            'attributes' => {
              'name'        => 'Notification System',
              'number'      => '42x',
              'description' => 'description'
             }
          }
        )
      end
    end

    describe 'POST /lists' do
      let(:params)  { {} }

      subject do
        # routes(Engine.routes, '/')
        # post(lists_path, params)
        post '/lists', params
      end

      context 'without a payload' do
        it do
          expect(subject).to eql(422)
          expect(response_json['errors'][0]['detail'])
            .to eq('Param is missing or the value is empty: data')
        end
      end

      context 'with a payload' do
        let(:params) do
          {
            data: {
              attributes: {
                name: 'Notification System',
                number: '42x'
              }
            }
          }
        end

        it do
          expect(subject).to eql(201)
          expect(response_json['data'])
            .to have_attribute(:name).with_value('Notification System')
        end
      end
    end

    describe 'DELETE /lists/:list_id' do
      let(:params) { {} }

      subject do
        # routes(Engine.routes, '/')
        # delete(list_path(id: list_id), params)
        delete "/lists/#{list_id}", params
      end

      context 'without a list' do
        let(:list_id) { rand(100) }

        it do
          expect {
            expect(subject).to eql(404)
          }.to_not change {
            List.count
          }
        end
      end

      context 'with a list' do
        let!(:list)   { Fabricate.create(:list) }
        let(:list_id) { list.id }

        it do
          expect {
            expect(subject).to eql(204)
          }.to change {
            List.count
          }.by(-1)
        end
      end
    end

    describe 'PUT/PATCH /lists/:list_id' do
      let(:params) { {} }

      subject do
        # routes(Engine.routes, '/')
        # put(list_path(id: list_id), params)
        put "/lists/#{list_id}", params
      end

      context 'without a list' do
        let(:list_id) { rand(100) }

        it do
          expect {
            expect(subject).to eql(404)
          }.to_not change {
            List.count
          }
        end
      end

      context 'with a list' do
        let!(:list)   { Fabricate.create(:list, published: true) }
        let(:list_id) { list.id }

        let(:params) do
          {
            data: {
              attributes: {
                name: 'New Name'
              }
            }
          }
        end

        it do
          expect {
            expect(subject).to eql(200)
          }.to change {
            list.reload.name
          }.to('New Name')
        end
      end
    end

    describe 'GET /lists/:list_id' do
      let(:params) { {} }

      subject do
        # routes(Engine.routes, '/')
        # get(list_path(id: list_id), params)
        get "/lists/#{list_id}", params
      end

      context 'without a list' do
        let(:list_id) { rand(100) }

        it { expect(subject).to eql(404) }
      end

      context 'with a list' do
        let!(:list)   { Fabricate.create(:list, name: 'Notification System', published: true) }
        let(:list_id) { list.id }

        it do
          expect(subject).to eql(200)
          expect(response_json['data'])
            .to have_attribute(:name).with_value('Notification System')
        end
      end
    end
  end
end

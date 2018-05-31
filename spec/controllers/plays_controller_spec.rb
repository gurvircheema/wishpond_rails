require 'rails_helper'

RSpec.describe PlaysController, type: :controller do
  let!(:play_list) { FactoryBot.create_list(:play, 2) }

  let!(:upload) do
    Upload.create(
      images: [
        fixture_file_upload(Rails.root.join('spec', 'photos', 'rails_logo.png'), 'image/png')
      ]
    )
  end

  describe '#index' do
    subject(:make_request) { get :index }
    before { make_request }

    it 'should have status 200' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'should assign plays' do
      expect(assigns(:plays).count).to eq(2)
      expect(assigns(:plays)).to eq(Play.all)
    end

    it 'should assign images' do
      expect(assigns(:random_10_images).count).to eq(1)
      expect(assigns(:random_10_images)).to eq(ActiveStorage::Blob.all)
    end
  end

  describe '#create' do
    subject(:make_request) { post :create, format: :json, params: params }
    let(:params) do
      { play: { timer: 4, url: 'www.google.ca/images/rails.png' } }
    end

    it 'should create new play' do
      expect { make_request }.to change { Play.count }.from(2).to(3)
    end
  end
end
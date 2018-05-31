require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  let!(:upload) {
    Upload.create(images: [fixture_file_upload('spec/photos/rails_logo.png', 'image/png')])
  }

  describe '#index' do
    subject(:make_request) { get(:index) }

    before { make_request }

    it 'should assign images' do
      expect(assigns(:images).count).to eq(1)
      expect(assigns(:images)).to eq(ActiveStorage::Blob.all)
    end

    it 'returns successful response' do
      expect(response).to be_successful
    end
  end

  describe '#create' do
    subject(:make_request) { post(:create, params: params)}

    let(:params) do
      {
        upload: { images: [fixture_file_upload('spec/photos/rails_logo.png', 'image/png')] }
      }
    end

    it 'creates new upload' do
      expect { make_request }.to change { Upload.count }.from(1).to(2)
    end

    it 'creates new blob' do
      expect { make_request }.to change { ActiveStorage::Blob.count }.from(1).to(2)
    end
  end
end
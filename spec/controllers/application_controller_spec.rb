require 'rails_helper'

RSpec.describe 'ApplicationController', type: :controller do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe '#authorize request' do
    context 'when auth token is passed' do
      before do
         allow(request).to receive(:headers).and_return(headers)
      end
      #private method authorize request return current user
      it 'sets current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context 'when auth token is not passed' do
      before do
         allow(request).to receive(:headers).and_return(invalid_headers)
      end
      it 'raises missing token error' do
        expect(subject.instance_eval { authorize_request }).
          raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end

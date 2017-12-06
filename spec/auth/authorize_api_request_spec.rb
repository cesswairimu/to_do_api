require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  #mock authorization header
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  #Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }
  #valid request subject
  subject(:valid_request_obj) { described_class.new(header) }

 # test suite for valid api call
  # This is the entry point in the service

  describe '#call' do
    # returns user  object when request is  valid
    context 'when user is valid' do
      it 'returns user object' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end
#returns an error message if user invalid
    context 'when request is invalid' do
      context 'when token is missing' do
        it 'raises a MissingTokenError' do
          expect{ invalid_request_obj.call }
          .to raise_error(ExpectionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          #custom helper method 'token_generator'
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises TokenInvalid error' do
          expect{ invalid_request_obj.call }
          .to raise_error(ExpectionHandler::InvalidToken, /Invalid Token/)
        end
      end
      context 'when token is expired' do
        let(:header){ { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExpectionHandler::ExpiredSignature error' do
          expect{ invalid_request_obj.call }
          .to raise_error(ExpectionHandler::InvalidToken, /Signature has expired/)
        end
      end
    end
  end
end


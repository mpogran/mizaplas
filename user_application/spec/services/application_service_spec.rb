require 'rails_helper'

RSpec.describe ApplicationService, type: :service do
  describe 'Response' do
    subject { ApplicationService::Response.new }

    describe 'errors' do
      it 'instantiates ActiveModel::Errors' do
        expect(subject.errors).to be_a(ActiveModel::Errors)
      end

      it 'allows for adding errors' do
        expect { subject.errors.add(:base, :invalid) }.not_to raise_error
      end

      it 'can return error details' do
        subject.errors.add(:base, :invalid)
        expect(subject.errors.details).to eq(base: [{error: :invalid}])
      end
    end

    describe 'success?' do
      it 'returns false' do
        expect(subject).not_to be_success
      end

      context 'after success! call' do
        it 'returns true' do
          subject.success!
        expect(subject).to be_success
        end
      end
    end

    describe 'success!' do
      it 'sets `success` to true' do
        expect { subject.success! }.to change { subject.success? }
      end

      it 'returns Response instance' do
        expect(subject.success!).to eq(subject)
      end
    end
  end

  describe '::call' do
    let(:instance) { double('Service', call: true) }
    before(:each) { allow(ApplicationService).to receive(:new).and_return(instance) }

    it 'instantiates new Service' do
      expect(ApplicationService).to receive(:new).and_return(instance)
      call
    end

    it 'invokes #call on Service instance' do
      expect(instance).to receive(:call)
      call
    end
  end

  describe '#initialize' do
    it 'instantiates a Response object' do
      expect(subject.response).not_to be_nil
    end
  end
end

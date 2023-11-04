# frozen_string_literal: true

require_relative '../../models/init'
require 'sinatra/activerecord'

RSpec.describe Question do
  describe 'validations' do
    let(:question) { Question.new }

    it 'requires a question' do
      question.question = ''
      expect(question.valid?).to be_falsey
      expect(question.errors[:question]).to include("can't be blank")
    end

    it 'requires positive points' do
      question.pointQuestion = -10
      expect(question.valid?).to be_falsey
      expect(question.errors[:pointQuestion]).to include('must be a positive number')
    end

    it 'requires differents answers' do
      question.answer = 'Buenos Aires'
      question.wrongAnswer1 = 'buenos aires'
      expect(question.valid?).to be_falsey
      expect(question.errors[:answer]).to include('must be different answers')
    end
  end
end

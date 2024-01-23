require "spec_helper"

RSpec.describe RSpec::Sidekiq::Matchers::BeDead do
  describe "#be_dead" do
    it { expect(be_dead).to be_a described_class }
  end

  describe "#description" do
    specify { expect(described_class.new.description).to eq("to be dead") }
  end

  describe "#failure_message" do
    subject(:matcher) { described_class.new }

    let(:job) { create_worker }

    before { matcher.matches?(job) }

    specify { expect(matcher.failure_message).to eq("expected #{job} to be dead") }
  end

  describe "#failure_message_when_negated" do
    subject(:matcher) { described_class.new }

    let(:job) { create_worker(dead: true) }

    before { matcher.matches?(job) }

    specify { expect(matcher.failure_message_when_negated).to eq("expected #{job} to not be dead") }
  end

  describe "#matches?" do
    let(:matcher) { described_class.new }

    context "when job is dead" do
      let(:job) { create_worker(dead: true) }

      specify { expect(matcher).to be_matches(job) }
      it { expect(job).to be_dead }
    end

    context "when job is not dead" do
      let(:job) { create_worker(dead: false) }

      specify { expect(matcher).not_to be_matches(job) }
      it { expect(job).not_to be_dead }
    end
  end
end

require "./lib/exceptions/invalid_remote_url_error"
require "./lib/exceptions/invalid_search_field_error"
require "./services/search_service"

RSpec.describe SearchService do
  describe "#filter_results" do
    context "when the search field and query parameters are present" do
      context "when a user searches by email with the term 'yahoo'" do
        subject { described_class.new("email", "yahoo").filter_results }
        let(:result) { subject.map { |r| r["email"].include?("yahoo") }.all?(true) }

        it { expect(result).to be_truthy }
      end

      context "when a user searches by email with the term 'shiftcare'" do
        subject { described_class.new("email", "shiftcare").filter_results }

        it { expect(subject).to be_empty }
      end

      context "when a user searches by ID equaling to '2'" do
        subject { described_class.new("id", "2").filter_results }

        it { expect(subject.first["id"]).to eq(2) }
      end

      context "when a user searches by ID equaling to '999'" do
        subject { described_class.new("id", "999").filter_results }

        it { expect(subject).to be_empty }
      end

      context "when a user indicates a valid remote URL" do
        it do
          expect do
            described_class.new("email", "yahoo", "https://appassets02.shiftcare.com/manual/clients.json").filter_results
          end.not_to raise_error
        end
      end

      context "when a user indicates an invalid remote URL" do
        it do
          expect do
            described_class.new("email", "yahoo", "someserver.com/clients").filter_results
          end.to raise_error(InvalidRemoteUrlError)
        end
      end

      context "when a user indicates an invalid search field" do
        it do
          expect do
            described_class.new("xyz", "yahoo").filter_results
          end.to raise_error(InvalidSearchFieldError)
        end
      end
    end
  end

  describe "#check_duplicates" do
    context "when i count how many duplicate emails are present in the result set" do
      subject { described_class.new.check_duplicates }
      let(:result) { subject.map { |r| r["email"] }.uniq.count > 1 }

      it { expect(result).to be_truthy }
    end
  end
end

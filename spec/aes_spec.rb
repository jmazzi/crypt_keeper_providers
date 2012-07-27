require 'spec_helper'

module CryptKeeperProviders
  describe Aes do
    subject { Aes.new(passphrase: 'cake') }

    describe "#initialize" do
      let(:hexed_key) do
        Digest::SHA256.digest('cake')
      end

      it "should extract the key and digest it" do
        subject.key.should == hexed_key
      end
    end

    describe "#encrypt" do
      let(:encrypted) do
        subject.encrypt 'string'
      end

      it "should encrypt the string" do
        encrypted.should_not == 'string'
        encrypted.should_not be_nil
        encrypted.should_not be_empty
      end
    end

    describe "#decrypt" do
      let(:decrypted) do
        subject.decrypt "MC43OTY2ODQyNDQ3NTY5MjEyOqSiE883orEdXscCaeh2sKo=\n"
      end

      it "should decrypt the string" do
        decrypted.should == 'string'
      end
    end
  end
end

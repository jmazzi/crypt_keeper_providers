require 'spec_helper'

module CryptKeeperProviders
  describe Aes do
    subject { Aes.new(key: 'cake') }

    describe "#initialize" do
      let(:hexed_key) do
        Digest::SHA256.digest('cake')
      end

      it "should extract the key and digest it" do
        subject.key.should == hexed_key
      end

      it "should raise an exception with a missing key" do
        expect { Aes.new }.to raise_error(ArgumentError, "Missing :key")
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

      it "should not encrypt nil" do
        subject.encrypt(nil).should be_nil
      end
    end

    describe "#decrypt" do
      let(:decrypted) do
        subject.decrypt "MC41MDk5MjI2NjgxMDI1MDI2OmNyeXB0X2tlZXBlcjpPI/8dCqWXDMVj7Jqs\nuwf/\n"
      end

      it "should decrypt the string" do
        decrypted.should == 'string'
      end

      it "should not decrypt nil" do
        subject.decrypt(nil).should be_nil
      end
    end
  end
end

require 'spec_helper'

module CryptKeeperProviders
  describe Aes do
    subject { Aes.new(passphrase: 'cake') }

    describe "#initialize" do
      let(:hexed_key) do
        Digest::SHA1.hexdigest('cake').unpack('a2'*32).map{|x|x.hex}.pack('c'*32)
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
        subject.decrypt "duEAvLPakSVPRx2yGSmP8Q==\n"
      end

      it "should decrypt the string" do
        decrypted.should == 'string'
      end
    end
  end
end

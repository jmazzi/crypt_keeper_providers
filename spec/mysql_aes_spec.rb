require 'spec_helper'

module CryptKeeperProviders
  describe MysqlAes do
    use_mysql

    let(:plain_text) { 'test' }
    let(:cipher_text) { "nbKOoWn8kvAw9k/C2Mex6Q==\n" }

    subject { MysqlAes.new key: 'candy' }

    its(:key) { should == 'candy' }

    describe "#initialize" do
      it "should raise an exception with a missing key" do
        expect { MysqlAes.new }.to raise_error(ArgumentError, "Missing :key")
      end
    end

    describe "#encrypt" do
      it "should encrypt the string" do
        subject.encrypt(plain_text).should_not == plain_text
        subject.encrypt(plain_text).should_not be_empty
      end
    end

    describe "#decrypt" do
      it "should decrypt the string" do
        subject.decrypt(cipher_text).should == plain_text
      end
    end
  end
end

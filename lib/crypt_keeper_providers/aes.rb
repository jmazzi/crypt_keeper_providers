require 'digest/sha1'
require 'openssl'
require 'base64'

module CryptKeeperProviders
  class Aes
    attr_accessor :key, :aes

    # Public: Initializes the class
    #
    #   options - A hash of options. :passphrase is required
    def initialize(options = {})
      @key         = options[:passphrase]
      @aes         = ::OpenSSL::Cipher::Cipher.new("AES-256-CBC")
      @aes.padding = 1
      @key         = Digest::SHA1.hexdigest(key).unpack('a2'*32).map{|x|x.hex}.pack('c'*32)
    end

    # Public: Encrypt a string
    #
    # Returns a string
    def encrypt(value)
      value = value.to_s
      aes.encrypt
      aes.key = key
      iv = rand.to_s
      Base64::encode64("#{iv}:#{aes.update(value) + aes.final}")
    end

    # Public: Decrypt a string
    #
    # Returns a string
    def decrypt(value)
      value = Base64::decode64(value.to_s)
      iv, value = value.split(':')
      aes.decrypt
      aes.key = key
      aes.update(value) + aes.final
    end
  end
end

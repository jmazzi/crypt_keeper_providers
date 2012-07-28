require 'digest/sha2'
require 'openssl'
require 'base64'

module CryptKeeperProviders
  class Aes
    SEPARATOR = ":crypt_keeper:"

    # Public: The encryption key
    attr_accessor :key

    # Public: An instance of  OpenSSL::Cipher::Cipher
    attr_accessor :aes

    # Public: Initializes the class
    #
    #   options - A hash of options. :passphrase is required
    def initialize(options = {})
      @key         = options[:passphrase]
      @aes         = ::OpenSSL::Cipher::Cipher.new("AES-256-CBC")
      @aes.padding = 1
      @key         = Digest::SHA256.digest(key)
    end

    # Public: Encrypt a string
    #
    # Returns a string
    def encrypt(value)
      aes.encrypt
      aes.key = key
      iv      = rand.to_s
      aes.iv  = iv
      Base64::encode64("#{iv}#{SEPARATOR}#{aes.update(value.to_s) + aes.final}")
    end

    # Public: Decrypt a string
    #
    # Returns a string
    def decrypt(value)
      iv, value = Base64::decode64(value.to_s).split(SEPARATOR)
      aes.decrypt
      aes.key = key
      aes.iv  = iv
      aes.update(value) + aes.final
    end
  end
end

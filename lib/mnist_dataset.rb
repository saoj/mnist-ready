require_relative 'mnist_digit.rb'
require 'csv'
require 'json'

class MnistDataset

    @@VERSION = "1.0.1"
    @@YEAR = "2023"

    @instance_mutex = Mutex.new
  
    private_class_method :new
  
    def initialize
        test_set = File.join(File.dirname(__FILE__), '..', 'data', 'mnist_test.csv')

        @train_set = []
        @test_set = []
        @all_set = []

        CSV.foreach(test_set) do |row|
            label, pixels = get_label_and_pixels(row)
            digit = MnistDigit.new(label, pixels)
            @test_set.push(digit)
            @all_set.push(digit)
        end

        (1..3).each do |index|
            train_set = File.join(File.dirname(__FILE__), '..', 'data', "mnist_train#{index}.csv")
            CSV.foreach(train_set) do |row|
                label, pixels = get_label_and_pixels(row)
                digit = MnistDigit.new(label, pixels)
                @train_set.push(digit)
                @all_set.push(digit)
            end
        end

    end

    attr_reader :all_set, :train_set, :test_set

    def self.instance
      return @instance if @instance
      @instance_mutex.synchronize do
        @instance ||= new
      end
      @instance
    end

    def info 

        s = "MNIST-READY #{@@VERSION} (#{@@YEAR})\n"
        s += "Author: Sergio Oliveira Jr\n"
        s += "URL: https://github.com/saoj/mnist-ready\n"
        s += "License: MIT\n"
        s += "\n"
        
        s += "Total number of digits: #{all_set.size}\n"
        s += pretty_hash(count_digits(all_set))
        s += "\n"
        
        s += "Total number of train digits: #{train_set.size}\n"
        s += pretty_hash(count_digits(train_set))
        s += "\n"

        s += "Total number of test digits: #{test_set.size}\n"
        s += pretty_hash(count_digits(test_set))
        s += "\n"

        digit = all_set.sample
        s += digit.ascii_image
        s += "\n"
    end

    private

    def get_label_and_pixels(row)
        label = row[0].to_i
        pixels = row[1..784].map(&:to_i)
        return label, pixels
    end

    def pretty_hash(hash)
        s = JSON.pretty_generate(hash.sort.to_h).gsub(":", " =>")
        s.sub!(/^\{\n/, '')
        s.sub!(/\}/, '')
        s.gsub!(/,/, '')
    end

    def count_digits(hash) 
        count = {}
        hash.each do |digit|
            label = digit.label
            if count.has_key?(label)
                count[label] = count[label] + 1
            else
                count[label] = 1
            end
        end
        count
    end

end
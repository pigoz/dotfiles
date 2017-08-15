module RubyMorseEncode
  class Tokenizer
    def initialize(input)
      @input = input
    end

    def call
      Ast.new(@input.lines.map do |line|
        Line.new(line.split(' ').map do |word|
          Word.new(word.split('').map do |letter|
            Letter.new(letter)
          end)
        end)
      end)
    end

    def self.AstListNode(separator)
      Class.new(Struct.new(:list)) do
        def visit(&block)
          self.class.new(list.map { |w| w.visit(&block) })
        end

        define_method :to_s do
          list.map(&:to_s).join(separator)
        end
      end
    end

    Ast = AstListNode("\n")
    Line = AstListNode("/")
    Word = AstListNode("|")

    class Letter < Struct.new(:letter)
      def visit(&block)
        self.class.new(yield(letter))
      end

      def to_s
        letter.to_s
      end
    end
  end
end

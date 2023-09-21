require 'minitest/autorun'
require 'stringio'
require 'debug'
require './lib/game'

describe Game do
  describe 'game behaviour' do
    it 'what it must do' do
      # for now this "test" is only used as a quick way to launch the app from
      # my editor. I am aware that it does not make any useful assertions, and
      # that as part of a CI/CD suite it would no work, since the process will
      # hang waiting for $stdin to receive input
      Game.new

      assert true
    end
  end
end

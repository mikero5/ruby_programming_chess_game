# coding: utf-8
#
#
#
#
#
#

require_relative '../board.rb'
require_relative '../piece.rb'


RSpec.describe Board do
  context "when testing the find_check method" do
    it "should correctly identify when a king is not in check" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_rook = Rook.new
      white_rook.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[2][0] = white_rook
      expect(board.find_check).to eq nil
    end

    it "should correctly identify when a king is not in check" do
      board = Board.new
      expect(board.find_check).to eq nil
    end

    it "should correctly identify when a king is in check by Rook column" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_rook = Rook.new
      white_rook.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[0][0] = white_rook
      expect(board.find_check).to eq [black_king, [[0,0],[0,7]]]
    end

    it "should correctly identify when a king is in check by Rook row" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_rook = Rook.new
      white_rook.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[7][7] = white_rook
      expect(board.find_check).to eq [black_king, [[7,7],[0,7]]]
    end

    it "should correctly identify when a king is in check by Bishop" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_bishop = Bishop.new
      white_bishop.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[4][3] = white_bishop
      expect(board.find_check).to eq [black_king, [[4,3],[0,7]]]
    end

    it "should correctly identify when a king is in check by Knight" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_knight = Knight.new
      white_knight.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[1][5] = white_knight
      expect(board.find_check).to eq [black_king, [[1,5],[0,7]]]
    end

    it "should correctly identify when a king is in check by Pawn" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_pawn = Pawn.new
      white_pawn.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[1][6] = white_pawn
      expect(board.find_check).to eq [black_king, [[1,6],[0,7]]]
    end

    it "should correctly identify when a king is in check by Queen diagonal" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_queen = Queen.new
      white_queen.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[4][3] = white_queen
      expect(board.find_check).to eq [black_king, [[4,3],[0,7]]]
    end

    it "should correctly identify when a king is in check by Queen column" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_queen = Queen.new
      white_queen.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[0][0] = white_queen
      expect(board.find_check).to eq [black_king, [[0,0],[0,7]]]
    end

    it "should correctly identify when a king is in check by Queen row" do
      board = Board.new
      board.clear
      black_king = King.new
      black_king.color = 'black'
      white_king = King.new
      white_king.color = 'white'
      white_queen = Queen.new
      white_queen.color = 'white'
      board.board[0][7] = black_king
      board.board[5][0] = white_king
      board.board[7][7] = white_queen
      expect(board.find_check).to eq [black_king, [[7,7],[0,7]]]
    end
  end # context "when testing the find_check method" do
end

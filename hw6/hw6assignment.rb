# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    # get all of the regular key bindings
    super
    # u key rotates by 180 deg.
    @root.bind('u', proc {@board.rotate_clockwise; @board.rotate_clockwise})
    # c key allows us to cheat
    @root.bind('c', proc {@board.cheat})
  end
end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces = All_Pieces + [rotations([[0, 0], [-1, 0], [-1, 1], [0, 1], [1, 1]]), # postman pat van
               [[[0, 0], [-1, 0], [1, 0], [2, 0], [3, 0]], # extra long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2], [0, 3]]],
               rotations([[0, 0], [0, -1], [1, -1]])] # corner

  # your enhancements here
  # class method to choose the next piece with our pieces
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  # cheat piece returns a piece of only one square
  def self.cheat_piece (board)
    MyPiece.new([[[0, 0]]], board)
  end

end

class MyBoard < Board
  # your enhancements here
  # overide Board's initialize so that we can use MyPiece and cheat
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheat = false # we will use this to check if we are going to cheat
  end

  # gets the next piece
  def next_piece
    # if cheat has been set then make the next piece a cheat piece
    if @cheat
      @current_block = MyPiece.cheat_piece(self)
      @cheat = false # don't forget to disable cheat
    else
      # otherwise just get the next random piece
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself.  Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    # this needs to go to 4 for the long line
    (0..4).each{|index|
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
      @current_pos[index] if current # the majority of arrays have less than 4 elements, so check this element is valid
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  # cheat, turns the next piece into a single piece at the cost of 100 points
  def cheat
    # only cheat if we have enough points and haven't already set cheat
    if @cheat == false and @score >= 100
      @score -= 100
      @cheat = true
    end
  end

end

class WhitePawn

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = "♟︎"
    @name = "WhitePawn"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  # Sets the range of legal moves for a white pawn
  def set_move_range(row, col, board)
    legal_moves = []

    if row == 6
      legal_moves.push([row - 1, col]) if board[row - 1][col].empty == true
      legal_moves.push([row - 2, col]) if board[row - 1][col].empty == true && board[row - 2][col].empty == true
    else
      legal_moves.push([row - 1, col]) if board[row - 1][col].empty == true
    end

    return legal_moves
  end

  # Sets the range of legal attacks for a white pawn
  def set_attack_range(row, col, board)
    legal_captures = []

    if (row - 1) >= 0 && (col + 1) <= 7
      if (board[row - 1][col + 1].empty == false) && (board[row - 1][col + 1].piece.color != @color)
        legal_captures.push([row - 1, col + 1])
      end
    end

    if (row - 1) >= 0 && (col - 1) >= 0
      if (board[row - 1][col - 1].empty == false) && (board[row - 1][col - 1].piece.color != @color)
        legal_captures.push([row - 1, col - 1])
      end
    end

    return legal_captures
  end

end

class BlackPawn

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = "♙"
    @name = "BlackPawn"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  def set_move_range(row, col, board)
    legal_moves = []

    if row == 1
      legal_moves.push([row + 1, col]) if board[row + 1][col].empty == true
      legal_moves.push([row + 2, col]) if board[row + 1][col].empty == true && board[row + 2][col].empty == true
    else
      legal_moves.push([row + 1, col]) if board[row + 1][col].empty == true
    end

    return legal_moves
  end

  def set_attack_range(row, col, board)
    legal_captures = []

    if (row + 1) <= 7 && (col + 1) <= 7
      if (board[row + 1][col + 1].empty == false) && (board[row + 1][col + 1].piece.color != @color)
        legal_captures.push([row + 1, col + 1])
      end
    end

    if (row + 1) <= 7 && (col - 1) >= 0
      if (board[row + 1][col - 1].empty == false) && (board[row + 1][col - 1].piece.color != @color)
        legal_captures.push([row + 1, col - 1])
      end
    end

    return legal_captures
  end

end

class Knight

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = set_image
    @name = "Knight"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  def set_image
    if @color == "white"
      image = "♞"
    elsif @color == "black"
      image = "♘"
    end
    return image
  end

  # Set the move range for a knight based on row, column, and current position.
  def set_move_range(row, col, board)
    legal_moves = [] 

    if (row - 2) >= 0
      if ((col + 1) <= 7) && board[row - 2][col + 1].empty == true
        legal_moves.push([row - 2, col + 1])
      end

      if ((col - 1) >= 0) && board[row - 2][col - 1].empty == true
        legal_moves.push([row - 2, col - 1])
      end
    end

    if (row + 2) <= 7
      if ((col + 1) <= 7) && board[row + 2][col + 1].empty == true
        legal_moves.push([row + 2, col + 1])
      end

      if ((col - 1) >= 0) && board[row + 2][col - 1].empty == true
        legal_moves.push([row + 2, col - 1])
      end
    end

    if (row - 1) >= 0
      if ((col + 2) <= 7) && board[row - 1][col + 2].empty == true
        legal_moves.push([row - 1, col + 2])
      end

      if ((col - 2) >= 0) && board[row - 1][col - 2].empty == true
        legal_moves.push([row - 1, col - 2])
      end
    end

    if (row + 1) <= 7
      if ((col + 2) <= 7) && board[row + 1][col + 2].empty == true
        legal_moves.push([row + 1, col + 2])
      end

      if ((col - 2) >= 0) && board[row + 1][col - 2].empty == true
        legal_moves.push([row + 1, col - 2])
      end
    end

    return legal_moves
  end

  # Sets attack range for a knight based on row, column, and current position.
  def set_attack_range(row, col, board)
    legal_captures = []

    if (row - 2) >= 0
      if ((col + 1) <= 7) && (board[row - 2][col + 1].empty == false) && 
        (board[row - 2][col + 1].piece.color != @color)
        legal_captures.push([row - 2, col + 1])
      end

      if ((col - 1) >= 0) && (board[row - 2][col - 1].empty == false) &&
        (board[row - 2][col - 1].piece.color != @color)
        legal_captures.push([row - 2, col - 1])
      end
    end

    if (row + 2) <= 7
      if ((col + 1) <= 7) && (board[row + 2][col + 1].empty == false) &&
        (board[row + 2][col + 1].piece.color != @color)
        legal_captures.push([row + 2, col + 1])
      end

      if ((col - 1) >= 0) && (board[row + 2][col - 1].empty == false) &&
        (board[row + 2][col - 1].piece.color != @color)
        legal_captures.push([row + 2, col - 1])
      end
    end

    if (row - 1) >= 0
      if ((col + 2) <= 7) && (board[row - 1][col + 2].empty == false) &&
        (board[row - 1][col + 2].piece.color != @color)
        legal_captures.push([row - 1, col + 2])
      end

      if ((col - 2) >= 0) && (board[row - 1][col - 2].empty == false) &&
        (board[row - 1][col - 2].piece.color != @color)
        legal_captures.push([row - 1, col - 2])
      end
    end

    if (row + 1) <= 7
      if ((col + 2) <= 7) && (board[row + 1][col + 2].empty == false) &&
        (board[row + 1][col + 2].piece.color != @color)
        legal_captures.push([row + 1, col + 2])
      end

      if ((col - 2) >= 0) && (board[row + 1][col - 2].empty == false) &&
        (board[row + 1][col - 2].piece.color != @color)
        legal_captures.push([row + 1, col - 2])
      end
    end

    return legal_captures
  end

end

class Bishop

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = set_image
    @name = "Bishop"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  def set_image
    if @color == "white"
      image = "♝"
    elsif @color == "black"
      image = "♗"
    end
    return image
  end

  # Sets the move range for a bishop.
  def set_move_range(row, col, board)
    legal_moves = []

    i = row
    j = col
    while ((i + 1) <= 7) && ((j + 1) <= 7) && (board[i + 1][j + 1].empty == true)
      legal_moves.push([i + 1, j + 1])
      i += 1
      j += 1
    end

    i = row
    j = col
    while ((i + 1) <= 7) && ((j - 1) >= 0) && (board[i + 1][j - 1].empty == true)
      legal_moves.push([i + 1, j - 1])
      i += 1
      j -= 1
    end

    i = row
    j = col
    while ((i - 1) >= 0) && ((j + 1) <= 7) && (board[i - 1][j + 1].empty == true)
      legal_moves.push([i - 1, j + 1])
      i -= 1
      j += 1
    end

    i = row
    j = col
    while ((i - 1) >= 0) && ((j - 1) >= 0) && (board[i - 1][j - 1].empty == true)
      legal_moves.push([i - 1, j - 1])
      i -= 1
      j -= 1
    end

    puts "legal bishop moves for #{row} #{col} are now #{legal_moves}"
    return legal_moves
  end

  # Sets the attack range for a bishop.
  def set_attack_range(row, col, board)
    legal_captures = []

    i = row
    j = col
    while (i + 1) <= 7 && (j + 1) <= 7
      blocked = false
      if board[i + 1][j + 1].empty == true
        i += 1
        j += 1
        next
      elsif board[i + 1][j + 1].piece.color != @color
        legal_captures.push([i + 1, j + 1])
        blocked = true
      end

      break if blocked == true
      i += 1
      j += 1
    end

    i = row
    j = col
    while (i + 1) <= 7 && (j - 1) >= 0
      blocked = false
      if board[i + 1][j - 1].empty == true
        i += 1
        j -= 1
        next
      elsif board[i + 1][j - 1].piece.color != @color
        legal_captures.push([i + 1, j - 1])
        blocked = true
      end

      break if blocked == true
      i += 1
      j -= 1
    end

    i = row
    j = col
    while  (i - 1) >= 0 && (j + 1) <= 7
      blocked = false
      if board[i - 1][j + 1].empty == true
        i -= 1
        j += 1
        next
      elsif board[i - 1][j + 1].piece.color != @color
        legal_captures.push([i - 1, j + 1])
        blocked = true
      end

      break if blocked == true
      i -= 1
      j += 1
    end

    i = row
    j = col
    while (i - 1) >= 0 && (j - 1) >= 0
      blocked = false
      if board[i - 1][j - 1].empty == true
        i -= 1
        j -= 1
        next
      elsif board[i - 1][j - 1].piece.color != @color
        legal_captures.push([i - 1, j - 1])
        blocked = true
      end

      break if blocked == true
      i -= 1
      j -= 1
    end

    return legal_captures
  end

end

class Rook

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = set_image
    @name = "Rook"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  def set_image
    if @color == "white"
      image = "♜"
    elsif @color == "black"
      image = "♖"
    end
    return image
  end

  # Sets the move range for a rook.
  def set_move_range(row, col, board)
    legal_moves = []

    i = row
    while (i + 1) <= 7 && board[i + 1][col].empty == true
      legal_moves.push([i + 1, col])
      i += 1
    end

    i = row
    while (i - 1) >= 0 && board[i - 1][col].empty == true
      legal_moves.push([i - 1, col])
      i -= 1
    end

    i = col
    while (i + 1) <= 7 && board[row][i + 1].empty == true
      legal_moves.push([row, i + 1])
      i += 1
    end

    i = col
    while (i - 1) >= 0 && board[row][i - 1].empty == true
      legal_moves.push([row, i - 1])
      i -= 1
    end

    return legal_moves
  end

  # Sets the attack range for a rook.
  def set_attack_range(row, col, board)
    legal_captures = []

    i = row
    while (i + 1) <= 7
      blocked = false
      if board[i + 1][col].empty == true
        i += 1
        next
      elsif board[i + 1][col].piece.color != @color
        legal_captures.push([i + 1, col])
        blocked = true
      end

      break if blocked == true
      i += 1
    end

    i = row
    while (i - 1) >= 0
      blocked = false
      if board[i - 1][col].empty == true
        i -= 1
        next
      elsif board[i - 1][col].piece.color != @color
        legal_captures.push([i - 1, col])
        blocked = true
      end

      break if blocked == true
      i -= 1
    end

    i = col
    while (i + 1) <= 7
      blocked = false
      if board[row][i + 1].empty == true
        i += 1
        next
      elsif board[row][i + 1].piece.color != @color
        legal_captures.push([row, i + 1])
        blocked = true
      end

      break if blocked == true
      i += 1
    end

    i = col
    while (i - 1) >= 0
      blocked = false
      if board[row][i - 1].empty == true
        i -= 1
        next
      elsif board[row][i - 1].piece.color != @color
        legal_captures.push([row, i - 1])
        blocked = true
      end

      break if blocked == true
      i -= 1
    end

    return legal_captures
  end

end

class Queen

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = set_image
    @name = "Queen"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  def set_image
    if @color == "white"
      image = "♛"
    elsif @color == "black"
      image = "♕"
    end
    return image
  end

  # Sets the move range for a queen.
  def set_move_range(row, col, board)
    legal_moves = []

    i = row
    while (i + 1) <= 7 && board[i + 1][col].empty == true
      legal_moves.push([i + 1, col])
      i += 1
    end

    i = row
    while (i - 1) >= 0 && board[i - 1][col].empty == true
      legal_moves.push([i - 1, col])
      i -= 1
    end

    i = col
    while (i + 1) <= 7 && board[row][i + 1].empty == true
      legal_moves.push([row, i + 1])
      i += 1
    end

    i = col
    while (i - 1) >= 0 && board[row][i - 1].empty == true
      legal_moves.push([row, i - 1])
      i -= 1
    end

    i = row
    j = col
    while ((i + 1) <= 7) && ((j + 1) <= 7) && (board[i + 1][j + 1].empty == true)
      legal_moves.push([i + 1, j + 1])
      i += 1
      j += 1
    end

    i = row
    j = col
    while ((i + 1) <= 7) && ((j - 1) >= 0) && (board[i + 1][j - 1].empty == true)
      legal_moves.push([i + 1, j - 1])
      i += 1
      j -= 1
    end

    i = row
    j = col
    while ((i - 1) >= 0) && ((j + 1) <= 7) && (board[i - 1][j + 1].empty == true)
      legal_moves.push([i - 1, j + 1])
      i -= 1
      j += 1
    end

    i = row
    j = col
    while ((i - 1) >= 0) && ((j - 1) >= 0) && (board[i - 1][j - 1].empty == true)
      legal_moves.push([i - 1, j - 1])
      i -= 1
      j -= 1
    end

    return legal_moves
  end

  # Sets the attack range for a queen.
  def set_attack_range(row, col, board)
    legal_captures = []

    i = row
    j = col
    while (i + 1) <= 7 && (j + 1) <= 7
      blocked = false
      if board[i + 1][j + 1].empty == true
        i += 1
        j += 1
        next
      elsif board[i + 1][j + 1].piece.color != @color
        legal_captures.push([i + 1, j + 1])
        blocked = true
      end

      break if blocked == true
      i += 1
      j += 1
    end

    i = row
    j = col
    while (i + 1) <= 7 && (j - 1) >= 0
      blocked = false
      if board[i + 1][j - 1].empty == true
        i += 1
        j -= 1
        next
      elsif board[i + 1][j - 1].piece.color != @color
        legal_captures.push([i + 1, j - 1])
        blocked = true
      end

      break if blocked == true
      i += 1
      j -= 1
    end

    i = row
    j = col
    while (i - 1) >= 0 && (j + 1) <= 7
      blocked = false
      if board[i - 1][j + 1].empty == true
        i -= 1
        j += 1
        next
      elsif board[i - 1][j + 1].piece.color != @color
        legal_captures.push([i - 1, j + 1])
        blocked = true
      end

      break if blocked == true
      i -= 1
      j += 1
    end

    i = row
    j = col
    while (i - 1) >= 0 && (j - 1) >= 0
      blocked = false
      if board[i - 1][j - 1].empty == true
        i -= 1
        j -= 1
        next
      elsif board[i - 1][j - 1].piece.color != @color
        legal_captures.push([i - 1, j - 1])
        blocked = true
      end

      break if blocked == true
      i -= 1
      j -= 1
    end

    i = row
    while (i + 1) <= 7
      if board[i + 1][col].empty == true
        i += 1
        next
      elsif board[i + 1][col].piece.color != @color
        legal_captures.push([i + 1, col])
        blocked = true
      end

      break if blocked == true
      i += 1
    end

    i = row
    while (i - 1) >= 0
      blocked = false
      if board[i - 1][col].empty == true
        i -= 1
        next
      elsif board[i - 1][col].piece.color != @color
        legal_captures.push([i - 1, col])
        blocked = true
      end

      break if blocked == true
      i -= 1
    end

    i = col
    while (i + 1) <= 7
      blocked = false
      if board[row][i + 1].empty == true
        i += 1
        next
      elsif board[row][i + 1].piece.color != @color
        legal_captures.push([row, i + 1])
        blocked = true
      end

      break if blocked == true
      i += 1
    end

    i = col
    while (i - 1) >= 0
      blocked = false
      if board[row][i - 1].empty == true
        i -= 1
        next
      elsif board[row][i - 1].piece.color != @color
        legal_captures.push([row, i - 1])
        blocked = true
      end

      break if blocked == true
      i -= 1
    end

    return legal_captures
  end

end

class King

  attr_accessor :row, :col, :color, :image, :name, :board, :move_range, :attack_range

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
    @image = set_image
    @name = "King"
    @board = nil
    @move_range = nil
    @attack_range = nil
  end

  def set_image
    if @color == "white"
      image = "♚"
    elsif @color == "black"
      image = "♔"
    end
    return image
  end

  # Sets the move range for the king
  def set_move_range(row, col, board)
    legal_moves = []

    if (row + 1) <= 7 && (col + 1) <= 7 && board[row + 1][col + 1].empty == true
      legal_moves.push([row + 1, col + 1])
    end

    if (col + 1) <= 7 && board[row][col + 1].empty == true
      legal_moves.push([row, col + 1])
    end

    if (row + 1) <= 7 && (col - 1) >= 0 && board[row + 1][col - 1].empty == true
      legal_moves.push([row + 1, col - 1])
    end

    if (col - 1) >= 0 && board[row][col - 1].empty == true
      legal_moves.push([row, col - 1])
    end

    if (row - 1) >= 0 && (col + 1) <= 7 && board[row - 1][col + 1].empty == true
      legal_moves.push([row - 1, col + 1])
    end

    if (row + 1) <= 7 && board[row + 1][col].empty == true
      legal_moves.push([row + 1, col])
    end

    if (row - 1) >= 0 && (col - 1) >= 0 && board[row - 1][col - 1].empty == true
      legal_moves.push([row - 1, col - 1])
    end

    if (row - 1) >= 0 && board[row - 1][col].empty == true
      legal_moves.push([row - 1, col])
    end

    return legal_moves
  end

  # Sets attack range for the king.
  def set_attack_range(row, col, board)
    legal_captures = []

    if (row + 1) <= 7 && (col + 1) <= 7 && board[row + 1][col + 1].empty == false
      if board[row + 1][col + 1].piece.color != @color
        legal_captures.push([row + 1, col + 1])
      end
    end

    if (col + 1) <= 7 && board[row][col + 1].empty == false
      if board[row][col + 1].piece.color != @color
        legal_captures.push([row, col + 1])
      end
    end

    if (row + 1) <= 7 && (col - 1) >= 0 && board[row + 1][col - 1].empty == false
      if board[row + 1][col - 1].piece.color != @color
        legal_captures.push([row + 1, col - 1])
      end
    end

    if (col - 1) >= 0 && board[row][col - 1].empty == false
      if board[row][col - 1].piece.color != @color
        legal_captures.push([row, col - 1])
      end
    end

    if (row - 1) >= 0 && (col + 1) <= 7 && board[row - 1][col + 1].empty == false
      if board[row - 1][col + 1].piece.color != @color
        legal_captures.push([row - 1, col + 1])
      end
    end

    if (row + 1) <= 7 && board[row + 1][col].empty == false
      if board[row + 1][col].piece.color != @color
        legal_captures.push([row + 1, col])
      end
    end

    if (row - 1) >= 0 && (col - 1) >= 0 && board[row - 1][col - 1].empty == false
      if board[row - 1][col - 1].piece.color != @color
        legal_captures.push([row - 1, col - 1])
      end
    end

    if (row - 1) >= 0 && board[row - 1][col].empty == false
      if board[row - 1][col].piece.color != @color
        legal_captures.push([row - 1, col])
      end
    end

    return legal_captures
  end

end

# =============================================================================
# END PIECES
# =============================================================================

class Square

  attr_accessor :row, :col, :empty, :piece, :image

  def initialize(row, col)
    @row = row
    @col = col
    @empty = true
    @piece = nil
    @image = " "
  end
end

class Game

  attr_accessor :board, :white_pieces, :black_pieces

  def initialize
    @board = create_board
    @white_pieces = []
    @black_pieces = []
    set_up_board(@board)
    @current_player = "white"
  end

  def create_board
    board_array = []
    i = 0
    while i < 8
      row = Array.new
      j = 0
      while j < 8
        square = Square.new(i, j)
        row.append(square)
        j += 1
      end
      board_array.append(row)
      i += 1
    end
    return board_array
  end

  def set_up_board(board)

    pieces = []

    pieces << @black_queen_rook = Rook.new(0, 0, "black")
    pieces << @black_queen_knight = Knight.new(0, 1, "black")
    pieces << @black_queen_bishop = Bishop.new(0, 2, "black")
    pieces << @black_queen = Queen.new(0, 3, "black")
    pieces << @black_king = King.new(0, 4, "black")
    pieces << @black_king_bishop = Bishop.new(0, 5, "black")
    pieces << @black_king_knight = Knight.new(0, 6, "black")
    pieces << @black_king_rook = Rook.new(0, 7, "black")

    pieces << @black_a_pawn = BlackPawn.new(1, 0, "black")
    pieces << @black_b_pawn = BlackPawn.new(1, 1, "black")
    pieces << @black_c_pawn = BlackPawn.new(1, 2, "black")
    pieces << @black_d_pawn = BlackPawn.new(1, 3, "black")
    pieces << @black_e_pawn = BlackPawn.new(1, 4, "black")
    pieces << @black_f_pawn = BlackPawn.new(1, 5, "black")
    pieces << @black_g_pawn = BlackPawn.new(1, 6, "black")
    pieces << @black_h_pawn = BlackPawn.new(1, 7, "black")

    pieces << @white_a_pawn = WhitePawn.new(6, 0, "white")
    pieces << @white_b_pawn = WhitePawn.new(6, 1, "white")
    pieces << @white_c_pawn = WhitePawn.new(6, 2, "white")
    pieces << @white_d_pawn = WhitePawn.new(6, 3, "white")
    pieces << @white_e_pawn = WhitePawn.new(6, 4, "white")
    pieces << @white_f_pawn = WhitePawn.new(6, 5, "white")
    pieces << @white_g_pawn = WhitePawn.new(6, 6, "white")
    pieces << @white_h_pawn = WhitePawn.new(6, 7, "white")

    pieces << @white_queen_rook = Rook.new(7, 0, "white")
    pieces << @white_queen_knight = Knight.new(7, 1, "white")
    pieces << @white_queen_biship = Bishop.new(7, 2, "white")
    pieces << @white_queen = Queen.new(7, 3, "white")
    pieces << @white_king = King.new(7, 4, "white")
    pieces << @white_king_bishop = Bishop.new(7, 5, "white")
    pieces << @white_king_knight = Knight.new(7, 6, "white")
    pieces << @white_king_rook = Rook.new(7, 7, "white")

    pieces.each do |piece|
      board[piece.row][piece.col].piece = piece
      board[piece.row][piece.col].image = piece.image
      board[piece.row][piece.col].empty = false
    end

    pieces.each do |piece|
      piece.board = board
      piece.move_range = piece.set_move_range(piece.row, piece.col, piece.board)
      piece.attack_range = piece.set_attack_range(piece.row, piece.col, piece.board)
    end

    pieces[0..15].each do |piece|
      @black_pieces.push(piece)
    end

    pieces[16..31].each do |piece|
      @white_pieces.push(piece)
    end

  end

  def print_board
    number_labels = ["8", "7", "6", "5", "4", "3", "2", "1"]
    print "  +---+---+---+---+---+---+---+---+\n"
    @board.each_with_index do |row, index|
      print "#{number_labels[index]} "
      row.each do |col|
        print "| #{col.image} "
      end
      print "|\n"
      print "  +---+---+---+---+---+---+---+---+\n"
    end
    print "    a   b   c   d   e   f   g   h   \n"
  end

  def play
    while checkmate? == false
      print_board
      move = prompt_for_move
      make_move(move)
      print_board
      update_move_attack_ranges(@board)
      switch_player


    end
  end

  def checkmate?
    return false
  end

  def prompt_for_move
    puts "Enter your move:"
    move = gets.chomp

    # Checks that the player's input is in valid chess notation and is a legal move
    while valid_notation?(move) == false || legal_move?(move) == false
      if valid_notation?(move) == false
        puts "That move is not in valid chess notation. Please try again:"
      elsif legal_move?(move) == false
        puts "That move is not legal to play. Please try again:"
      end
      move = gets.chomp
    end

    return move
  end

  # Checks whether the player's input is in valid move notation
  def valid_notation?(move)

    # Valid letters in chess notation
    letter_array = ["R", "N", "B", "Q", "K", "a", "b", "c", "d", "e", "f", "g", "h"]
    move_first_letter = move.slice(0)

    # If the first letter doesn't indicate a valid piece
    if !letter_array.include?move_first_letter
      return false
    end

    # If it's a pawn move
    if letter_array[5..12].include?move_first_letter
      if valid_pawn_notation?(move)
        return true
      else
        return false
      end
    end

    # If it's a knight move
    if move_first_letter == "N"
      if valid_knight_notation?(move)
        return true
      else
        return false
      end
    end

    # If it's a bishop move
    if move_first_letter == "B"
      if valid_bishop_notation?(move)
        return true
      else
        return false
      end
    end
    
    # If it's a rook move
    if move_first_letter == "R"
      rook_move = valid_rook_notation?(move)
      if rook_move
        return true
      else
        return false
      end
    end
    
    #If it's a queen move
    if move_first_letter == "Q"
      queen_move = valid_queen_notation?(move)
      if queen_move
        return true
      else
        return false
      end
    end

    #If it's a king move
    if move_first_letter == "K"
      king_move = valid_king_notation?(move)
      if king_move
        return true
      else
        return false
      end
    end
  end

  # Checks pawn moves for valid notation
  def valid_pawn_notation?(move)

    pawn_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    pawn_numbers = ["3", "4", "5", "6", "7"]
    piece_letters = ["R", "N", "B", "Q"]

    first_char = move.slice(0)
    second_char = move.slice(1)
    third_char = move.slice(2)
    fourth_char = move.slice(3)
    fifth_char = move.slice(4)

    # The move must be 2 to 5 characters long
    if !move.length.between?(2, 5)
      return false
    end

    # Simple pawn push
    if move.length == 2 
      if !second_char.to_i.between?(3, 7)
        return false
      end
    # Push a pawn to promotion
    elsif move.length == 3 
      if second_char != "8"
        return false
      elsif !piece_letters.include?(third_char)
        return false
      end
    # Pawn capture
    elsif move.length == 4 
      if second_char != "x"
        return false
      elsif !pawn_numbers.include?(fourth_char)
        return false
      elsif pawn_letters.index(third_char) != (pawn_letters.index(first_char) + 1) &&
            pawn_letters.index(third_char) != (pawn_letters.index(first_char) - 1) 
        return false
      end
    # Pawn capture on 8th rank with promotion
    elsif move.length == 5
      if second_char != "x"
        return false
      elsif fourth_char != "8"
        return false
      elsif pawn_letters.index(third_char) != (pawn_letters.index(first_char) + 1) &&
            pawn_letters.index(third_char) != (pawn_letters.index(first_char) - 1) 
        return false
      elsif !piece_letters.include?(fifth_char)
        return false
      end
    end

    return true
  end

  # Checks knight moves for valid notation
  def valid_knight_notation?(move)
    board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]

    first_char = move.slice(0)
    second_char = move.slice(1)
    third_char = move.slice(2)
    fourth_char = move.slice(3)
    fifth_char = move.slice(4)

    if !move.length.between?(3, 5)
      return false
    end

    # Simple knight move
    if move.length == 3
      if !board_letters.include?(second_char)
        return false
      elsif !board_numbers.include?(third_char)
        return false
      end
    # Capture or disambiguation
    elsif move.length == 4
      # If the second letter is not x or a valid board letter
      if second_char != "x" && !board_letters.include?(second_char)
        return false
      # If the third letter is not a valid board letter
      elsif !board_letters.include?(third_char) 
        return false
      # In the case of a disambiguation,
      # if the second board letter is an impossible distance from the first
      elsif second_char != "x" &&
            board_letters.index(third_char) != (board_letters.index(second_char) + 1) &&
            board_letters.index(third_char) != (board_letters.index(second_char) + 2) &&
            board_letters.index(third_char) != (board_letters.index(second_char) - 1) &&
            board_letters.index(third_char) != (board_letters.index(second_char) - 2)
        return false
      # If the last character is not a valid board letter
      elsif !board_numbers.include?(fourth_char) 
        return false
      end
    # Capture with disambiguation
    elsif move.length == 5 
      if !board_letters.include?(second_char)
        return false
      elsif third_char != "x"
        return false
      elsif board_letters.index(fourth_char) != (board_letters.index(second_char) + 1) &&
            board_letters.index(fourth_char) != (board_letters.index(second_char) + 2) &&
            board_letters.index(fourth_char) != (board_letters.index(second_char) - 1) &&
            board_letters.index(fourth_char) != (board_letters.index(second_char) - 2)
        return false
      elsif !board_numbers.include?(fifth_char)
        return false
      end
    end

    return true
  end

  #Checks bishop moves for valid notation
  def valid_bishop_notation?(move)
    board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]

    first_char = move.slice(0)
    second_char = move.slice(1)
    third_char = move.slice(2)
    fourth_char = move.slice(3)

    # Move length must be 3, 4, or 5 characters
    if !move.length.between?(3, 5)
      return false
    end

    # Regular bishop move
    if move.length == 3 
      if !board_letters.include?(second_char)
        return false
      elsif !board_numbers.include?(third_char)
        return false
      end
    # Capture or disambiguation
    elsif move.length == 4 
      if second_char != "x" && !board_letters.include?(second_char)
        return false
      elsif !board_letters.include?(third_char)
        return false
      elsif !board_numbers.include?(fourth_char)
        return false
      end
    # Capture with disambiguation
    elsif move.length == 5
      if !board_letters.include?(second_char)
        return false
      elsif third_char != "x"
        return false
      elsif !board_letters.include?(fourth_char)
        return false
      elsif !board_numbers.include?(fifth_char)
        return false
      end
    end
    
    return true
  end

  #Checks rook moves for valid notation
  def valid_rook_notation?(move)
    board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]

    first_char = move.slice(0)
    second_char = move.slice(1)
    third_char = move.slice(2)
    fourth_char = move.slice(3)
    fifth_char = move.slice(4)

    # Move length must be 3, 4, or 5 characters
    if !move.length.between?(3, 5)
      return false
    end

    # Regular rook move
    if move.length == 3 
      if !board_letters.include?(second_char)
        return false
      elsif !board_numbers.include?(third_char)
        return false
      end
    # Capture or disambiguation of a regular move
    elsif move.length == 4 
      if second_char != "x" && !board_letters.include?(second_char) && !board_numbers.include?(second_char)
        return false
      elsif !board_letters.include?(third_char)
        return false
      elsif !board_numbers.include?(fourth_char)
        return false
      end
    # Capture with disambiguation
    elsif move.length == 5
      if !board_letters.include?(second_char) || !board_letters.include?(fourth_char)
        return false
      elsif third_char != "x"
        return false
      elsif !board_numbers.include?(fifth_char)
        return false
      end
    end
    
    return true
  end

  # Checks queen moves for valid notation
  def valid_queen_notation?(move)
    board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]

    first_char = move.slice(0)
    second_char = move.slice(1)
    third_char = move.slice(2)
    fourth_char = move.slice(3)
    fifth_char = move.slice(4)

    # Move length must be 3, 4, or 5 characters
    if !move.length.between?(3, 5)
      return false
    end

    # Regular queen move
    if move.length == 3
      if !board_letters.include?(second_char)
        return false
      elsif !board_numbers.include?(third_char)
        return false
      end
    # Queen capture or regular move disambiguation
    elsif move.length == 4
      if second_char != "x" && !board_letters.include?(second_char)
        return false
      elsif !board_letters.include?(third_char)
        return false
      elsif !board_numbers.include?(fourth_char)
        return false
      end
    # Queen capture with disambiguation
    elsif move.length == 5
      if !board_letters.include?(second_char) || !board_letters.include?(fourth_char)
        return false
      elsif third_char != "x"
        return false
      elsif !board_numbers.include?(fifth_char)
        return false
      end
    end

    return true
  end

  # Checks king moves for valid notation
  def valid_king_notation?(move)
    board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]

    first_char = move.slice(0)
    second_char = move.slice(1)
    third_char = move.slice(2)
    fourth_char = move.slice(3)

    # Move length must be 3 or 4 characters
    if !move.length.between?(3, 4)
      return false
    end

    # Regular king move
    if move.length == 3
      if !board_letters.include?(second_char)
        return false
      elsif !board_numbers.include?(third_char)
        return false
      end
    # King capture
    elsif move.length == 4
      if second_char != "x"
        return false
      elsif !board_letters.include?(third_char)
        return false
      elsif !board_numbers.include?(fourth_char)
        return false
      end
    end

    return true
  end

  # Returns true if move is legal to play on the board
  def legal_move?(move)
    move_type = get_move_type(move)
    destination_square = get_destination_square(move) # returns @board[5][4] for ex.
    capture = is_capture?(move)

    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty == true
          j += 1
          next
        elsif @board[i][j].empty == false && @board[i][j].piece.name == move_type &&
          @board[i][j].piece.color == @current_player
          if capture
            if check_attack_range(@board[i][j].piece, destination_square)
              return true
            end
          else
            if check_move_range(@board[i][j].piece, destination_square)
              return true
            end
          end
        end
        j += 1
      end
      i += 1
    end

    return false

  end

  # Takes a move in chess notation and returns the destination square
  # in board notation (e.g. @board[1][2])
  def get_destination_square(move)
    move_number = move[-1] # this is a number 1-8
    move_letter = move[-2] # this is a letter a-h

    if move_number == "8"
      move_row = 0
    elsif move_number == "7"
      move_row = 1
    elsif move_number == "6"
      move_row = 2
    elsif move_number == "5"
      move_row = 3
    elsif move_number == "4"
      move_row = 4
    elsif move_number == "3"
      move_row = 5
    elsif move_number == "2"
      move_row = 6
    elsif move_number == "1"
      move_row = 7
    end

    if move_letter == "a"
      move_col = 0
    elsif move_letter == "b"
      move_col = 1
    elsif move_letter == "c"
      move_col = 2
    elsif move_letter == "d"
      move_col = 3
    elsif move_letter == "e"
      move_col = 4
    elsif move_letter == "f"
      move_col = 5
    elsif move_letter == "g"
      move_col = 6
    elsif move_letter == "h"
      move_col = 7
    end

    return @board[move_row][move_col]
  end

  # Checks whether a move is a capture
  def is_capture?(move)
    if move.include?("x")
      return true
    else
      return false
    end
  end

  # Compares the destination square of a requested attack with 
  # the attack range stored in the piece being evaluated.
  # Returns true if the piece can make the capture requested.
  def check_attack_range(piece, destination_square)
    piece.attack_range.each do |square| # square is an array of coordinates e.g. [3, 3]
      if @board[destination_square.row][destination_square.col] == @board[square[0]][square[1]]
        return true
      end
    end
    return false
  end

  # Compares the destination square of the move requested with
  # the move range stored in the piece being evaluated.
  # Returns true if the piece can make the move requested.
  def check_move_range(piece, destination_square)
    piece.move_range.each do |square|
      if @board[destination_square.row][destination_square.col] == @board[square[0]][square[1]]
        return true
      end
    end
    return false
  end

  # Finds the starting square for the move that is to be made.
  def get_starting_square(move)
    move_type = get_move_type(move) # returns a string "Knight", etc. 
    destination_square = get_destination_square(move) # returns something like @board[3][4]
    
    i = 0 # row
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty
          j += 1
          next
        elsif @board[i][j].empty == false && @board[i][j].piece.color == @current_player &&
          @board[i][j].piece.name == move_type
          if is_capture?(move)
            if check_attack_range(@board[i][j].piece, destination_square)
              if move_type == "WhitePawn" || move_type == "BlackPawn"
                if get_pawn_column(move) == j # I may have to expand this type of logic later for other disambiguations.
                  return @board[i][j]
                end
              else
                return @board[i][j]
              end
            end
          else
            if check_move_range(@board[i][j].piece, destination_square)
              return @board[i][j]
            end
          end
        end
        j += 1
      end
      i += 1
    end
  end

  # Gets the type of the piece being moved. Returns a string that matches the class names.
  def get_move_type(move)
    first_letter = move.slice(0)

    if first_letter == "N"
      move_type = "Knight"
    elsif first_letter == "B"
      move_type = "Bishop"
    elsif first_letter == "R"
      move_type = "Rook"
    elsif first_letter == "Q"
      move_type = "Queen"
    elsif first_letter == "K"
      move_type = "King"
    else
      if @current_player == "white"
        move_type = "WhitePawn"
      elsif @current_player == "black"
        move_type = "BlackPawn"
      end
    end

    return move_type
  end

  # Takes a pawn move in chess notation
  # Returns the pawn's original column in board notation
  # Used to make sure the correct pawn is used in pawn captures
  def get_pawn_column(pawn_move)
    pawn_letter = pawn_move.slice(0)

    if pawn_letter == "a"
      pawn_col = 0
    elsif pawn_letter == "b"
      pawn_col = 1
    elsif pawn_letter == "c"
      pawn_col = 2
    elsif pawn_letter == "d"
      pawn_col = 3
    elsif pawn_letter == "e"
      pawn_col = 4
    elsif pawn_letter == "f"
      pawn_col = 5
    elsif pawn_letter == "g"
      pawn_col = 6
    elsif pawn_letter == "h"
      pawn_col = 7
    end

    return pawn_col
  end

  # Makes a move on the board.
  def make_move(move)
    starting_square = get_starting_square(move)
    destination_square = get_destination_square(move)

    destination_square.empty = false
    destination_square.piece = starting_square.piece
    destination_square.piece.row = destination_square.row
    destination_square.piece.col = destination_square.col
    destination_square.image = starting_square.image

    starting_square.empty = true
    starting_square.piece = nil
    starting_square.image = " "
  end

  def switch_player
    if @current_player == "white"
      @current_player = "black"
    elsif @current_player == "black"
      @current_player = "white"
    end
  end

  def update_move_attack_ranges(board)
    @white_pieces.each do |piece|
      piece.board = board
      piece.move_range = piece.set_move_range(piece.row, piece.col, piece.board)
      piece.attack_range = piece.set_attack_range(piece.row, piece.col, piece.board)
    end

    @black_pieces.each do |piece|
      piece.board = board
      piece.move_range = piece.set_move_range(piece.row, piece.col, piece.board)
      piece.attack_range = piece.set_attack_range(piece.row, piece.col, piece.board)
    end
  end

end

game = Game.new
game.play
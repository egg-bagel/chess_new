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
    elsif (row - 1) >= 0
      legal_moves.push([row - 1, col]) if board[row - 1][col].empty == true
    end

    return legal_moves
  end

  # Sets the range of legal attacks for a white pawn
  def set_attack_range(row, col, board, move_log, move_log_starting_squares)
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

    # En passant captures
    if move_log && move_log_starting_squares
      if row == 3 && (col + 1) <= 7
        if (board[row][col + 1].empty == false) && (board[row][col + 1].piece.name == "BlackPawn") &&
          move_log[-1] == "#{col_to_chess_notation(col + 1)}5" && move_log_starting_squares[-1][0] == 1 &&
          move_log_starting_squares[-1][1] == col + 1
          legal_captures.push([row - 1, col + 1])
        end
      end

      if row == 3 && (col - 1) >= 0
        if (board[row][col - 1].empty == false) && (board[row][col - 1].piece.name == "BlackPawn") &&
          move_log[-1] == "#{col_to_chess_notation(col - 1)}5" && move_log_starting_squares[-1][0] == 1 &&
          move_log_starting_squares[-1][1] == col - 1
          legal_captures.push([row - 1, col - 1])
        end
      end
    end

    return legal_captures
  end

  # Takes an integer column and returns the corresponding string letter in chess notation.
  # Used to determine whether en passant capture is legal.
  def col_to_chess_notation(col)
    if col == 0
      return "a"
    elsif col == 1
      return "b"
    elsif col == 2
      return "c"
    elsif col == 3
      return "d"
    elsif col == 4
      return "e"
    elsif col == 5
      return "f"
    elsif col == 6
      return "g"
    elsif col == 7
      return "h"
    end
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
    elsif (row + 1) <= 7
      legal_moves.push([row + 1, col]) if board[row + 1][col].empty == true
    end

    return legal_moves
  end

  def set_attack_range(row, col, board, move_log, move_log_starting_squares)
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

    # En passant captures
    if move_log && move_log_starting_squares
      if row == 4 && (col + 1) <= 7
        if (board[row][col + 1].empty == false) && (board[row][col + 1].piece.name == "WhitePawn") &&
          move_log[-1] == "#{col_to_chess_notation(col + 1)}4" && move_log_starting_squares[-1][0] == 6 &&
          move_log_starting_squares[-1][1] == col + 1
          legal_captures.push([row + 1, col + 1])
        end
      end

      if row == 4 && (col - 1) >= 0
        if (board[row][col - 1].empty == false) && (board[row][col - 1].piece.name == "WhitePawn") &&
          move_log[-1] == "#{col_to_chess_notation(col - 1)}4" && move_log_starting_squares[-1][0] == 6 &&
          move_log_starting_squares[-1][1] == col - 1
          legal_captures.push([row + 1, col - 1])
        end
      end
    end

    return legal_captures
  end

    # Takes an integer column and returns the corresponding string letter in chess notation.
  # Used to determine whether en passant capture is legal.
  def col_to_chess_notation(col)
    if col == 0
      return "a"
    elsif col == 1
      return "b"
    elsif col == 2
      return "c"
    elsif col == 3
      return "d"
    elsif col == 4
      return "e"
    elsif col == 5
      return "f"
    elsif col == 6
      return "g"
    elsif col == 7
      return "h"
    end
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
      elsif board[i + 1][j + 1].piece.color == @color
        blocked = true
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
      elsif board[i + 1][j - 1].piece.color == @color
        blocked = true
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
      elsif board[i - 1][j + 1].piece.color == @color
        blocked = true
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
      elsif board[i - 1][j - 1].piece.color == @color
        blocked = true
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
      elsif board[i + 1][col].piece.color == @color
        blocked = true
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
      elsif board[i - 1][col].piece.color == @color
        blocked = true
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
      elsif board[row][i + 1].piece.color == @color
        blocked = true
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
      elsif board[row][i - 1].piece.color == @color
        blocked = true
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
      elsif board[i + 1][j + 1].piece.color == @color
        blocked = true
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
      elsif board[i + 1][j - 1].piece.color == @color
        blocked = true
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
      elsif board[i - 1][j + 1].piece.color == @color
        blocked = true
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
      elsif board[i - 1][j - 1].piece.color == @color
        blocked = true
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
      elsif board[i + 1][col].piece.color == @color
        blocked = true
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
      elsif board[i - 1][col].piece.color == @color
        blocked = true
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
      elsif board[row][i + 1].piece.color == @color
        blocked = true
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
      elsif board[row][i - 1].piece.color == @color
        blocked = true
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

  attr_accessor :board, :white_pieces, :black_pieces, :move_log, :move_log_starting_squares

  def initialize
    @board = create_board
    @white_pieces = []
    @black_pieces = []
    set_up_board(@board)
    @current_player = "white"
    @move_log = []
    @move_log_starting_squares = []
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
      if piece.name == "WhitePawn" || piece.name == "BlackPawn"
        piece.attack_range = piece.set_attack_range(piece.row, piece.col, piece.board, @move_log, @move_log_starting_squares)
      else
        piece.attack_range = piece.set_attack_range(piece.row, piece.col, piece.board)
      end
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
    print_board
    while checkmate? == false && stalemate? == false && insufficient_material? == false
      # Gets a legal move in valid chess notation
      move = prompt_for_move

      # Check that the move does not leave the player's king in check
      # Castling is excluded because it is already checked for check in the legal_move? method called in prompt_for_move.
      if move != "O-O" && move != "O-O-O" && move != "0-0" && move != "0-0-0"
        while leaves_king_in_check?(move)
          puts "That move leaves your king in check. Try another move."
          move = prompt_for_move
        end
      end

      # Make the move, with special methods for castling
      if move == "O-O" || move == "0-0"
        castle_kingside
      elsif move == "O-O-O" || move == "0-0-0"
        castle_queenside
      else
        @move_log << move
        if move == "O-O" || move == "0-0" || move == "O-O-O" || move == "0-0-0"
          @move_log_starting_squares << move
        else
          @move_log_starting_squares << [get_starting_square(move)[0], get_starting_square(move)[1]]
        end
        make_move(get_starting_square(move), get_destination_square(move), move)
      end

      print_board
      update_move_attack_ranges
      switch_player
    end

    if checkmate? == true
      if @current_player == "white"
        puts "Checkmate! Black wins the game!"
      elsif @current_player == "black"
        puts "Checkmate! White wins the game!"
      end
    elsif stalemate? == true
      puts "The game has ended in a draw by stalemate."
    elsif insufficient_material? == true
      puts "The game has ended in a draw because neither side has enough material to force a checkmate."
    end
  end

  # Prompts the player to enter a legal move in valid chess notation.
  def prompt_for_move
    if @current_player == "white"
      puts "White to play."
    else
      puts "Black to play."
    end
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

    # castling is a valid move that falls into none of the categories below
    if move == "O-O" || move == "0-0" || move == "O-O-O" || move == "0-0-0"
      return true
    end

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
    pawn_numbers = ["2", "3", "4", "5", "6", "7"]
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
      if !second_char.to_i.between?(2, 7)
        return false
      end
    # Push a pawn to promotion
    elsif move.length == 3 
      if second_char != "8" && second_char != "1"
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
      elsif fourth_char != "8" && fourth_char != "1"
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
      # If the second letter is not "x" or a valid board letter or number
      if second_char != "x" && !board_letters.include?(second_char) && !board_numbers.include?(second_char)
        return false
      # If the third letter is not a valid board letter
      elsif !board_letters.include?(third_char) 
        return false
      # If, in the case of a letter-based disambiguation (e.g. Nfg5), 
      # if the second board letter is an impossible distance from the first
      elsif second_char != "x" && board_letters.include?(second_char)
        if board_letters.index(third_char) != (board_letters.index(second_char) + 1) &&
          board_letters.index(third_char) != (board_letters.index(second_char) + 2) &&
          board_letters.index(third_char) != (board_letters.index(second_char) - 1) &&
          board_letters.index(third_char) != (board_letters.index(second_char) - 2)
          return false
        end
      # If, in the case of a number-based disambiguation (e.g. N3e5)
      # if the second board number is an impossible distance from the first
      elsif second_char != "x" && board_numbers.include?(second_char)
        if board_numbers.index(fourth_char) != (board_numbers.index(second_char) + 1) &&
          board_numbers.index(fourth_char) != (board_numbers.index(second_char) + 2) &&
          board_numbers.index(fourth_char) != (board_numbers.index(second_char) - 1) &&
          board_numbers.index(fourth_char) != (board_numbers.index(second_char) - 2)
          return false
        end
      # If the last character is not a valid board number
      elsif !board_numbers.include?(fourth_char) 
        return false
      end
    # Capture with disambiguation
    elsif move.length == 5 
      # if the second character is not a valid board letter (e.g. Nbxc4) or number (e.g. N3xe4)
      if !board_letters.include?(second_char) && !board_numbers.include?(second_char)
        return false
      # if the third character is not a capture
      elsif third_char != "x"
        return false
      # In the case of a letter-based disambiguation,
      # if the second board letter is an impossible distance from the first
      elsif board_letters.include?(second_char)
        if board_letters.index(fourth_char) != (board_letters.index(second_char) + 1) &&
          board_letters.index(fourth_char) != (board_letters.index(second_char) + 2) &&
          board_letters.index(fourth_char) != (board_letters.index(second_char) - 1) &&
          board_letters.index(fourth_char) != (board_letters.index(second_char) - 2)
          return false
        end
      # In the case of a number-based disambiguation,
      # if the second board number is an impossible distance from the first
      elsif board_numbers.include?(second_char)
        if board_numbers.index(fifth_char) != (board_numbers.index(second_char) + 1) &&
          board_numbers.index(fifth_char) != (board_numbers.index(second_char) + 2) &&
          board_numbers.index(fifth_char) != (board_numbers.index(second_char) - 1) &&
          board_numbers.index(fifth_char) != (board_numbers.index(second_char) - 2)
          return false
        end
      # If the last character is not a valid board number
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
      if second_char != "x" && !board_letters.include?(second_char) && !board_numbers.include?(second_char)
        return false
      elsif !board_letters.include?(third_char)
        return false
      elsif !board_numbers.include?(fourth_char)
        return false
      end
    # Capture with disambiguation
    elsif move.length == 5
      if !board_letters.include?(second_char) && !board_numbers.include?(second_char)
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
      if !board_letters.include?(second_char) && !board_numbers.include?(second_char)
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
      if second_char != "x" && !board_letters.include?(second_char) && !board_numbers.include?(second_char)
        return false
      elsif !board_letters.include?(third_char)
        return false
      elsif !board_numbers.include?(fourth_char)
        return false
      end
    # Queen capture with disambiguation
    elsif move.length == 5
      if !board_letters.include?(second_char) || !board_numbers.include?(second_char)
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
    if move_type != "castle kingside" && move_type != "castle queenside"
      destination_square = get_destination_square(move) # returns [a, b]
      puts "destination square is #{destination_square}"
      capture = is_capture?(move)
    end

    # if castle kingside
    if move_type == "castle kingside"

      if @current_player == "white"
        # Check that f1 and g1 are empty, the king is on e1, and the rook is on h1.
        if @board[7][5].empty && @board[7][6].empty && 
          @board[7][4].piece.name == "King" && @board[7][4].piece.color == @current_player &&
          @board[7][7].piece.name == "Rook" && @board[7][7].piece.color == @current_player
          
          # Check that e1, f1, and g1 are all out of range of check.
          i = 0
          while i <= 7
            j = 0
            while j <= 7
              if @board[i][j].empty || @board[i][j].piece.color == "white"
                j += 1
                next
              elsif @board[i][j].piece.color == "black"
                if @board[i][j].piece.attack_range.include?([7, 4]) || @board[i][j].piece.move_range.include?([7, 5]) ||
                  @board[i][j].piece.move_range.include?([7, 6])
                  return false
                end
              end
              j += 1
            end
            i += 1
          end

          # Check that the king and the rook have not been moved yet.
          i = 0
          while i < @move_log.length
            if @move_log[i].slice(0) == "K"
              return false
            elsif @move_log[i].slice(0) == "R"
              if @move_log_starting_squares[i] == [7, 7]
                return false
              end
            end
            i += 2
          end
        else
          return false
        end

        return true

      elsif @current_player == "black"
        # Check that f8 and g8 are empty, the king is on e8, and the rook is on h8.
        if @board[0][5].empty && @board[0][6].empty && 
          @board[0][4].piece.name == "King" && @board[0][4].piece.color == @current_player &&
          @board[0][7].piece.name == "Rook" && @board[0][7].piece.color == @current_player
          
          # Check that e1, f1, and g1 are all out of range of check.
          i = 0
          while i <= 7
            j = 0
            while j <= 7
              if @board[i][j].empty || @board[i][j].piece.color == "black"
                j += 1
                next
              elsif @board[i][j].piece.color == "white"
                if @board[i][j].piece.attack_range.include?([0, 4]) || @board[i][j].piece.move_range.include?([0, 5]) ||
                  @board[i][j].piece.move_range.include?([0, 6])
                  return false
                end
              end
              j += 1
            end
            i += 1
          end

          # Check that the king and the rook have not been moved yet.
          i = 1
          while i < @move_log.length
            if @move_log[i].slice(0) == "K"
              return false
            elsif @move_log[i].slice(0) == "R"
              if @move_log_starting_squares[i] == [0, 7]
                return false
              end
            end
            i += 2
          end
        else
          return false
        end

        return true
      end

    # if castle queenside
    elsif move_type == "castle queenside"

      if @current_player == "white"
        # Check that d1, c1, and b1 are empty, the king is on e1, and the rook is on a1.
        if @board[7][1].empty && @board[7][2].empty && @board[7][3].empty &&
          @board[7][4].piece.name == "King" && @board[7][4].piece.color == @current_player &&
          @board[7][0].piece.name == "Rook" && @board[7][0].piece.color == @current_player
          
          # Check that e1, d1, c1, and b1 are all out of range of check.
          i = 0
          while i <= 7
            j = 0
            while j <= 7
              if @board[i][j].empty || @board[i][j].piece.color == "white"
                j += 1
                next
              elsif @board[i][j].piece.color == "black"
                if @board[i][j].piece.attack_range.include?([7, 4]) || @board[i][j].piece.move_range.include?([7, 3]) ||
                  @board[i][j].piece.move_range.include?([7, 2]) || @board[i][j].piece.move_range.include?([7, 1])
                  return false
                end
              end
              j += 1
            end
            i += 1
          end

          # Check that the king and the rook have not been moved yet.
          i = 0
          while i < @move_log.length
            if @move_log[i].slice(0) == "K"
              return false
            elsif @move_log[i].slice(0) == "R"
              if @move_log_starting_squares[i] == [7, 0]
                return false
              end
            end
            i += 2
          end
        else
          return false
        end

        return true

      elsif @current_player == "black"
        # Check that d8, c8, and b8 are empty, the king is on e8, and the rook is on a8.
        if @board[0][3].empty && @board[0][2].empty && @board[0][1].empty &&
          @board[0][4].piece.name == "King" && @board[0][4].piece.color == @current_player &&
          @board[0][0].piece.name == "Rook" && @board[0][0].piece.color == @current_player
          
          # Check that d8, c8, and b8 are all out of range of check.
          i = 0
          while i <= 7
            j = 0
            while j <= 7
              if @board[i][j].empty || @board[i][j].piece.color == "black"
                j += 1
                next
              elsif @board[i][j].piece.color == "white"
                if @board[i][j].piece.attack_range.include?([0, 4]) || @board[i][j].piece.move_range.include?([0, 3]) ||
                  @board[i][j].piece.move_range.include?([0, 2]) || @board[i][j].piece.move_range.include?([0, 1])
                  return false
                end
              end
              j += 1
            end
            i += 1
          end

          # Check that the king and the rook have not been moved yet.
          i = 1
          while i < @move_log.length
            if @move_log[i].slice(0) == "K"
              return false
            elsif @move_log[i].slice(0) == "R"
              if @move_log_starting_squares[i] == [0, 0]
                return false
              end
            end
            i += 2
          end
        else
          return false
        end

        return true
      end

    # If any move other than castling
    else
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
    end

    return false

  end

  # Takes a move in chess notation and returns the destination square
  # as an array of coordinates (e.g. [4, 5])
  def get_destination_square(move)
    if move[-1] != "Q" && move[-1] != "R" && move[-1] != "B" && move[-1] != "N"
      move_number = move[-1] # this is a number 1-8
      move_letter = move[-2] # this is a letter a-h
    else
      move_number = move[-2]
      move_letter = move[-3]
    end

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

    return [move_row, move_col]
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
    if piece.attack_range.include?(destination_square)
      return true
    else
      return false
    end
  end

  # Compares the destination square of the move requested with
  # the move range stored in the piece being evaluated.
  # Returns true if the piece can make the move requested.
  def check_move_range(piece, destination_square)
    if piece.move_range.include?(destination_square)
      return true
    else
      return false
    end
  end

  # Finds the starting square for the move that is to be made.
  # Returns the starting square as an array of coordinates [a, b].
  # PROBLEM: 
  def get_starting_square(move)
    move_type = get_move_type(move) # returns a string "Knight", etc. 
    destination_square = get_destination_square(move) # returns something like [3, 4]

    if move_type != "WhitePawn" && move_type != "BlackPawn" && move_type != "King"
      disambig = is_disambig?(move)
    end

    if disambig
      # how to search the board if the move contains a disambiguation
      board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
      board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
      second_char = move.slice(1)

      if board_letters.include?(second_char) # search only the given column for the piece
        col = letter_to_col(second_char)
        i = 0
        while i <= 7
          if @board[i][col].empty
            i += 1
            next
          elsif @board[i][col].empty == false && @board[i][col].piece.color == @current_player &&
            @board[i][col].piece.name == move_type
            if is_capture?(move)
              if check_attack_range(@board[i][col].piece, destination_square)
                return [i, col]
              end
            else
              if check_move_range(@board[i][col].piece, destination_square)
                return [i, col]
              end
            end
          end
          i += 1
        end

      elsif board_numbers.include?(second_char) # search only the given row for the piece
        row = number_to_row(second_char)
        i = 0
        while i <= 7
          if @board[row][i].empty
            i += 1
            next
          elsif @board[row][i].empty == false && @board[row][i].piece.color == @current_player &&
            @board[row][i].piece.name == move_type
            if is_capture?(move)
              if check_attack_range(@board[row][i].piece, destination_square)
                return [row, i]
              end
            else
              if check_move_range(@board[row][i].piece, destination_square)
                return [row, i]
              end
            end
          end
          i += 1
        end
      end

    else
      # search the whole board if the move does not contain a disambiguation
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
                  if get_pawn_column(move) == j # Make sure to use the right pawn if more than one could capture
                    return [i, j]
                  end
                else
                  return [i, j]
                end
              end
            else
              if check_move_range(@board[i][j].piece, destination_square)
                return [i, j]
              end
            end
          end
          j += 1
        end
        i += 1
      end
    end
  end

  # Returns true if a given move contains a disambiguation (e.g. Ngxe5 or R1d4)
  def is_disambig?(move)
    board_letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    board_numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
    second_char = move.slice(1)

    if move.length > 3 && (board_letters.include?(second_char) || board_numbers.include?(second_char))
      return true
    else
      return false
    end
  end

  # Gets the type of the piece being moved. Returns a string that matches the class names.
  def get_move_type(move)
    first_letter = move.slice(0)

    if move == "O-O"
      move_type = "castle kingside"
    elsif move == "0-0"
      move_type = "castle kingside"
    elsif move == "O-O-O"
      move_type = "castle queenside"
    elsif move == "0-0-0"
      move_type = "castle queenside"
    elsif first_letter == "N"
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

  # Takes a one-letter string and returns the corresponding column number on the board
  def letter_to_col(letter)
    if letter == "a"
      return 0
    elsif letter == "b"
      return 1
    elsif letter == "c"
      return 2
    elsif letter == "d"
      return 3
    elsif letter == "e"
      return 4
    elsif letter == "f"
      return 5
    elsif letter == "g"
      return 6
    elsif letter == "h"
      return 7
    end
  end

  # Takes a number string and returns the corresponding row number on the board
  def number_to_row(number)
    if number == "1"
      return 7
    elsif number == "2"
      return 6
    elsif number == "3"
      return 5
    elsif number == "4"
      return 4
    elsif number == "5"
      return 3
    elsif number == "6"
      return 2
    elsif number == "7"
      return 1
    elsif number == "8"
      return 0
    end
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
  def make_move(starting_square, destination_square, move)

    # If the move is an en passant capture
    if en_passant?(starting_square, destination_square, move)
      if get_move_type(move) == "WhitePawn"
        @board[destination_square[0] + 1][destination_square[1]].empty = true
        @board[destination_square[0] + 1][destination_square[1]].piece = nil
        @board[destination_square[0] + 1][destination_square[1]].image = " "
      elsif get_move_type(move) == "BlackPawn"
        @board[destination_square[0] - 1][destination_square[1]].empty = true
        @board[destination_square[0] - 1][destination_square[1]].piece = nil
        @board[destination_square[0] - 1][destination_square[1]].image = " "
      end
    end

    # If the move is a pawn promotion
    if pawn_promotion?(starting_square, destination_square, move)

      if move[-1] == "Q"
        @board[destination_square[0]][destination_square[1]].piece = Queen.new(destination_square[0], destination_square[1], @current_player)
        @board[destination_square[0]][destination_square[1]].image = @board[destination_square[0]][destination_square[1]].piece.image
        @board[destination_square[0]][destination_square[1]].empty = false
      elsif move[-1] == "R"
        @board[destination_square[0]][destination_square[1]].piece = Rook.new(destination_square[0], destination_square[1], @current_player)
        @board[destination_square[0]][destination_square[1]].image = @board[destination_square[0]][destination_square[1]].piece.image
        @board[destination_square[0]][destination_square[1]].empty = false
      elsif move[-1] == "B"
        @board[destination_square[0]][destination_square[1]].piece = Bishop.new(destination_square[0], destination_square[1], @current_player)
        @board[destination_square[0]][destination_square[1]].image = @board[destination_square[0]][destination_square[1]].piece.image
        @board[destination_square[0]][destination_square[1]].empty = false
      elsif move[-1] == "N"
        @board[destination_square[0]][destination_square[1]].piece = Knight.new(destination_square[0], destination_square[1], @current_player)
        @board[destination_square[0]][destination_square[1]].image = @board[destination_square[0]][destination_square[1]].piece.image
        @board[destination_square[0]][destination_square[1]].empty = false
      end

      @board[starting_square[0]][starting_square[1]].empty = true
      @board[starting_square[0]][starting_square[1]].piece = nil
      @board[starting_square[0]][starting_square[1]].image = " "
    
    # If the move is not a pawn promotion
    else
      @board[destination_square[0]][destination_square[1]].empty = false
      @board[destination_square[0]][destination_square[1]].piece = @board[starting_square[0]][starting_square[1]].piece
      @board[destination_square[0]][destination_square[1]].piece.row = @board[destination_square[0]][destination_square[1]].row
      @board[destination_square[0]][destination_square[1]].piece.col = @board[destination_square[0]][destination_square[1]].col
      @board[destination_square[0]][destination_square[1]].image = @board[starting_square[0]][starting_square[1]].image

      @board[starting_square[0]][starting_square[1]].empty = true
      @board[starting_square[0]][starting_square[1]].piece = nil
      @board[starting_square[0]][starting_square[1]].image = " "
    end
  end

  # Returns true if the move is an en passant capture.
  def en_passant?(starting_square, destination_square, move)

    if get_move_type(move) == "WhitePawn"
      if starting_square[0] == 3 && is_capture?(move) && @board[destination_square[0]][destination_square[1]].empty
        return true
      else
        return false
      end
    elsif get_move_type(move) == "BlackPawn"
      if starting_square[0] == 4 && is_capture?(move) && @board[destination_square[0]][destination_square[1]].empty
        return true
      else
        return false
      end

      return false
    end

    return false
  end

  # Returns true if the move is a pawn promotion.
  def pawn_promotion?(starting_square, destination_square, move)
    if get_move_type(move) == "WhitePawn"
      if starting_square[0] == 1 && destination_square[0] == 0
        return true
      else
        return false
      end
    elsif get_move_type(move) == "BlackPawn"
      if starting_square[0] == 6 && destination_square[0] == 7
        return true
      else
        return false
      end
    end

    return false
  end

  # Special method for making the castle kingside move
  def castle_kingside
    if @current_player == "white"
      # move the king
      @board[7][6].empty = false
      @board[7][6].piece = @board[7][4].piece
      @board[7][6].piece.row = 7
      @board[7][6].piece.col = 6
      @board[7][6].image = @board[7][4].image

      @board[7][4].empty = true
      @board[7][4].piece = nil
      @board[7][4].image = " "

      # move the rook
      @board[7][5].empty = false
      @board[7][5].piece = @board[7][7].piece
      @board[7][5].piece.row = 7
      @board[7][5].piece.col = 5
      @board[7][5].image = @board[7][7].image

      @board[7][7].empty = true
      @board[7][7].piece = nil
      @board[7][7].image = " "

    elsif @current_player == "black"
      # move the king
      @board[0][6].empty = false
      @board[0][6].piece = @board[0][4].piece
      @board[0][6].piece.row = 0
      @board[0][6].piece.col = 6
      @board[0][6].image = @board[0][4].image

      @board[0][4].empty = true
      @board[0][4].piece = nil
      @board[0][4].image = " "

      # move the rook
      @board[0][5].empty = false
      @board[0][5].piece = @board[0][7].piece
      @board[0][5].piece.row = 0
      @board[0][5].piece.col = 5
      @board[0][5].image = @board[0][7].image

      @board[0][7].empty = true
      @board[0][7].piece = nil
      @board[0][7].image = " "
    end
  end

  # Special method for making the castle queenside move
  def castle_queenside
    if @current_player == "white"
      # move the king
      @board[7][2].empty = false
      @board[7][2].piece = @board[7][4].piece
      @board[7][2].piece.row = 7
      @board[7][2].piece.col = 2
      @board[7][2].image = @board[7][4].image

      @board[7][4].empty = true
      @board[7][4].piece = nil
      @board[7][4].image = " "

      # move the rook
      @board[7][3].empty = false
      @board[7][3].piece = @board[7][0].piece
      @board[7][3].piece.row = 7
      @board[7][3].piece.col = 3
      @board[7][3].image = @board[7][0].image

      @board[7][0].empty = true
      @board[7][0].piece = nil
      @board[7][0].image = " "
      
    elsif @current_player == "black"
      # move the king
      @board[0][2].empty = false
      @board[0][2].piece = @board[0][4].piece
      @board[0][2].piece.row = 0
      @board[0][2].piece.col = 2
      @board[0][2].image = @board[0][4].image

      @board[0][4].empty = true
      @board[0][4].piece = nil
      @board[0][4].image = " "

      # move the rook
      @board[0][3].empty = false
      @board[0][3].piece = @board[0][0].piece
      @board[0][3].piece.row = 0
      @board[0][3].piece.col = 3
      @board[0][3].image = @board[0][0].image

      @board[0][0].empty = true
      @board[0][0].piece = nil
      @board[0][0].image = " "
    end
  end

  # Undoes a move on the board.
  # Uses the starting square and destination square of the move just made.
  # NOTE: PROBABLY WON'T END UP NEEDING TO USE THIS METHOD
  # Using marshal instead to make a deep copy of the board,
  # this undo method doesn't work for undoing captures
  def undo_move(starting_square, destination_square)

    starting_square.empty = false
    starting_square.piece = destination_square.piece
    starting_square.piece.row = starting_square.row
    starting_square.piece.col = starting_square.col
    starting_square.image = destination_square.image

    # PROBLEM HERE
    # If the last move was a capture, I need to put the old piece back on the destination square.
    # But this method sets the destination square to always be empty after the undo.
    destination_square.empty = true
    destination_square.piece = nil
    destination_square.image = " "
  end

  # Toggles @current_player between black and white
  def switch_player
    if @current_player == "white"
      @current_player = "black"
    elsif @current_player == "black"
      @current_player = "white"
    end
  end

  # Updates the move range and attack range for every piece
  def update_move_attack_ranges

    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty
          j += 1
          next
        elsif @board[i][j].piece.name == "WhitePawn" || @board[i][j].piece.name == "BlackPawn"
          @board[i][j].piece.board = @board
          @board[i][j].piece.move_range = @board[i][j].piece.set_move_range(@board[i][j].piece.row, @board[i][j].piece.col, @board[i][j].piece.board)
          @board[i][j].piece.attack_range = @board[i][j].piece.set_attack_range(@board[i][j].piece.row, @board[i][j].piece.col, @board[i][j].piece.board, @move_log, @move_log_starting_squares)
        else
          @board[i][j].piece.board = @board
          @board[i][j].piece.move_range = @board[i][j].piece.set_move_range(@board[i][j].piece.row, @board[i][j].piece.col, @board[i][j].piece.board)
          @board[i][j].piece.attack_range = @board[i][j].piece.set_attack_range(@board[i][j].piece.row, @board[i][j].piece.col, @board[i][j].piece.board)
        end
        j += 1
      end
      i += 1
    end

  end

  # Evaluates whether a move leaves the player's king in check
  def leaves_king_in_check?(move)
    board_save = Marshal.load(Marshal.dump(@board))
    starting_square = get_starting_square(move)
    destination_square = get_destination_square(move)
    make_move(starting_square, destination_square, move)
    update_move_attack_ranges
    king_square = find_king_square

    i = 0
    while i <= 7
      j = 0
      while j <= 7
        # Whenever I find a piece on the board that is not the color of @current_player,
        # look at its attack range and see if king_square is included.
        if @board[i][j].empty == true || @board[i][j].piece.color == @current_player
          j += 1
          next
        elsif @board[i][j].piece.color != @current_player
          if @board[i][j].piece.attack_range.include?(king_square)
            @board = board_save
            update_move_attack_ranges
            return true
          end
        end
        j += 1
      end
      i += 1
    end

    @board = board_save
    update_move_attack_ranges
    return false
  end

  # Evaluates whether the current player is in check (without evaluating a move to be made)
  def is_check?
    king_square = find_king_square

    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty == true || @board[i][j].piece.color == @current_player
          j += 1
          next
        elsif @board[i][j].piece.color != @current_player
          if @board[i][j].piece.attack_range.include?(king_square)
            return true
          end
        end
        j += 1
      end
      i += 1
    end

    return false
  end

  # Finds the square the current player's king is on
  # Returns an array of coordinates [i, j]
  def find_king_square
    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty == true
          j += 1
          next
        elsif @board[i][j].piece.name == "King" && @board[i][j].piece.color == @current_player
          return [i, j]
        end
        j += 1
      end
      i += 1
    end
  end

  # Evaluates whether the current player's king is in checkmate.
  def checkmate?
    if is_check?
      if no_safe_squares? && can_capture? == false && can_interpose? == false
        return true
      end
    end

    return false
  end

  # Evaluates whether the current position is a stalemate.
  def stalemate?

    if is_check? == false && no_safe_squares?

      i = 0
      while i <= 7
        j = 0
        while j <= 7
          if @board[i][j].empty || @board[i][j].piece.color != @current_player
            j += 1
            next
          else
            # For each move in the non-empty move or attack range, check whether it would leave the king in check.
            # Return false only if at least one move does not leave the king in check.
            if @board[i][j].piece.name != "King" && !@board[i][j].piece.move_range.empty? 
              @board[i][j].piece.move_range.each do |coordinates|
                move = get_chess_notation_interpose(@board[i][j].piece, coordinates)
                if !leaves_king_in_check?(move)
                  return false
                end
              end
            elsif @board[i][j].piece.name != "King" && !@board[i][j].piece.attack_range.empty?
              @board[i][j].piece.attack_range each do |coordinates|
                move = get_chess_notation_capture(@board[i][j].piece, coordinates)
                if !leaves_king_in_check(move)
                  return false
                end
              end
            end
          end
          j += 1
        end
        i += 1
      end
    else
      return false
    end

    return true
  end

  # Sub-method to evaluate whether the king has any safe squares to move to.
  # Returns true if the king has no safe squares and false if the king has at least one safe square.
  def no_safe_squares?
    king_square = find_king_square # something like [1, 2]
    king_move_range = @board[king_square[0]][king_square[1]].piece.move_range # something like [[1, 2], [1, 3], [0, 0]]
    enemy_move_range = []

    # Get all the squares on the board covered by opposite-color pieces and put them in one big array.
    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty || @board[i][j].piece.color == @current_player
          j += 1
          next
        elsif @board[i][j].piece.color != @current_player
          # Pawns attack squares differently than the rest of the pieces
          if @board[i][j].piece.name == "WhitePawn"
            
            if i - 1 >= 0 && j + 1 <= 7
              if @board[i - 1][j + 1].empty
                enemy_move_range << [i - 1, j + 1]
              end
            end

            if i - 1 >= 0 && j - 1 >= 0
              if @board[i - 1][j - 1].empty
                enemy_move_range << [i - 1, j - 1]
              end
            end

          elsif @board[i][j].piece.name == "BlackPawn"

            if i + 1 <= 7 && j + 1 <= 7
              if @board[i + 1][j + 1].empty
                enemy_move_range << [i + 1, j + 1]
              end
            end

            if i + 1 <= 7 && j - 1 >= 0
              if @board[i + 1][j - 1].empty
                enemy_move_range << [i + 1, j - 1]
              end
            end

          else
            # The below only works for pieces that are not pawns
            @board[i][j].piece.move_range.each do |coordinates|
              enemy_move_range << coordinates
            end
          end
        end
        j += 1
      end
      i += 1
    end

    # Check each move in the king's move range and see if it is out of the enemy's range.
    king_move_range.each do |square|
      if !enemy_move_range.include?(square)
        return false
      end
    end

    return true
  end

  # Sub-method to see if the player can get out of check by capturing the attacking piece.
  def can_capture?
    king_square = find_king_square
    attacking_pieces = []
    # Find the piece(s) attacking the king.
    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty || @board[i][j].piece.color == @current_player
          j += 1
          next
        elsif @board[i][j].piece.color != @current_player
          if @board[i][j].piece.attack_range.include?(king_square)
            attacking_pieces << @board[i][j].piece
          end
        end
        j += 1
      end
      i += 1
    end

    # Can't capture if more than one piece is attacking the king.
    if attacking_pieces.length > 1
      return false
    else
      attacking_piece_square = [attacking_pieces[0].row, attacking_pieces[0].col]

      # Go through the board and see if the current player has any pieces
      # that could capture the attacking piece.
      i = 0
      while i <= 7
        j = 0
        while j <= 7
          if @board[i][j].empty || @board[i][j].piece.color != @current_player
            j += 1
            next
          elsif @board[i][j].piece.color == @current_player
            if @board[i][j].piece.attack_range.include?(attacking_piece_square)
              potential_capture_chess_notation = get_chess_notation_capture(@board[i][j].piece, attacking_piece_square)
              # Make sure the piece that could potentially capture the attacker is not pinned.
              if leaves_king_in_check?(potential_capture_chess_notation)
                j += 1
                next
              else
                return true
              end
            end
          end
          j += 1
        end
        i += 1
      end
    end

    return false
  end

  # Sub-method to see if the player can get out of check by interposing.
  def can_interpose?
    # Find the piece(s) attacking the king.
    king_square = find_king_square
    attacking_pieces = []

    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty || @board[i][j].piece.color == @current_player
          j += 1
          next
        elsif @board[i][j].piece.color != @current_player
          if @board[i][j].piece.attack_range.include?(king_square)
            attacking_pieces << @board[i][j].piece
          end
        end
        j += 1
      end
      i += 1
    end

    attacking_pieces.each do |piece|
    end

    # Not possible to interpose if more than one piece is attacking the king.
    if attacking_pieces.length > 1
      return false
    else
      # Not possible to interpose unless the attacking piece is a bishop, rook, or queen.
      if attacking_pieces[0].name != "Bishop" && attacking_pieces[0].name != "Rook" &&
        attacking_pieces[0].name != "Queen"
        return false
      else
        # Get the attack path.
        attacking_piece_square = [attacking_pieces[0].row, attacking_pieces[0].col]
        attack_path = get_attack_path(attacking_piece_square, king_square)

        # Go over the board again and look at the current player's pieces.
        # If any of the current player's pieces can move into the attack path, return true.
        attack_path.each do |square|
          i = 0
          while i <= 7
            j = 0
            while j <= 7
              if @board[i][j].empty || @board[i][j].piece.color != @current_player
                j += 1
                next
              elsif @board[i][j].piece.color == @current_player
                if @board[i][j].piece.name != "King" && @board[i][j].piece.move_range.include?(square)
                  # Make sure the piece that could potentially interpose is not pinned.
                  potential_interpose_chess_notation = get_chess_notation_interpose(@board[i][j].piece, square)
                  if leaves_king_in_check?(potential_interpose_chess_notation)
                    j += 1
                    next
                  else
                    return true
                  end
                end
              end
              j += 1
            end
            i += 1
          end
        end
      end
    end

    return false
  end

  # Sub-method called by the can_capture? method, which itself is called by the checkmate? method.
  # Here destination_square is an array of coordinates [a, b] of the piece attacking the king.
  def get_chess_notation_capture(piece, destination_square)
    if piece.name == "King"
      first_char = "K"
    elsif piece.name == "Queen"
      first_char = "Q"
    elsif piece.name == "Rook"
      first_char = "R"
    elsif piece.name == "Bishop"
      first_char = "B"
    elsif piece.name == "Knight"
      first_char = "N"
    elsif piece.name == "WhitePawn"
      first_char = col_to_chess_notation(piece.col)
    elsif piece.name == "BlackPawn"
      first_char = col_to_chess_notation(piece.col)
    end

    destination_row = row_to_chess_notation(destination_square[0])
    destination_col = col_to_chess_notation(destination_square[1])

    return "#{first_char}x#{destination_col}#{destination_row}"
  end

  # Sub-method called by the can_interpose? method.
  def get_chess_notation_interpose(piece, destination_square)
    if piece.name == "Queen"
      first_char = "Q"
    elsif piece.name == "Rook"
      first_char = "R"
    elsif piece.name == "Bishop"
      first_char = "B"
    elsif piece.name == "Knight"
      first_char = "N"
    elsif piece.name == "WhitePawn"
      first_char = col_to_chess_notation(piece.col)
    elsif piece.name == "BlackPawn"
      first_char = col_to_chess_notation(piece.col)
    end

    destination_row = row_to_chess_notation(destination_square[0])
    destination_col = col_to_chess_notation(destination_square[1])

    if piece.name == "WhitePawn" || piece.name == "BlackPawn"
      return "#{first_char}#{destination_row}"
    else
      return "#{first_char}#{destination_col}#{destination_row}"
    end
  end
  
  # Sub-sub-method that gets the attack path between the king and an attacking rook/bishop/queen.
  def get_attack_path(attacking_piece_square, king_square)
    attack_path = []

    # If the path is along a row
    if attacking_piece_square[0] == king_square[0]
      min = attacking_piece_square[1] < king_square[1] ? attacking_piece_square[1] : king_square[1]
      max = attacking_piece_square[1] > king_square[1] ? attacking_piece_square[1] : king_square[1]
      i = min + 1
      while i < max
        attack_path << [attacking_piece_square[0], i]
        i += 1
      end
    # If the path is along a col
    elsif attacking_piece_square[1] == king_square[1]
      min = attacking_piece_square[0] < king_square[0] ? attacking_piece_square[0] : king_square[0]
      max = attacking_piece_square[0] > king_square[0] ? attacking_piece_square[0] : king_square[0]
      i = min + 1
      while i < max
        attack_path << [i, attacking_piece_square[0]]
        i += 1
      end
    # If the path is along a diagonal
    else
      if attacking_piece_square[0] > king_square[0] && attacking_piece_square[1] > king_square[1]
        i = attacking_piece_square[0] - 1
        j = attacking_piece_square[1] - 1
        while i > king_square[0] && j > king_square[1]
          attack_path << [i, j]
          i -= 1
          j -= 1
        end
      elsif attacking_piece_square[0] > king_square[0] && attacking_piece_square[1] < king_square[1]
        i = attacking_piece_square[0] - 1
        j = attacking_piece_square[1] + 1
        while i > king_square[0] && j < king_square[1]
          attack_path << [i, j]
          i -= 1
          j += 1
        end
      elsif attacking_piece_square[0] < king_square[0] && attacking_piece_square[1] > king_square[1]
        i = attacking_piece_square[0] + 1
        j = attacking_piece_square[1] - 1
        while i < king_square[0] && j > king_square[1]
          attack_path << [i, j]
          i += 1
          j -= 1
        end
      elsif attacking_piece_square[0] < king_square[0] && attacking_piece_square[1] < king_square[1]
        i = attacking_piece_square[0] + 1
        j = attacking_piece_square[1] + 1
        while i < king_square[0] && j < king_square[1]
          attack_path << [i, j]
          i += 1
          j += 1
        end
      end
    end

    return attack_path
  end

  # Takes an integer column and returns the corresponding string letter for chess notation.
  def col_to_chess_notation(col)
    if col == 0
      return "a"
    elsif col == 1
      return "b"
    elsif col == 2
      return "c"
    elsif col == 3
      return "d"
    elsif col == 4
      return "e"
    elsif col == 5
      return "f"
    elsif col == 6
      return "g"
    elsif col == 7
      return "h"
    end
  end

  # Takes an integer row and returns the corresponding string number for chess notation.
  def row_to_chess_notation(row)
    if row == 0
      return "8"
    elsif row == 1
      return "7"
    elsif row == 2
      return "6"
    elsif row == 3
      return "5"
    elsif row == 4
      return "4"
    elsif row == 5
      return "3"
    elsif row == 6
      return "2"
    elsif row == 7
      return "1"
    end
  end

  # Returns true if there is insufficient material on the board for either player to checkmate the other.
  def insufficient_material?
    # Go over the whole board and put the black pieces in one array and the white pieces in another.
    all_white_pieces = []
    all_black_pieces = []

    # get arrays containing the names of all the pieces on the board
    i = 0
    while i <= 7
      j = 0
      while j <= 7
        if @board[i][j].empty
          j += 1
          next
        else
          if @board[i][j].piece.color == "white"
            all_white_pieces << @board[i][j].piece.name
          elsif @board[i][j].piece.color == "black"
            all_black_pieces << @board[i][j].piece.name
          end
        end
        j += 1
      end
      i += 1
    end

    # Return false if either side has more than 3 pieces on the board
    if all_white_pieces.length > 3 || all_black_pieces.length > 3 
      return false

    # If white has only a king
    elsif all_white_pieces.length == 1
      # If black has only a king
      if all_black_pieces.length == 1
        return true
      # If black has 2 pieces and they are a king/bishop or king/knight
      elsif all_black_pieces.length == 2
        if all_black_pieces.include?("Knight") || all_black_pieces.include?("Bishop")
          return true
        else
          return false
        end
      # If black has 3 pieces and they are king/knight/knight
      elsif all_black_pieces.length == 3
        if all_black_pieces.uniq.length == 2 && all_black_pieces.uniq.include?("Knight")
          return true
        else
          return false
        end
      else
        return false
      end

    # If white has two pieces on the board and the second piece is a knight or a bishop
    elsif all_white_pieces.length == 2 && (all_white_pieces.include?("Knight") || all_white_pieces.include?("Bishop"))
      # If black has only a king
      if all_black_pieces.length == 1
        return true
      # If black has 2 pieces and they are a king/bishop or king/knight
      elsif all_black_pieces.length == 2
        if all_black_pieces.include?("Knight") || all_black_pieces.include?("Bishop")
          return true
        else
          return false
        end
      else
        return false
      end
    
    # If white has a king and two knights
    elsif all_white_pieces.length == 3 && all_white_pieces.uniq.length == 2 && all_white_pieces.uniq.include?("Knight")
      if all_black_pieces.length == 1
        return true
      else
        return false
      end

    else
      return false
    end

  end

end

game = Game.new
game.play
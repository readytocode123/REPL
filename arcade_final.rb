require 'colorize'

# Clears the terminal screen.
def clear_screen
  system "clear"
end

# Displays the beginning of the game.
def start
  print "S".red + "I".green + "M".blue + "O".yellow + "N".red
  puts " G".green + "A".blue + "M".yellow + "E".red
  puts "----------"
  puts "Select Difficulty Level: " + "Easy".green + ", " "Normal ".yellow + "or " + "Legendary".red
  level = gets.chomp.capitalize
  level_selection(level)
end

# Level selection.
def level_selection(level)
  case level
  when "Easy"
    seconds = 3
  when "Normal"
    seconds = 2
  when "Legendary"
    seconds = 1
  else
    puts "Not a valid level. Try again."
    seconds = start
  end
  return seconds
end

# Start a new game.
def restart?
  puts "New Game?...(Y to continue, Q to quit)"
  input = gets.chomp.capitalize
  if input == "Y"
    clear_screen
    return true
  elsif input == "Q"
    clear_screen
    return false
  else
    puts "Not a valid input. Try again."
    restart?
  end
end

# Adds color to the player combination.
def color_identifier(combination)
  combination.map! do |color|
    case color
    when "Red"
      color = "Red".red
    when "Green"
      color = "Green".green
    when "Blue"
      color = "Blue".blue
    when "Yellow"
      color = "Yellow".yellow
    else
      return color
    end
  end
  return combination
end

# Shows the color combination.
def show_colors(color_combination, seconds)
  clear_screen
  puts "Memorize the color combination....."
  sleep 1
  clear_screen
  index = 0
  while index < color_combination.length
    puts ""
    puts color_combination[index]
    sleep(seconds)
    clear_screen
    unless color_combination[index + 1].eql? nil
      clear_screen
      sleep 0.5
      clear_screen
    end
    index += 1
  end
end

clear_screen
# Simulated Simon Game
random_combination = []
player_combination = []
continue = true
# Hash to represent the colors.
colors = ["Red".red, "Green".green, "Blue".blue, "Yellow".yellow]
#Start the game.
seconds = start
while continue
  # Generate the random color for the combination.
  random_combination.push(colors.sample)
  # Show the random color combination up to the moment.
  show_colors(random_combination, seconds)
  # Ask the user for a combination.
  puts "Enter the combination that was shown (Red, Green, Blue or Yellow - Q to quit):"
  # Update value of player combination.
  player_combination = color_identifier(gets.chomp.split(" ").map(&:capitalize))
  clear_screen
  # Quit if 'Q' is entered.
  if player_combination[0].to_s.capitalize == "Q"
    continue = false
  else
    # Compare if the arrays are equal.
    if player_combination.eql? random_combination
      # Player wins this round.
      puts "Good job!!!"
      puts "Next combination..."
      sleep 1
      clear_screen
    else
      puts "You Lose...".red
      puts "Original combination: " + random_combination.join(" ")
      if player_combination.respond_to? :join
        puts "Your combination: " + player_combination.join(" ")
      else
        puts "Your input was invalid."
      end
      continue = restart?
      # Wants to continue playing.
      if continue
        random_combination.clear
        seconds = start
      end
    end
  end
  # Clear the player combination for new input.
  player_combination.clear
end
puts "End of the game."
